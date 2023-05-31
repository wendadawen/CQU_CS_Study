// 数据缓存模块定义
module d_cache (
    // 时钟信号和复位信号
    input wire clk, rst,
    // MIPS处理器核心输入信号
    input         cpu_data_req     , // CPU数据请求信号，表示CPU正在请求访问数据缓存
    input         cpu_data_wr      , // CPU数据写信号，表示CPU正在执行一次数据写操作
    input  [1 :0] cpu_data_size    , // CPU数据大小，用于表示数据访问的字节大小（例如：00表示1字节，01表示2字节，10表示4字节）
    input  [31:0] cpu_data_addr    , // CPU数据访问地址
    input  [31:0] cpu_data_wdata   , // CPU数据写入的数据
    output [31:0] cpu_data_rdata   , // CPU从数据缓存读取的数据
    output        cpu_data_addr_ok , // CPU数据地址确认信号，表示地址访问已成功
    output        cpu_data_data_ok , // CPU数据读/写确认信号，表示数据读取或写入已成功

    // AXI接口输出信号
    output         cache_data_req     , // 缓存数据请求信号，表示缓存正在请求访问AXI总线
    output         cache_data_wr      , // 缓存数据写信号，表示缓存正在执行一次数据写操作
    output  [1 :0] cache_data_size    , // 缓存数据大小，用于表示数据访问的字节大小（例如：00表示1字节，01表示2字节，10表示4字节）
    output  [31:0] cache_data_addr    , // 缓存数据访问地址
    output  [31:0] cache_data_wdata   , // 缓存数据写入的数据
    input   [31:0] cache_data_rdata   , // 缓存从AXI总线读取的数据
    input          cache_data_addr_ok , // 缓存数据地址确认信号，表示地址访问已成功
    input          cache_data_data_ok   // 缓存数据读/写确认信号，表示数据读取或写入已成功
);
    // 写回实现：增加脏位

    // 读命中：直接返回cache内容。
    // 读缺失：访问内存，写入cache
    // 写命中：只写入cache。
    // 写缺失：访问内存，写入cache
    // 替换：dirty写入后再替换

    //Cache配置
    parameter  INDEX_WIDTH  = 10, OFFSET_WIDTH = 2;
    localparam TAG_WIDTH    = 32 - INDEX_WIDTH - OFFSET_WIDTH;
    localparam CACHE_DEEPTH = 1 << INDEX_WIDTH;
    
    //Cache存储单元
    reg                 cache_valid [CACHE_DEEPTH - 1 : 0];
    reg                 cache_dirty [CACHE_DEEPTH - 1 : 0];
    reg [TAG_WIDTH-1:0] cache_tag   [CACHE_DEEPTH - 1 : 0];
    reg [31:0]          cache_block [CACHE_DEEPTH - 1 : 0];

    //访问地址分解
    wire [OFFSET_WIDTH-1:0] offset; 
    wire [INDEX_WIDTH-1:0] index;
    wire [TAG_WIDTH-1:0] tag;
    
    assign offset = cpu_data_addr[OFFSET_WIDTH - 1 : 0];
    assign index = cpu_data_addr[INDEX_WIDTH + OFFSET_WIDTH - 1 : OFFSET_WIDTH];
    assign tag = cpu_data_addr[31 : INDEX_WIDTH + OFFSET_WIDTH];

    //访问Cache line
    wire c_valid;
    wire c_dirty;
    wire [TAG_WIDTH-1:0] c_tag;
    wire [31:0] c_block;

    assign c_valid = cache_valid[index];
    assign c_dirty = cache_dirty[index];
    assign c_tag   = cache_tag  [index];
    assign c_block = cache_block[index];

    //判断是否命中
    wire   hit, miss, dirty, clean;
    assign hit = c_valid & (c_tag == tag);  //cache line的valid位为1，且tag与地址中tag相等
    assign miss = ~hit;
    assign dirty = c_valid & c_dirty;
    assign clean = ~dirty;
  
    //读或写
    wire read, write;
    assign write = cpu_data_wr;
    assign read = ~write;

    //FSM
    parameter IDLE = 2'b00, RM = 2'b01, WM = 2'b11;
    reg [1:0] state;
    always @(posedge clk) begin
        if(rst) begin
            state <= IDLE;
        end
        else begin
            case(state)
                IDLE:   state <= cpu_data_req & hit ? IDLE :
                                 cpu_data_req & miss & clean ? RM :
                                 cpu_data_req & miss & dirty ? WM : IDLE;
                RM:     state <= cache_data_data_ok ? IDLE : RM;
                WM:     state <= cache_data_data_ok ? RM   : WM;
            endcase
        end
    end


    //读内存（RM）
    //变量read_req, addr_rcv, read_finish用于构造类sram信号。
    wire read_req;      //一次完整的读事务，从发出读请求到结束
    reg addr_rcv;       //地址接收成功(addr_ok)后到结束
    wire read_finish;   //数据接收成功(data_ok)，即读请求结束
    always @(posedge clk) begin
        addr_rcv <= rst ? 1'b0 :
                    read_req & cache_data_req & cache_data_addr_ok ? 1'b1 :
                    read_finish ? 1'b0 : addr_rcv;
    end
    assign read_req = state == RM;
    assign read_finish = read_req & cache_data_data_ok;

    //写内存（WM）
    wire write_req;     
    reg waddr_rcv;      
    wire write_finish;   
    always @(posedge clk) begin
        waddr_rcv <= rst ? 1'b0 :
                     write_req & cache_data_req & cache_data_addr_ok ? 1'b1 :
                     write_finish ? 1'b0 : waddr_rcv;
    end
    assign write_req = state == WM;
    assign write_finish = write_req & cache_data_data_ok;

    //output to mips core
    assign cpu_data_rdata   = hit ? c_block : cache_data_rdata; // 读命中就返回cache内容(c_block)，否则继续等待
    assign cpu_data_addr_ok = cpu_data_req & hit | cache_data_addr_ok & read_req & cache_data_req; 
    assign cpu_data_data_ok = cpu_data_req & hit | cache_data_data_ok & read_req;

    // address of replace block
    wire [31:0] write_address, read_address;
    assign write_address = {c_tag, index, 2'b00};
    assign read_address = {cpu_data_addr[31:2], 2'b00};

    //output to axi interface
    assign cache_data_req   = read_req & ~addr_rcv | write_req & ~waddr_rcv  ; // 读请求并且地址未收到（写请求并且地址未收到）
    assign cache_data_wr    = write_req;
    assign cache_data_size  = 2'b10 ;
    assign cache_data_addr  = write_req ? write_address : read_address;
    assign cache_data_wdata = c_block ;

    //写入Cache
    //保存地址中的tag, index，防止addr发生改变
    reg [TAG_WIDTH-1:0] tag_save;
    reg [INDEX_WIDTH-1:0] index_save;
    always @(posedge clk) begin
        tag_save   <= rst ? 0 :
                      cpu_data_req ? tag : tag_save;
        index_save <= rst ? 0 :
                      cpu_data_req ? index : index_save;
    end

    wire [31:0] write_cache_data;
    wire [3:0] write_mask;

    //根据地址低两位和size，生成写掩码（针对sb，sh等不是写完整一个字的指令），4位对应1个字（4字节）中每个字的写使能
    assign write_mask = cpu_data_size==2'b00 ?
                            (cpu_data_addr[1] ? (cpu_data_addr[0] ? 4'b1000 : 4'b0100):
                                                (cpu_data_addr[0] ? 4'b0010 : 4'b0001)) :
                            (cpu_data_size==2'b01 ? (cpu_data_addr[1] ? 4'b1100 : 4'b0011) : 4'b1111);

    //掩码的使用：位为1的代表需要更新的。
    //位拓展：{8{1'b1}} -> 8'b11111111
    //new_data = old_data & ~mask | write_data & mask
    assign write_cache_data = cache_block[index] & ~{{8{write_mask[3]}}, {8{write_mask[2]}}, {8{write_mask[1]}}, {8{write_mask[0]}}} | 
                              cpu_data_wdata & {{8{write_mask[3]}}, {8{write_mask[2]}}, {8{write_mask[1]}}, {8{write_mask[0]}}};

    integer t;
    always @(posedge clk) begin
        if(rst) begin
            for(t=0; t<CACHE_DEEPTH; t=t+1) begin   //刚开始将Cache置为无效
                cache_valid[t] <= 0;
                cache_dirty[t] <= 0;
            end
        end
        else begin
            if(read_finish) begin //缺失，访存结束时
                cache_dirty[index_save] <= 1'b0;
                cache_valid[index_save] <= 1'b1;             //将Cache line置为有效
                cache_tag  [index_save] <= tag_save;
                cache_block[index_save] <= cache_data_rdata; //写入Cache line
            end
            else if(write & state == IDLE & hit) begin //写命中时直接写Cache
                cache_dirty[index] <= 1'b1;
                cache_block[index] <= write_cache_data;
            end 
        end
    end
endmodule