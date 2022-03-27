LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ff2 IS
   PORT( 
      clk : IN     std_logic;
      d0  : IN     std_logic;
      d1  : IN     std_logic;
      res : IN     std_logic;
      q0  : OUT    std_logic;
      q1  : OUT    std_logic
   );
END ff2 ;

ARCHITECTURE beh OF ff2 IS
  SIGNAL q0_s, q1_s : std_logic;
BEGIN
  
  reg: PROCESS (clk, res)
  BEGIN 
    IF res = '1' THEN                   -- Asynchroner Reset
      q0_s <= '0';
      q1_s <= '0';
    ELSIF clk'event AND clk = '1' THEN  -- Steigende Taktflanke
      q0_s <= d0;
      q1_s <= d1;
    END IF;
  END PROCESS reg;

  q0 <= q0_s AFTER 2 ns;
  q1 <= q1_s AFTER 2 ns;
  
END beh;
