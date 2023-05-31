`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 09:10:59
// Design Name: 
// Module Name: pc
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

module pc(
    input clk, reset,
    input [31:0] d,
    output reg [31:0] q
    );
    always @ (posedge clk or posedge reset)
        if (reset) begin
            q <= 0 ;
        end
        else begin
            q <= d;
        end
endmodule
