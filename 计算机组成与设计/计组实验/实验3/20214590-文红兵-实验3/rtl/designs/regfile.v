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
	input wire clk,  // ʱ��
	input wire we3,  // д��˿ڵ�ʹ���ź�
	input wire[4:0] ra1,ra2,wa3,  // ��������˿ڵĵ�ַ��һ��д��˿ڵĵ�ַ
	input wire[31:0] wd3,  // д�������
	output wire[31:0] rd1,rd2  // �����˿ڶ���������
    );

	reg [31:0] rf[31:0];  // �Ĵ�����
    
	always @(posedge clk) begin
		if(we3) begin
			 rf[wa3] <= wd3;
		end
	end

	assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule
