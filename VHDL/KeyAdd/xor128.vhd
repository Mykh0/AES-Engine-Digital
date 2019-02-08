library IEEE;
use IEEE.std_logic_1164.all;

entity xor128 is
port(
  a1      : in  std_logic_vector(127 downto 0);
  a2      : in  std_logic_vector(127 downto 0);
  output       : out std_logic_vector(127 downto 0));
end xor128;

architecture rtl of xor128 is

begin

behaviour : process(a1,a2)
begin

output <= a1 xor a2; 

end process behaviour;

end rtl;