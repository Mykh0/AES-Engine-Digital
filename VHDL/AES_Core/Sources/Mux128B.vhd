library IEEE;
use IEEE.std_logic_1164.all;

entity Mux128B is
port(
  a1      : in  std_logic_vector(127 downto 0);
  a2      : in  std_logic_vector(127 downto 0);
  sel : in  std_logic;
  output       : out std_logic_vector(127 downto 0));
end Mux128B;

architecture rtl of Mux128B is

begin

p_mux : process(a1,a2,sel)
begin

if( sel = '1' ) then
output <= a1;


else
output <= a2; 

end if;

end process p_mux;

end rtl;