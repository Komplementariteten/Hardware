`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2022 11:28:36 PM
// Design Name: 
// Module Name: pwm_test_tb
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


module pwm_test_tb;
reg clk;
reg rst_n;
wire led;

pwm_test uut(
    .clk(clk),
    .rst_n(rst_n),
    .led(led)
);

initial
begin
    clk = 0;
    rst_n = 0;
    
    #100;
    rst_n = 1;
end

always #20 clk = ~clk;

endmodule
