library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
port(
  a1      : in  std_logic_vector(127 downto 0);
  a2      : in  std_logic_vector(127 downto 0);
  last_round : in  std_logic;
  output       : out std_logic_vector(127 downto 0));
end mux2;

architecture rtl of mux2 is

begin

p_mux : process(a1,a2,last_round)
begin

if( last_round = '1' ) then
output <= a1;


else
output <= a2; 

end if;

end process p_mux;

end rtl;