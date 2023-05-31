`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 20:01:54
// Design Name: 
// Module Name: harzard
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


module harzard(
    input wire[4:0] Rs_E, Rt_E, Rt_D,Rs_D,
    input wire[4:0] WriteReg_M, 
    input wire RegWrite_M, 
    input wire[4:0] WriteReg_W, 
    input wire RegWrite_W, MemtoReg_E, branch_D, MemtoReg_M, RegWrite_E, 
    input wire[4:0] WriteReg_E,
    output wire[1:0] ForwardA_E,ForwardB_E,
    output wire Stall_F, Stall_D, Flush_E, ForwardA_D, ForwardB_D
    );

    wire LwStall, BranchStall ;

    // Data Forward
    assign ForwardA_E = (( Rs_E != 0) & ( Rs_E == WriteReg_M ) & RegWrite_M ) ? 10 :
                       (( Rs_E != 0) & ( Rs_E == WriteReg_W ) & RegWrite_W ) ? 01 : 00 ;
    assign ForwardB_E = (( Rt_E != 0) & ( Rt_E == WriteReg_M ) & RegWrite_M ) ? 10 :
                       (( Rt_E != 0) & ( Rt_E == WriteReg_W ) & RegWrite_W ) ? 01 : 00 ;
    
    assign ForwardA_D = ( Rs_D !=0) & ( Rs_D == WriteReg_M ) & RegWrite_M ;
    assign ForwardB_D = ( Rt_D !=0) & ( Rt_D == WriteReg_M ) & RegWrite_M ;
    // Pipeline Stall
    assign LwStall = (( Rs_D == Rt_E ) | ( Rt_D == Rt_E ) ) & MemtoReg_E ;
    assign BranchStall = branch_D & RegWrite_E & ( WriteReg_E == Rs_D | WriteReg_E == Rt_D )
                         | branch_D & MemtoReg_M & ( WriteReg_M == Rs_D | WriteReg_M == Rt_D ) ;
    assign Stall_F = LwStall | BranchStall ;
    assign Stall_D = LwStall | BranchStall ;
    assign Flush_E = LwStall | BranchStall ;
endmodule
