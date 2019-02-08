library ieee;
USE ieee.std_logic_1164.all; 

entity piso is
  port
  (
    clk        : in std_logic;     
    nrst       : in std_logic;     
    ParallelIn : in std_logic_vector(255 downto 0); 
    SerialOut  : out std_logic
  );
end piso;

architecture piso_rtl of piso is
  begin
    process(clk ,nrst, ParallelIn)
      begin
        if(nrst = '0') then
          
end piso_rtl;