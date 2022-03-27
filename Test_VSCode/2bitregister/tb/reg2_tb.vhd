library ieee;
use IEEE.std_logic_1164.all;

entity test_bench is
end test_bench;

architecture reg2_test of test_bench is
    component reg2 
        port( 
            clk : in std_logic;
            d0: in std_logic;
            d1: in std_logic;
            load: in std_logic;
            res: in std_logic;
            q0: out std_logic;
            q1: out std_logic
        );
    end component;

 -- stimulus signal
signal s_clk: std_logic := '0';
signal s_d0: std_logic := '0';
signal s_d1: std_logic := '0';
signal s_load: std_logic := '0';
signal s_res: std_logic := '0';

signal r_q0: std_logic;
signal r_q1: std_logic;

begin
    -- verschaltung des duv mit den stimulus/response-signalen
    u1: reg2
    port map(clk => s_clk, d0 => s_d0, d1 => s_d1,
        load => s_load, res => s_res, q0 => r_q0, q1 => r_q1);

    -- taktgenerator
    s_clk <= not s_clk after 5 ns;

    -- stimuli
    stim: process
        begin
            s_res <= '1';
            wait for 20 ns;
            s_res <= '0';
            s_d0 <= '1';
            wait for 20 ns;
            s_load <= '1';
            wait;
        end process stim;

        stop_sim: process
            begin
                wait for 100 ns;
                assert false report "simulation stopped" severity failure;
            end process stop_sim;

        end reg2_test;