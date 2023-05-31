`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/07 13:50:53
// Design Name: 
// Module Name: top
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


module top(
	input wire clk,rst,
	output wire[31:0] WriteData,DataAdr,
	output wire MemWrite
    );
	
	wire[31:0] ReadData, pc, instr ;
	wire MemRead , InsRead ;
	assign InsRead = 1'b1 ;
    
	mips mips(
        .CLK(clk),
        .RST(rst),
        .ReadData(ReadData), // data memory的读出数据
        .instr(instr),  // 指令
        .PC(pc),   // pc地址
        .MemWrite(MemWrite),  // 控制信号，data memory的写使能信号
        .MemRead(MemRead),  // 控制信号，data memory的读使能信号
        .ALUResult(DataAdr),  // ALU的运算结果作为data memory的地址
        .WriteData(WriteData)  // rd2，reg[rt]
    );
	inst_mem inst_mem(
        .clka(~clk),    // input wire clka
        .ena(InsRead & ~rst),      // input wire ena
        .wea(4'b0000),      // input wire [3 : 0] wea
        .addra(pc),  // input wire [31 : 0] addra
        .dina(32'h0),    // input wire [31 : 0] dina
        .douta(instr)  // output wire [31 : 0] douta
    );
	data_mem data_mem (
        .clka(~clk),            // input wire clka
        .ena(MemRead | MemWrite),              // input wire ena
        .wea({4{MemWrite}}),          // input wire [3 : 0] wea
        .addra(DataAdr),          // input wire [31 : 0] addra
        .dina(WriteData),            // input wire [31 : 0] dina
        .douta(ReadData)          // output wire [31 : 0] douta
    );
endmodule
