`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/03 13:39:02
// Design Name: 
// Module Name: controller
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


module controller(
    input wire CLK, RST,
    input wire RegWrite_M, MemtoReg_E, branch_D, MemtoReg_M, RegWrite_E,
    input wire Stall_E, Flush_E, Stall_M, Flush_M, Stall_W, Flush_W,
    input wire[31:0] inst_D,
    input wire Zero_D,
    output wire RegWrite_W, RegDst_E, ALUSrc_E, PCSrc_D, MemWrite_M, MemRead_M, MemtoReg_W, Jump_D,
    output wire[2:0] ALUControl_E
    );

    wire RegWrite_D, RegDst_D, ALUSrc_D, MemWrite_D, MemRead_D, MemtoReg_D;
    wire[2:0] ALUControl_D ;
    wire  MemWrite_E, MemRead_E;
    
    wire[1:0] aluop ;

    assign PCSrc_D = branch_D & Zero_D ;
    
    maindec maindec(
        .opcode(inst_D[31:26]),
        .regwrite(RegWrite_D), 
        .regdst(RegDst_D), 
        .alusrc(ALUSrc_D), 
        .branch(branch_D), 
        .memWrite(MemWrite_D), 
        .memRead(MemRead_D),
        .memtoReg(MemtoReg_D), 
        .jump(Jump_D),
        .aluop(aluop) 
    );
    
    aludec aludec(
        .funct(inst_D[5:0]),
        .aluop(aluop),
        .alucontrol(ALUControl_D)
    );

    // ===================================================
    // Decode-Execute
    flopenrc #(9) r1(
        CLK,RST, ~Stall_E, Flush_E, 
        {RegWrite_D, RegDst_D, ALUSrc_D, MemWrite_D, MemRead_D, MemtoReg_D, ALUControl_D},
        {RegWrite_E, RegDst_E, ALUSrc_E, MemWrite_E, MemRead_E, MemtoReg_E, ALUControl_E}
    ) ;

    // Execute-Memory
    flopenrc #(4) r2(
        CLK,RST, ~Stall_M, Flush_M, 
        {RegWrite_E, MemtoReg_E, MemWrite_E, MemRead_E},
        {RegWrite_M, MemtoReg_M, MemWrite_M, MemRead_M}
    ) ;

    // Memory-WriteBack
    flopenrc #(2) r3(
        CLK,RST,~Stall_W, Flush_W, 
        {RegWrite_M, MemtoReg_M},
        {RegWrite_W, MemtoReg_W} 
    ) ;
endmodule
