`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 10:14:34
// Design Name: 
// Module Name: alu
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


module alu(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [2:0] op,
    output reg [31:0] s
    );
    always @(*) begin
        case(op) 
            3'b010: begin
                s <= (a + b) ;
            end
            3'b110: begin
                s <= (a - b) ;
            end
            3'b000: begin
                s <= (a & b) ;
            end
            3'b001: begin
                s <= (a | b) ;
            end
            3'b111: begin
                s <= (a < b) ;
            end
            default: begin
                s <= 32'b0 ;
            end
        endcase
    end
endmodule