`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2022 08:04:42 PM
// Design Name: 
// Module Name: vtf_led_test
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


module vtf_led_test;
    reg sys_clk;
    reg rst_n;
    wire [3:0] led;
    
    led uut (
        .sys_clk(sys_clk),
        .rst_n(rst_n),
        .led(led)
        );
        
        initial
        begin
        sys_clk = 0;
        rst_n = 0;
        #1000;
        rst_n = 1;
        end
        
    always #10 sys_clk = ~sys_clk;
        
endmodule
