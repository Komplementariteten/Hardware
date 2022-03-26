`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2022 09:19:32 PM
// Design Name: 
// Module Name: pll_test
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


module pll_test(
    input sys_clk,
    input rst_n,
    output clk_out
    );

wire locked;
wire sys_clkbuf;

BUFG BUFG_inst(
    .O(sys_clkbuf),
    .I(sys_clk)
);
    
clk_wiz_0 clk_wiz_0_inst
   (
  
    // Clock out ports
    .clk_out1(),     // output clk_out1
    .clk_out2(),     // output clk_out2
    .clk_out3(),     // output clk_out3
    .clk_out4(clk_out),     // output clk_out4
    // Status and control signals
    .reset(~rst_n), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(sys_clkbuf));      // input clk_in1
endmodule
