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
        input wire[31:0] instr, // 输入指令
        input wire[31:0] ReadData, // data memory的读出数据
        input wire [2:0] ALUControl,  // ALU的控制信号
        input wire PCSrc , // 启用分支地址信号
        input wire MemtoReg , // 写入寄存器堆数据的选择信号，1选择ReadData
        input wire ALUSrc , // 启用立即数信号
        input wire RegDst , // 启用rd寄存器信号
        input wire RegWrite , // 寄存器堆写使能信号
        input wire Jump , // 无条件跳转指令
        input wire MemWrite,  // 控制信号，data memory的写使能信号
        input wire MemRead,   // 控制信号，data memory的读使能信号
        output wire[31:0] ALUResult,  // ALU计算结果
        output wire[31:0] rd2,  // Register File第二个读出的数据
        output wire[31:0] PC,  // 地址
        output wire Zero   // ALU输出的零信号  
    );
    
    // wire
    wire[31:0] PCPLUS4 ;// pc + 4
    wire[31:0] SignImm ; // 立即数符号扩展的数字
    wire[31:0] rd1 ; // Register File第一个读出的数据
    
    
    
    // PCSrc and Jump
    wire[31:0] PCSeclected ;
    wire[31:0] PCBranch ;
    assign PCBranch = PCPLUS4 + {SignImm[29:0],2'b00} ;
    assign PCSeclected = (Jump == 1)? {PCPLUS4[31:28],{instr[25:0], 2'b00}}: 
                                        (PCSrc == 1)? PCBranch : PCPLUS4 ;
    // pc
    pc pc(
        .clk(CLK),
        .reset(RST),
        .d(PCSeclected),
        .q(PC)
    );
    
    // pc + 4
    assign PCPLUS4 = PC + 4 ;
    
    // RegDst
    wire[4:0] WriteReg ; // register file 写入端口的地址选择，从rs和rt中选
    wire[4:0] rd = instr[15:11] ;
    assign WriteReg = (RegDst == 1) ? rd : instr[20:16] ;
    
    // MemtoReg
    wire[31:0] WriteBackResult ; // 写回数据的结果
    assign WriteBackResult = (MemtoReg == 0)? ALUResult : ReadData ;
    
    // regfile
    regfile regfile(
        .clk(~CLK),  // 时钟
        .we3(RegWrite),  // 写入端口的使能信号
        .ra1(instr[25:21]), 
        .ra2(instr[20:16]),
        .wa3(WriteReg),  // 两个读入端口的地址，一个写入端口的地址
        .wd3(WriteBackResult),  // 写入的数据
        .rd1(rd1),
        .rd2(rd2)  // 两个端口读出的数据
    );
    
    // sign_extend
    signExtension signExtension(
        .a(instr[15:0]),
        .y(SignImm)
    );
    
    // ALUSrc
    wire[31:0] SrcB ; // ALU的第二个操作数
    assign SrcB = (ALUSrc == 1)? SignImm : rd2 ;
    
    // ALU
    alu alu(
        .a(rd1),
        .b(SrcB),
        .op(ALUControl),
        .s(ALUResult),
        .zero(Zero)
        );
    
endmodule
