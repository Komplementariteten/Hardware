`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2022 10:38:05 PM
// Design Name: 
// Module Name: pwm_test
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


module pwm_test(
    input sys_clk_p, // system clock 200MHz positive pin
    input sys_clk_n, // system clock 200MHz negative pin
    input rst_n, // low active
    output led
    );
    
    localparam CLK_FREQ = 200;
    localparam US_COUNT = CLK_FREQ;
    localparam MS_COUNT = CLK_FREQ * 1000;
    
    localparam DUTY_STEP = 32'd1000000;
    localparam DUTY_MIN_VALUE = 32'h6fffffff;
    localparam DUTY_MAX_VALUE = 32'hffffffff;
    
    localparam IDLE = 0;
    localparam PWM_PLUS = 1;
    localparam PWM_MINUS = 2;
    localparam PWM_GAP = 3;
    
    wire pwm_out;
    reg[31:0] period;
    reg[31:0] duty;
    reg pwm_flag;
    
    reg[3:0] state;
    reg[31:0] timer;
    
    assign led = pwm_out;
    
    wire clk;
    
    IBUFDS IBUFDS_inst (
        .O(clk), // Buffer output
        .I(sys_clk_p),
        .IB(sys_clk_n)       
    );
    
    always@(posedge clk or negedge rst_n)
    begin
        if(rst-n == 1'b0)
        begin
            period      <= 32'd0;
            timer       <= 32'd0;
            duty        <= 32'd0;
            pwm_flag    <= 1'b0;
            state       <= IDLE;
        end
        else
            case(state)
            IDLE:
            begin
                period <= 32'd17179;
                state <= PWM_PLUS;
                duty <= DUTY_MIN_VALUE;
            end
            PWM_PLUS:
            begin
                if(duty > DUTY_MAX_VALUE - DUTY_STEP)
                begin
                    pwm_flag <= 1'b1;
                    duty <= duty - DUTY_STEP;
                end
                else
                begin
                    pwm_flag <= 1'b0;
                    duty <= duty + DUTY_STEP;
                end
                state <= PWM_GAP;
            end
            PWM_MINUS:
            begin
                if(duty > DUTY_MAX_VALUE + DUTY_STEP)
                begin
                    pwm_flag <= 1'b0;
                    duty <= duty + DUTY_STEP;
                end
                else
                begin
                    pwm_flag <= 1'b1;
                    duty <= duty - DUTY_STEP;
                end
                state <= PWM_GAP;
            end
            PWM_GAP:
            begin
                if(timer >= US_COUNT*100)
                begin
                    if(pwm_flag)
                        state <= PWM_MINUS;
                    else
                        state <= PWM_PLUS;
                    timer <= 32'd0;
                end
                else
                begin
                    timer <= timer + 32'd1;
                end
            end
            default:
            begin
                state <= IDLE;
            end
        endcase
    end
    
    ax_pwm
    #(
    .N(32)
    )
    ax_pwm_m0(
        .clk(clk),
        .rst(~rst_n),
        .period(period),
        .duty( duty),
        .pwm_out(pwm_out)
    );
endmodule
