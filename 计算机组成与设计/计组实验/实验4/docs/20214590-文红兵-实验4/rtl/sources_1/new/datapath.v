`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 09:00:17
// Design Name: 
// Module Name: datapath
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module datapath(
        input wire CLK, RST,
        input wire[4:0] WriteReg_M, WriteReg_W, WriteReg_E,
        input wire[4:0] Rs_E, Rt_E, Rt_D, Rs_D, 
        input wire Stall_F, Stall_D,  ForwardA_D, ForwardB_D, Flush_E, 
        input wire[1:0] ForwardA_E, ForwardB_E,
        input wire[31:0] instr_F, // 输入指令
        input wire[31:0] instr_D,
        input wire[31:0] ReadData_M, // data memory的读出数据
        input wire [2:0] ALUControl_E,  // ALU的控制信号
        input wire PCSrc_D , // 启用分支地址信号
        input wire MemtoReg_W , // 写入寄存器堆数据的选择信号，1选择ReadData
        input wire ALUSrc_E , // 启用立即数信号
        input wire RegDst_E , // 启用rd寄存器信号
        input wire RegWrite_W , // 寄存器堆写使能信号
        input wire Jump_D , // 无条件跳转指令
        input wire MemWrite_M,  // 控制信号，data memory的写使能信号
        input wire MemRead_M,   // 控制信号，data memory的读使能信号
        output wire[31:0] ALUResult_M,  // ALU计算结果
        output wire[31:0] WriteData_M,  // Register File第二个读出的数据
        output wire[31:0] PC_F,  // 地址
        output wire Zero_D,   // 零信号
        output wire Flush_M, Flush_W, Stall_E, Stall_M, Stall_W
    );
    
    // pipeline wire
    wire[31:0] ALUResult_W, ReadData_W, WriteData_E;
    wire[4:0] Rd_E, Rd_D ;
    wire[31:0] rd1_E, rd2_E, SignImm_E ;
    wire[31:0] PCPLUS4_D ;


    // wire
    wire[31:0] PCPLUS4_F ;// pc + 4
    wire[31:0] ALUResult_E ; // ALU计算结果
    wire[31:0] SignImm_D ; // 立即数符号扩展的数字
    wire[31:0] rd1_D ; // Register File第一个读出的数据
    wire[31:0] rd2_D ; // Register File第一个读出的数据
    wire[31:0] BranchSrcA_D, BranchSrcB_D ; // branch分支指令的两个操作数
    wire Flush_D, Flush_F ;
    
    
    
    // PCSrc_D and Jump_D
    wire[31:0] PCSeclected_F, PCBranch_D, PCJump_D ;
    assign PCBranch_D = PCPLUS4_D + {SignImm_D[29:0],2'b00} ;
    assign PCJump_D = {PCPLUS4_D[31:28],{instr_D[25:0], 2'b00}} ;
    assign PCSeclected_F = (Jump_D == 1)? PCJump_D : 
                        (PCSrc_D == 1)? PCBranch_D : PCPLUS4_F ;
    // pc
    assign Flush_F = 1'b0 ;
    flopenrc #(32) pc(
        CLK, RST,~Stall_F, Flush_F,
        PCSeclected_F,
        PC_F
    );
    
    // pc + 4
    assign PCPLUS4_F = PC_F + 4 ;
    
    // RegDst_E
    assign WriteReg_E = (RegDst_E == 1) ? Rd_E : Rt_E ;
    
    // MemtoReg_W
    wire[31:0] WriteBackResult_W ; // 写回数据的结果
    assign WriteBackResult_W = (MemtoReg_W == 0)? ALUResult_W : ReadData_W ;
    
    // Rs,Rt,Rd
    assign Rs_D = instr_D[25:21] ;
    assign Rt_D = instr_D[20:16] ; 
    assign Rd_D = instr_D[15:11] ;

    // Zero_D
    assign BranchSrcA_D = (ForwardA_D == 1)? ALUResult_M : rd1_D ;
    assign BranchSrcB_D = (ForwardB_D == 1)? ALUResult_M : rd2_D ;
    assign Zero_D = (BranchSrcA_D == BranchSrcB_D) ;

    // regfile
    regfile regfile(
        .clk(~CLK),  // 时钟
        .we3(RegWrite_W),  // 写入端口的使能信号
        .ra1(Rs_D), 
        .ra2(Rt_D),
        .wa3(WriteReg_W),  // 两个读入端口的地址，一个写入端口的地址
        .wd3(WriteBackResult_W),  // 写入的数据
        .rd1(rd1_D),
        .rd2(rd2_D)  // 两个端口读出的数据
    );

    
    // sign_extend
    signExtension signExtension(
        .a(instr_D[15:0]),
        .y(SignImm_D)
    );
    
    // ALUSrc_E
    wire[31:0] SrcA_E ; // ALU的第一个操作数
    wire[31:0] SrcB_E ; // ALU的第二个操作数
    assign SrcA_E = (ForwardA_E == 2'b00)? rd1_E : 
                  (ForwardA_E == 2'b01)? WriteBackResult_W :
                  (ForwardA_E == 2'b10)? ALUResult_M : 32'b0 ;
    assign WriteData_E = (ForwardB_E == 2'b00)? rd2_E : 
                         (ForwardB_E == 2'b01)? WriteBackResult_W :
                         (ForwardB_E == 2'b10)? ALUResult_M : 32'b0 ;
    assign SrcB_E = (ALUSrc_E == 1)? SignImm_E : WriteData_E ;
    
    // ALU
    alu alu(
        .a(SrcA_E),
        .b(SrcB_E),
        .op(ALUControl_E),
        .s(ALUResult_E)
        );

    // ============================================================================
    // Fetch-Decode
    assign Flush_D = PCSrc_D ;
    flopenrc #(32) r1F (CLK, RST, ~Stall_D, Flush_D, PCPLUS4_F, PCPLUS4_D) ;
    flopenrc #(32) r2F (CLK, RST, ~Stall_D, Flush_D, instr_F, instr_D) ;

    // Decode-Execute
    assign Stall_E = 1'b0 ;
    flopenrc #(32) r1E (CLK, RST, ~Stall_E, Flush_E, rd1_D, rd1_E) ;
    flopenrc #(32) r2E (CLK, RST, ~Stall_E, Flush_E, rd2_D, rd2_E) ;
    flopenrc #(32) r3E (CLK, RST, ~Stall_E, Flush_E, SignImm_D, SignImm_E) ;
    flopenrc #(5) r5E (CLK, RST, ~Stall_E, Flush_E, Rs_D, Rs_E) ;
    flopenrc #(5) r6E (CLK, RST, ~Stall_E, Flush_E, Rt_D, Rt_E) ;
    flopenrc #(5) r7E (CLK, RST, ~Stall_E, Flush_E, Rd_D, Rd_E) ;

    // Execute-Memory
    assign Flush_M = 1'b0 ;
    assign Stall_M = 1'b0 ;
    flopenrc #(32) r1M (CLK, RST, ~Stall_M, Flush_M, ALUResult_E, ALUResult_M) ;
    flopenrc #(32) r2M (CLK, RST, ~Stall_M, Flush_M, WriteData_E, WriteData_M) ;
    flopenrc #(5) r3M (CLK, RST, ~Stall_M, Flush_M, WriteReg_E, WriteReg_M) ;

    // Memory-Writeback
    assign Flush_W = 1'b0 ;
    assign Stall_W = 1'b0 ;
    flopenrc #(32) r1W (CLK, RST, ~Stall_W, Flush_W, ALUResult_M, ALUResult_W) ;
    flopenrc #(32) r2W (CLK, RST, ~Stall_W, Flush_W, ReadData_M, ReadData_W) ;
    flopenrc #(5) r3W (CLK, RST, ~Stall_W, Flush_W, WriteReg_M, WriteReg_W) ;
endmodule
