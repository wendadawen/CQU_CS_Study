`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/03 13:39:24
// Design Name: 
// Module Name: maindec
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


module maindec(
    input wire[5:0] opcode,
    output reg regwrite, regdst, alusrc, branch, memWrite, memRead, memtoReg, jump,
    output reg[1:0] aluop 
    );
    
    always @(*) begin
        case(opcode)
            6'b000000: begin  // R-type
                {regwrite, regdst, alusrc, branch, memWrite, memRead, memtoReg, jump} = 8'b11000000 ;
                aluop = 2'b10 ;
            end
            6'b100011: begin  // lw
                {regwrite, regdst, alusrc, branch, memWrite, memRead, memtoReg, jump} = 8'b10100110 ;
                aluop = 2'b00 ;
            end
            6'b101011: begin  // sw
                {regwrite, regdst, alusrc, branch, memWrite, memRead, memtoReg, jump} = 8'b00101000 ;
                aluop = 2'b00 ;
            end
            6'b000100: begin  // beg
                {regwrite, regdst, alusrc, branch, memWrite, memRead, memtoReg, jump} = 8'b00010000 ;
                aluop = 2'b01 ;
            end
            6'b001000: begin  // addi
                {regwrite, regdst, alusrc, branch, memWrite, memRead, memtoReg, jump} = 8'b10100000 ;
                aluop = 2'b00 ;
            end
            6'b000010: begin  // j
                {regwrite, regdst, alusrc, branch, memWrite, memRead, memtoReg, jump} = 8'b00000001 ;
                aluop = 2'b00 ;
            end
            default:begin
                {regwrite, regdst, alusrc, branch, memWrite, memRead, memtoReg, jump} = 8'b00000000 ;
                aluop = 2'b00 ;
            end
        endcase
    end
endmodule
