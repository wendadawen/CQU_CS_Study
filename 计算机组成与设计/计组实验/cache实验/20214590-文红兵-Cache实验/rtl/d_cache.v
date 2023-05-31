// ���ݻ���ģ�鶨��
module d_cache (
    // ʱ���źź͸�λ�ź�
    input wire clk, rst,
    // MIPS���������������ź�
    input         cpu_data_req     , // CPU���������źţ���ʾCPU��������������ݻ���
    input         cpu_data_wr      , // CPU����д�źţ���ʾCPU����ִ��һ������д����
    input  [1 :0] cpu_data_size    , // CPU���ݴ�С�����ڱ�ʾ���ݷ��ʵ��ֽڴ�С�����磺00��ʾ1�ֽڣ�01��ʾ2�ֽڣ�10��ʾ4�ֽڣ�
    input  [31:0] cpu_data_addr    , // CPU���ݷ��ʵ�ַ
    input  [31:0] cpu_data_wdata   , // CPU����д�������
    output [31:0] cpu_data_rdata   , // CPU�����ݻ����ȡ������
    output        cpu_data_addr_ok , // CPU���ݵ�ַȷ���źţ���ʾ��ַ�����ѳɹ�
    output        cpu_data_data_ok , // CPU���ݶ�/дȷ���źţ���ʾ���ݶ�ȡ��д���ѳɹ�

    // AXI�ӿ�����ź�
    output         cache_data_req     , // �������������źţ���ʾ���������������AXI����
    output         cache_data_wr      , // ��������д�źţ���ʾ��������ִ��һ������д����
    output  [1 :0] cache_data_size    , // �������ݴ�С�����ڱ�ʾ���ݷ��ʵ��ֽڴ�С�����磺00��ʾ1�ֽڣ�01��ʾ2�ֽڣ�10��ʾ4�ֽڣ�
    output  [31:0] cache_data_addr    , // �������ݷ��ʵ�ַ
    output  [31:0] cache_data_wdata   , // ��������д�������
    input   [31:0] cache_data_rdata   , // �����AXI���߶�ȡ������
    input          cache_data_addr_ok , // �������ݵ�ַȷ���źţ���ʾ��ַ�����ѳɹ�
    input          cache_data_data_ok   // �������ݶ�/дȷ���źţ���ʾ���ݶ�ȡ��д���ѳɹ�
);
    // д��ʵ�֣�������λ

    // �����У�ֱ�ӷ���cache���ݡ�
    // ��ȱʧ�������ڴ棬д��cache
    // д���У�ֻд��cache��
    // дȱʧ�������ڴ棬д��cache
    // �滻��dirtyд������滻

    //Cache����
    parameter  INDEX_WIDTH  = 10, OFFSET_WIDTH = 2;
    localparam TAG_WIDTH    = 32 - INDEX_WIDTH - OFFSET_WIDTH;
    localparam CACHE_DEEPTH = 1 << INDEX_WIDTH;
    
    //Cache�洢��Ԫ
    reg                 cache_valid [CACHE_DEEPTH - 1 : 0];
    reg                 cache_dirty [CACHE_DEEPTH - 1 : 0];
    reg [TAG_WIDTH-1:0] cache_tag   [CACHE_DEEPTH - 1 : 0];
    reg [31:0]          cache_block [CACHE_DEEPTH - 1 : 0];

    //���ʵ�ַ�ֽ�
    wire [OFFSET_WIDTH-1:0] offset; 
    wire [INDEX_WIDTH-1:0] index;
    wire [TAG_WIDTH-1:0] tag;
    
    assign offset = cpu_data_addr[OFFSET_WIDTH - 1 : 0];
    assign index = cpu_data_addr[INDEX_WIDTH + OFFSET_WIDTH - 1 : OFFSET_WIDTH];
    assign tag = cpu_data_addr[31 : INDEX_WIDTH + OFFSET_WIDTH];

    //����Cache line
    wire c_valid;
    wire c_dirty;
    wire [TAG_WIDTH-1:0] c_tag;
    wire [31:0] c_block;

    assign c_valid = cache_valid[index];
    assign c_dirty = cache_dirty[index];
    assign c_tag   = cache_tag  [index];
    assign c_block = cache_block[index];

    //�ж��Ƿ�����
    wire   hit, miss, dirty, clean;
    assign hit = c_valid & (c_tag == tag);  //cache line��validλΪ1����tag���ַ��tag���
    assign miss = ~hit;
    assign dirty = c_valid & c_dirty;
    assign clean = ~dirty;
  
    //����д
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


    //���ڴ棨RM��
    //����read_req, addr_rcv, read_finish���ڹ�����sram�źš�
    wire read_req;      //һ�������Ķ����񣬴ӷ��������󵽽���
    reg addr_rcv;       //��ַ���ճɹ�(addr_ok)�󵽽���
    wire read_finish;   //���ݽ��ճɹ�(data_ok)�������������
    always @(posedge clk) begin
        addr_rcv <= rst ? 1'b0 :
                    read_req & cache_data_req & cache_data_addr_ok ? 1'b1 :
                    read_finish ? 1'b0 : addr_rcv;
    end
    assign read_req = state == RM;
    assign read_finish = read_req & cache_data_data_ok;

    //д�ڴ棨WM��
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
    assign cpu_data_rdata   = hit ? c_block : cache_data_rdata; // �����оͷ���cache����(c_block)����������ȴ�
    assign cpu_data_addr_ok = cpu_data_req & hit | cache_data_addr_ok & read_req & cache_data_req; 
    assign cpu_data_data_ok = cpu_data_req & hit | cache_data_data_ok & read_req;

    // address of replace block
    wire [31:0] write_address, read_address;
    assign write_address = {c_tag, index, 2'b00};
    assign read_address = {cpu_data_addr[31:2], 2'b00};

    //output to axi interface
    assign cache_data_req   = read_req & ~addr_rcv | write_req & ~waddr_rcv  ; // �������ҵ�ַδ�յ���д�����ҵ�ַδ�յ���
    assign cache_data_wr    = write_req;
    assign cache_data_size  = 2'b10 ;
    assign cache_data_addr  = write_req ? write_address : read_address;
    assign cache_data_wdata = c_block ;

    //д��Cache
    //�����ַ�е�tag, index����ֹaddr�����ı�
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

    //���ݵ�ַ����λ��size������д���루���sb��sh�Ȳ���д����һ���ֵ�ָ���4λ��Ӧ1���֣�4�ֽڣ���ÿ���ֵ�дʹ��
    assign write_mask = cpu_data_size==2'b00 ?
                            (cpu_data_addr[1] ? (cpu_data_addr[0] ? 4'b1000 : 4'b0100):
                                                (cpu_data_addr[0] ? 4'b0010 : 4'b0001)) :
                            (cpu_data_size==2'b01 ? (cpu_data_addr[1] ? 4'b1100 : 4'b0011) : 4'b1111);

    //�����ʹ�ã�λΪ1�Ĵ�����Ҫ���µġ�
    //λ��չ��{8{1'b1}} -> 8'b11111111
    //new_data = old_data & ~mask | write_data & mask
    assign write_cache_data = cache_block[index] & ~{{8{write_mask[3]}}, {8{write_mask[2]}}, {8{write_mask[1]}}, {8{write_mask[0]}}} | 
                              cpu_data_wdata & {{8{write_mask[3]}}, {8{write_mask[2]}}, {8{write_mask[1]}}, {8{write_mask[0]}}};

    integer t;
    always @(posedge clk) begin
        if(rst) begin
            for(t=0; t<CACHE_DEEPTH; t=t+1) begin   //�տ�ʼ��Cache��Ϊ��Ч
                cache_valid[t] <= 0;
                cache_dirty[t] <= 0;
            end
        end
        else begin
            if(read_finish) begin //ȱʧ���ô����ʱ
                cache_dirty[index_save] <= 1'b0;
                cache_valid[index_save] <= 1'b1;             //��Cache line��Ϊ��Ч
                cache_tag  [index_save] <= tag_save;
                cache_block[index_save] <= cache_data_rdata; //д��Cache line
            end
            else if(write & state == IDLE & hit) begin //д����ʱֱ��дCache
                cache_dirty[index] <= 1'b1;
                cache_block[index] <= write_cache_data;
            end 
        end
    end
endmodule