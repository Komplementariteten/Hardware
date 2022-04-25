LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY mux2 IS
   PORT( 
      a1  : IN     std_logic;
      a2  : IN     std_logic;
      b1  : IN     std_logic;
      b2  : IN     std_logic;
      sel : IN     std_logic;
      o1  : OUT    std_logic;
      o2  : OUT    std_logic
   );
END mux2 ;

ARCHITECTURE beh OF mux2 IS
BEGIN
  
  mux: PROCESS (a1, a2, b1, b2, sel)
  BEGIN
    IF sel = '1' THEN
      o1 <= a1 AFTER 3 ns;
      o2 <= a2 AFTER 3 ns;
    ELSE
      o1 <= b1 AFTER 4 ns;
      o2 <= b2 AFTER 4 ns;
    END IF;
  END PROCESS mux;

END beh;
