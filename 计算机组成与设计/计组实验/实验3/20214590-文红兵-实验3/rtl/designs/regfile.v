`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 14:20:09
// Design Name: 
// Module Name: regfile
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


module regfile(
	input wire clk,  // 时钟
	input wire we3,  // 写入端口的使能信号
	input wire[4:0] ra1,ra2,wa3,  // 两个读入端口的地址，一个写入端口的地址
	input wire[31:0] wd3,  // 写入的数据
	output wire[31:0] rd1,rd2  // 两个端口读出的数据
    );

	reg [31:0] rf[31:0];  // 寄存器堆
    
	always @(posedge clk) begin
		if(we3) begin
			 rf[wa3] <= wd3;
		end
	end

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
