LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY LoadRegister IS PORT(
    data_in   	: IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    load  		: IN STD_LOGIC; -- load/enable.
    nrst 		: IN STD_LOGIC; -- async. clear.
    clk 		: IN STD_LOGIC; 
    q   		: OUT STD_LOGIC_VECTOR(127 DOWNTO 0) -- output
);
END LoadRegister;

ARCHITECTURE description OF LoadRegister IS

BEGIN

    process(clk, nrst)
	 variable data : std_logic_vector(127 downto 0);
	 
    begin
        if nrst = '0' then
            data := X"00000000000000000000000000000000";
			
				
        elsif rising_edge(clk) and (load = '1' )then
                data := data_in;
        end if;
		  
		  q <= data;
		  
    end process;
END description;