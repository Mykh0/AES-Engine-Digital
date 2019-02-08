library ieee;
USE ieee.std_logic_1164.all; 

entity SerialInParallelOut is
  port
  (
    clk         : in std_logic;        
    nrst        : in std_logic;        
    SerialIn    : in std_logic;            
    ParallelOut : out std_logic_vector(255 downto 0)
  );
end SerialInParallelOut;

architecture sipo_rtl of SerialInParallelOut is
  begin
    process(clk, nrst, SerialIn)
      variable tmp : std_logic_vector(255 downto 0) := (others => '0');
      begin
        if(nrst = '0') then
          tmp := (others => '0');
        else
          if(rising_edge(clk)) then
            tmp := tmp(254 downto 0) & SerialIn;
            ParallelOut <= tmp;   
          end if;
        end if;
      end process;
end sipo_rtl;