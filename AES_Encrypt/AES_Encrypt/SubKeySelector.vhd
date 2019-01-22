library IEEE;
use IEEE.std_logic_1164.all;

entity SubKeySelector is
port(
  EncryptKey      	: in  std_logic_vector(255 downto 0);
  DecryptKey      	: in  std_logic_vector(255 downto 0);

  decrypt 	: in  std_logic;
  key_l 	: in  std_logic_vector (1 downto 0);


  output     : out std_logic_vector(127 downto 0));
end SubKeySelector;

architecture rtl of SubKeySelector is

begin

selectSubKey : process(EncryptKey,DecryptKey,decrypt,key_l)
begin

if( decrypt = '0' ) then
-- ENCRYPT KEY SELECT
case key_l is

	when "00"=>
		output <= EncryptKey(127 downto 0);

	when "01"=>
		output <= EncryptKey(191 downto 64);

	when "10"=>
		output <= EncryptKey(255 downto 128);

	when others =>
		output <= X"00000000000000000000000000000000";
	end case;
	
else
-- DECRYPT KEY SELECT

case key_l is
	when "00"=>
		output <= DecryptKey(127 downto 0);

	when "01"=>
		output <= DecryptKey(191 downto 64);

	when "10"=>
		output <= DecryptKey(255 downto 128);

	when others =>
		output <= X"00000000000000000000000000000000";
end case;

end if;



end process selectSubKey;

end rtl;