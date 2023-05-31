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
        input wire[31:0] ReadData, // data memory�Ķ�������
        input wire[31:0] instr,  // ָ��
        output wire[31:0] PC,   // pc��ַ
        output wire MemWrite,  // �����źţ�data memory��дʹ���ź�
        output wire MemRead,   // �����źţ�data memory�Ķ�ʹ���ź�
        output wire[31:0] ALUResult,  // ALU��������
        output wire[31:0] WriteData  // rd2��reg[rt]
    );
    
	// control  wire
    wire RegDst ; // ����rd�Ĵ����ź�
    wire RegWrite ; // �Ĵ�����дʹ���ź�
    wire ALUSrc ; // �����������ź�
    wire MemtoReg ; // д��Ĵ��������ݵ�ѡ���źţ�1ѡ��DataMemory
    wire PCSrc ; // ���÷�֧��ַ�ź�
    wire Jump ; // ��������תָ��
    wire Zero ;  // ALU ���ź�
    wire [2:0] ALUControl ; // ALU�Ŀ����ź�
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
        .instr(instr), // ����ָ��
        .ReadData(ReadData), // data memory�Ķ�������
        .ALUControl(ALUControl),  // ALU�Ŀ����ź�
        .PCSrc(PCSrc) , // ���÷�֧��ַ�ź�
        .MemtoReg(MemtoReg) , // д��Ĵ��������ݵ�ѡ���źţ�1ѡ��ReadData
        .ALUSrc(ALUSrc) , // �����������ź�
        .RegDst(RegDst) , // ����rd�Ĵ����ź�
        .RegWrite(RegWrite) , // �Ĵ�����дʹ���ź�
        .Jump(Jump) , // ��������תָ��
        .MemWrite(MemWrite), // �����źţ�data memory��дʹ���ź�
        .MemRead(MemRead), // �����źţ�data memory�Ķ�ʹ���ź�
        .ALUResult(ALUResult),  // ALU������
        .rd2(WriteData),  // Register File�ڶ�������������
        .PC(PC),  // ��ַ
        .Zero(Zero)   // ALU��������ź�  
	) ;
endmodule
