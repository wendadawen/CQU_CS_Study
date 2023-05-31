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
    input wire[31:0] inst,
    input wire zero,
    output wire regwrite, regdst, alusrc, pcSrc, memWrite, memRead, memtoReg, jump,
    output wire[2:0] alucontrol
    );
    
    wire[1:0] aluop_wire ;
    wire branch ;
    
    assign pcSrc = branch & zero ;
    
    maindec maindec(
        .opcode(inst[31:26]),
        .regwrite(regwrite), 
        .regdst(regdst), 
        .alusrc(alusrc), 
        .branch(branch), 
        .memWrite(memWrite), 
        .memRead(memRead),
        .memtoReg(memtoReg), 
        .jump(jump),
        .aluop(aluop_wire) 
    );
    
    aludec aludec(
        .funct(inst[5:0]),
        .aluop(aluop_wire),
        .alucontrol(alucontrol)
    );
endmodule
