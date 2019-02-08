LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY KeyAdd IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(
		ki_in : IN STD_LOGIC_VECTOR(127 downto 0);
		ka_in : IN STD_LOGIC_VECTOR(127 downto 0);
		ka_out : OUT STD_LOGIC_VECTOR(127 downto 0)
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!
END KeyAdd;

ARCHITECTURE KeyAdd_architecture OF KeyAdd IS


BEGIN

process(ka_in,ki_in)
begin

ka_out <= ki_in xor ka_in;

end process;

END KeyAdd_architecture;
