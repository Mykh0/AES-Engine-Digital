LIBRARY ieee;
USE ieee.std_logic_1164.all;


--  Entity Declaration
ENTITY remap_block IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(
		virtual_in : IN STD_LOGIC_VECTOR(7 downto 0);
		virtual_out : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

END remap_block;


ARCHITECTURE remap_block_architecture OF remap_block IS

BEGIN
	process(virtual_in)
	
	begin
	virtual_out <= virtual_in;
	end process;

END remap_block_architecture;