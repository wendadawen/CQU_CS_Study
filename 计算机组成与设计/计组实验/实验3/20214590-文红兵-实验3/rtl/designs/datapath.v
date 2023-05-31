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
        input wire[31:0] instr, // ����ָ��
        input wire[31:0] ReadData, // data memory�Ķ�������
        input wire [2:0] ALUControl,  // ALU�Ŀ����ź�
        input wire PCSrc , // ���÷�֧��ַ�ź�
        input wire MemtoReg , // д��Ĵ��������ݵ�ѡ���źţ�1ѡ��ReadData
        input wire ALUSrc , // �����������ź�
        input wire RegDst , // ����rd�Ĵ����ź�
        input wire RegWrite , // �Ĵ�����дʹ���ź�
        input wire Jump , // ��������תָ��
        input wire MemWrite,  // �����źţ�data memory��дʹ���ź�
        input wire MemRead,   // �����źţ�data memory�Ķ�ʹ���ź�
        output wire[31:0] ALUResult,  // ALU������
        output wire[31:0] rd2,  // Register File�ڶ�������������
        output wire[31:0] PC,  // ��ַ
        output wire Zero   // ALU��������ź�  
    );
    
    // wire
    wire[31:0] PCPLUS4 ;// pc + 4
    wire[31:0] SignImm ; // ������������չ������
    wire[31:0] rd1 ; // Register File��һ������������
    
    
    
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
    wire[4:0] WriteReg ; // register file д��˿ڵĵ�ַѡ�񣬴�rs��rt��ѡ
    wire[4:0] rd = instr[15:11] ;
    assign WriteReg = (RegDst == 1) ? rd : instr[20:16] ;
    
    // MemtoReg
    wire[31:0] WriteBackResult ; // д�����ݵĽ��
    assign WriteBackResult = (MemtoReg == 0)? ALUResult : ReadData ;
    
    // regfile
    regfile regfile(
        .clk(~CLK),  // ʱ��
        .we3(RegWrite),  // д��˿ڵ�ʹ���ź�
        .ra1(instr[25:21]), 
        .ra2(instr[20:16]),
        .wa3(WriteReg),  // ��������˿ڵĵ�ַ��һ��д��˿ڵĵ�ַ
        .wd3(WriteBackResult),  // д�������
        .rd1(rd1),
        .rd2(rd2)  // �����˿ڶ���������
    );
    
    // sign_extend
    signExtension signExtension(
        .a(instr[15:0]),
        .y(SignImm)
    );
    
    // ALUSrc
    wire[31:0] SrcB ; // ALU�ĵڶ���������
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
