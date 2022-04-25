library ieee;
USE ieee.std_logic_1164.all;

entity reg2 is
    port(
    clk: in std_logic;
    d0: in std_logic;
    d1: in std_logic;
    load: in std_logic;
    res: in std_logic;
    q0: out std_logic;
    q1: out std_logic
    );
end reg2 ;

architecture beh of reg2 is
    signal q0_s, q0_ns, q1_s, q1_ns : std_logic;
begin
    reg: PROCESS(clk, res)
    begin
        if res = '1' then
            q0_s <= '0';
            q1_s <= '1';
        elsif clk'event AND clk = '1' then
            q0_s <= q0_ns;
            q1_s <= q1_ns;
        end if;
    end process reg;

    q0 <= q0_s after 2 ns;
    q1 <= q1_s after 2 ns;

    mux: process (load, q0_s, q1_s, d0, d1)
    begin
        if load = '1' then
            q0_ns <= d0 after 3 ns;
            q1_ns <= d1 after 3 ns;
        else
            q0_ns <= q0_s after 4 ns;
            q1_ns <= q1_s after 4 ns;
        end if;
    end process mux;
end beh;

architecture beh1 of reg2 is
    signal q0_s, q1_s : std_logic;
begin

    reg: PROCESS(clk, res)
    begin
        if res = '1' then
            q0_s <= '0';
            q1_s <= '1';
        elsif clk'event AND clk = '1' then
            if load = '1' then
                q0_s <= d0;
                q1_s <= d1;
            end if;
        end if;
    end process reg;

    q0 <= q0_s after 2 ns;
    q1 <= q1_s after 2 ns;
end beh1;

architecture struct of reg2 is
    signal o1 : std_logic;
    signal o2 : std_logic;
    signal q0_internal : std_logic;
    signal q1_internal: std_logic;

    component ff2
    port(
        clk: in std_logic;
        d0: in std_logic;
        d1: in std_logic;
        res: in std_logic;
        q0: out std_logic;
        q1: out std_logic
    );
    end component;
    
    component mux2
    port (
        a1: in std_logic;
        a2: in std_logic;
        b1: in std_logic;
        b2: in std_logic;
        sel: in std_logic;
        o1: out std_logic;
        o2: out std_logic
    );
    end component;
begin
    I1: ff2
    port map(
        clk => clk, d0 => o1, d1 => o2,
        res => res, q0 => q0_internal, q1 => q1_internal
    );
    I0: mux2 
    port map (
        a1 => d0, a2 => d1, b1 => q0_internal,
        b2 => q1_internal, sel => load, o1 => o1, o2 => o2
    );
    q0 <= q0_internal;
    q1 <= q1_internal;

    end struct;
