----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2023 11:38:50 AM
-- Design Name: 
-- Module Name: led_test_tb - TB
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_test_tb is
--  Port ( );
end led_test_tb;

architecture TB of led_test_tb is
    signal clk: std_logic; -- inputs
    signal dataout: std_logic_vector (7 downto 0); -- outputs
begin
    UUT: entity work.led_test port map(clk_100M => clk, dataout => dataout);
    tb1: process
    begin
            clk <= '1';
            assert(dataout = b"00000000") report "test failed, out not zero after first clock" severity ERROR;        
            
    end process tb1;
end TB;
