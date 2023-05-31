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
        input wire[31:0] ReadData_M, // data memory�Ķ�������
        input wire[31:0] instr_F,  // ָ��
        output wire[31:0] PC_F,   // pc��ַ
        output wire MemWrite_M,  // �����źţ�data memory��дʹ���ź�
        output wire MemRead_M,   // �����źţ�data memory�Ķ�ʹ���ź�
        output wire[31:0] ALUResult_M,  // ALU��������
        output wire[31:0] WriteData_M  // rd2��reg[rt]
    );
    
	// control  wire
    wire RegDst_E ; // ����rd�Ĵ����ź�
    wire RegWrite_W ; // �Ĵ�����дʹ���ź�
    wire ALUSrc_E ; // �����������ź�
    wire MemtoReg_W ; // д��Ĵ��������ݵ�ѡ���źţ�1ѡ��DataMemory
    wire PCSrc_D ; // ���÷�֧��ַ�ź�
    wire Jump_D ; // ��������תָ��
    wire Zero_D ;  // ALU ���ź�
    wire [2:0] ALUControl_E ; // ALU�Ŀ����ź�
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
        instr_F, // ����ָ��
        instr_D,
        ReadData_M, // data memory�Ķ�������
        ALUControl_E,  // ALU�Ŀ����ź�
        PCSrc_D , // ���÷�֧��ַ�ź�
        MemtoReg_W , // д��Ĵ��������ݵ�ѡ���źţ�1ѡ��ReadData
        ALUSrc_E , // �����������ź�
        RegDst_E , // ����rd�Ĵ����ź�
        RegWrite_W , // �Ĵ�����дʹ���ź�
        Jump_D , // ��������תָ��
        MemWrite_M,  // �����źţ�data memory��дʹ���ź�
        MemRead_M,   // �����źţ�data memory�Ķ�ʹ���ź�
        ALUResult_M,  // ALU������
        WriteData_M,  // Register File�ڶ�������������
        PC_F,  // ��ַ
        Zero_D,   // ���ź�
        Flush_M, Flush_W, Stall_E, Stall_M, Stall_W  
	) ;
	
	// =====================================================
    // ð�մ��� 
    harzard harzard(
        Rs_E, Rt_E, Rt_D, Rs_D,
        WriteReg_M, RegWrite_M, WriteReg_W, RegWrite_W, MemtoReg_E, branch_D, MemtoReg_M, RegWrite_E, WriteReg_E,
        ForwardA_E, ForwardB_E,
        Stall_F, Stall_D, Flush_E, ForwardA_D, ForwardB_D
    ) ;
endmodule
