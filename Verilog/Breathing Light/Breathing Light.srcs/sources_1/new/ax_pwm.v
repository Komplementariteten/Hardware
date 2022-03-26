`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2022 10:25:34 PM
// Design Name: 
// Module Name: ax_pwm
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


module ax_pwm
#(
    parameter N = 16 // pwm bit width
    ) (
    input clk,
    input rst,
    input[N - 1:0]period, // pwm step value
    input[N - 1:0]duty,
    output pwm_out
    );
    
    reg[N - 1:0] period_r;
    reg[N - 1:0] duty_r;
    reg[N - 1:0] period_cnt;
    reg pwn_r;
    assign pwm_out = pwn_r;
    always@(posedge clk or posedge rst)
    begin
    if(rst == 1)
        begin
            period_r <= { N {1'b0} };
            duty_r <= { N {1'b0} };
        end
        else
        begin
            period_r <= period;
            duty_r <= duty;
        end
     end
     
     always@(posedge clk or posedge rst)
     begin
        if(rst==1)
        begin
            pwn_r <= 1'b0;
        end
        else
        begin
            if(period_cnt >= duty_r)
                pwn_r <= 1'b1;
            else
                pwn_r <= 1'b0;
         end
     end
endmodule
