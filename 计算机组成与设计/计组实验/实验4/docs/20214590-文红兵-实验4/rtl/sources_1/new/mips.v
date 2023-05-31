`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 10:58:03
// Design Name: 
// Module Name: mips
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


module mips(
        input wire CLK,RST,
        input wire[31:0] ReadData_M, // data memory的读出数据
        input wire[31:0] instr_F,  // 指令
        output wire[31:0] PC_F,   // pc地址
        output wire MemWrite_M,  // 控制信号，data memory的写使能信号
        output wire MemRead_M,   // 控制信号，data memory的读使能信号
        output wire[31:0] ALUResult_M,  // ALU的运算结果
        output wire[31:0] WriteData_M  // rd2，reg[rt]
    );
    
	// control  wire
    wire RegDst_E ; // 启用rd寄存器信号
    wire RegWrite_W ; // 寄存器堆写使能信号
    wire ALUSrc_E ; // 启用立即数信号
    wire MemtoReg_W ; // 写入寄存器堆数据的选择信号，1选择DataMemory
    wire PCSrc_D ; // 启用分支地址信号
    wire Jump_D ; // 无条件跳转指令
    wire Zero_D ;  // ALU 零信号
    wire [2:0] ALUControl_E ; // ALU的控制信号
    wire[31:0] instr_D ;
    
    // harzard wire
    wire Stall_E, Stall_M, Flush_M, Stall_W, Flush_W ;
    wire Stall_F, Stall_D, Flush_E, ForwardA_D, ForwardB_D ;
    wire[1:0] ForwardA_E,ForwardB_E ;
    wire[4:0] Rs_E, Rt_E, Rt_D, Rs_D ;
    wire RegWrite_M,  MemtoReg_E, branch_D, MemtoReg_M, RegWrite_E ;
    wire[4:0] WriteReg_M, WriteReg_E, WriteReg_W ;
    
    // controller
    controller controller(
        CLK, RST,
        RegWrite_M, MemtoReg_E, branch_D, MemtoReg_M, RegWrite_E, 
        Stall_E, Flush_E, Stall_M, Flush_M, Stall_W, Flush_W,
        instr_D,
        Zero_D,
        RegWrite_W, 
        RegDst_E, 
        ALUSrc_E,
        PCSrc_D,
        MemWrite_M, 
        MemRead_M,
        MemtoReg_W, 
        Jump_D,
        ALUControl_E
    );

	datapath datapath(
	    CLK, 
	    RST,
        WriteReg_M, WriteReg_W, WriteReg_E,
        Rs_E, Rt_E, Rt_D, Rs_D, 
	    Stall_F, Stall_D,  ForwardA_D, ForwardB_D, Flush_E,
	    ForwardA_E, ForwardB_E,
        instr_F, // 输入指令
        instr_D,
        ReadData_M, // data memory的读出数据
        ALUControl_E,  // ALU的控制信号
        PCSrc_D , // 启用分支地址信号
        MemtoReg_W , // 写入寄存器堆数据的选择信号，1选择ReadData
        ALUSrc_E , // 启用立即数信号
        RegDst_E , // 启用rd寄存器信号
        RegWrite_W , // 寄存器堆写使能信号
        Jump_D , // 无条件跳转指令
        MemWrite_M,  // 控制信号，data memory的写使能信号
        MemRead_M,   // 控制信号，data memory的读使能信号
        ALUResult_M,  // ALU计算结果
        WriteData_M,  // Register File第二个读出的数据
        PC_F,  // 地址
        Zero_D,   // 零信号
        Flush_M, Flush_W, Stall_E, Stall_M, Stall_W  
	) ;
	
	// =====================================================
    // 冒险处理 
    harzard harzard(
        Rs_E, Rt_E, Rt_D, Rs_D,
        WriteReg_M, RegWrite_M, WriteReg_W, RegWrite_W, MemtoReg_E, branch_D, MemtoReg_M, RegWrite_E, WriteReg_E,
        ForwardA_E, ForwardB_E,
        Stall_F, Stall_D, Flush_E, ForwardA_D, ForwardB_D
    ) ;
endmodule
