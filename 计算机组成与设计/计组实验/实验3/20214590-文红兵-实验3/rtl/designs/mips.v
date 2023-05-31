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
        input wire[31:0] ReadData, // data memory的读出数据
        input wire[31:0] instr,  // 指令
        output wire[31:0] PC,   // pc地址
        output wire MemWrite,  // 控制信号，data memory的写使能信号
        output wire MemRead,   // 控制信号，data memory的读使能信号
        output wire[31:0] ALUResult,  // ALU的运算结果
        output wire[31:0] WriteData  // rd2，reg[rt]
    );
    
	// control  wire
    wire RegDst ; // 启用rd寄存器信号
    wire RegWrite ; // 寄存器堆写使能信号
    wire ALUSrc ; // 启用立即数信号
    wire MemtoReg ; // 写入寄存器堆数据的选择信号，1选择DataMemory
    wire PCSrc ; // 启用分支地址信号
    wire Jump ; // 无条件跳转指令
    wire Zero ;  // ALU 零信号
    wire [2:0] ALUControl ; // ALU的控制信号
    // controller
    controller controller(
        .inst(instr),
        .zero(Zero),
        .regwrite(RegWrite), 
        .regdst(RegDst), 
        .alusrc(ALUSrc),
        .pcSrc(PCSrc),
        .memWrite(MemWrite), 
        .memRead(MemRead),
        .memtoReg(MemtoReg), 
        .jump(Jump),
        .alucontrol(ALUControl)
    );

	datapath datapath(
	    .CLK(CLK), 
	    .RST(RST),
        .instr(instr), // 输入指令
        .ReadData(ReadData), // data memory的读出数据
        .ALUControl(ALUControl),  // ALU的控制信号
        .PCSrc(PCSrc) , // 启用分支地址信号
        .MemtoReg(MemtoReg) , // 写入寄存器堆数据的选择信号，1选择ReadData
        .ALUSrc(ALUSrc) , // 启用立即数信号
        .RegDst(RegDst) , // 启用rd寄存器信号
        .RegWrite(RegWrite) , // 寄存器堆写使能信号
        .Jump(Jump) , // 无条件跳转指令
        .MemWrite(MemWrite), // 控制信号，data memory的写使能信号
        .MemRead(MemRead), // 控制信号，data memory的读使能信号
        .ALUResult(ALUResult),  // ALU计算结果
        .rd2(WriteData),  // Register File第二个读出的数据
        .PC(PC),  // 地址
        .Zero(Zero)   // ALU输出的零信号  
	) ;
endmodule
