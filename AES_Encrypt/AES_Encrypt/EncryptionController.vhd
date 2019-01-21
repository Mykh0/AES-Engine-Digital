library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AES_encrypt_controller is

	port(
	clk 	: in std_logic;
	nrst 	: in std_logic;

	start_core	: in std_logic;
	key_l			: in std_logic_vector(1 downto 0);

	load_input	: out std_logic;
	load_output : out std_logic;
	load_loop	: out std_logic;
	load_key		: out std_logic;

	mux_s			: out std_logic;
	last_round 	: out std_logic
	);


end entity;

architecture sim of AES_encrypt_controller is
	type t_state is(WaitStart, FirstEncrypt0, FirstEncrypt1, normalEncrypt0
	,normalEncrypt1, LastEncrypt0, LastEncrypt1);
	type boolean is (false,true);

	signal State : t_state;

begin
	process(clk,nrst) is
	
	variable nRounds 	: integer range 0 to 12; -- number of NORMALrounds to loop
	variable cRounds 	: integer range 0 to 12; -- number of NORMALrounds that have been looped
	
	begin
		if nrst = '0' then
			load_input	<= '0';
			load_output <= '0';
			load_loop	<= '0';
			load_key		<= '0';
			
			mux_s <= '0';
			last_round <= '0';
			
			nRounds := 0;
			cRounds := 0;

		elsif rising_edge(clk) then
		
		case State is
			when WaitStart =>
				-- everything off	
				load_input	<= '0';
				load_output <= '0';
				load_loop	<= '0';
				load_key		<= '0';
				
				mux_s <= '0';
				last_round <= '0';
				
				nRounds := 0;
				cRounds := 0;
				
				if start_core = '1' then
				State <= FirstEncrypt0;	
				end if;
		
			when FirstEncrypt0 =>
			State <= FirstEncrypt1;
			--first flank of the firt encrypt state
				
				case key_l is
				when "00" =>
					nRounds := 8;
				when "01" =>
					nRounds := 10; 
				when "10" =>
					nRounds := 12; 
				when others => nRounds := 0; --do nothing/reserved
				end case;
				
				load_input <= '1';
				load_key <= '1';
		
			when FirstEncrypt1	=>
				State <= normalEncrypt0;
				--second flank of the first encrypt state
				
				load_input <= '0';
				load_key <= '0';
				load_loop <= '1';
				
			when normalEncrypt0 =>
				State <= normalEncrypt1;
				--first flank of the normal encrypt state
				
				mux_s <= '1';
				load_key <= '1';
				load_loop <= '0';
				
			when normalEncrypt1 =>
				State <= normalEncrypt0;
				--second flank of the normal encrypt state
				
				load_key <= '0';
				load_loop <= '1';
				
				cRounds := cRounds + 1;
				
				if (cRounds >= nRounds) then
				State <= LastEncrypt0;
				end if;
				
			when LastEncrypt0 => 
				State <= LastEncrypt1;
				--first flank of the last encrypt state
				
				last_round <= '1';
				
				load_key <= '1';
				load_loop <= '0';
				
			when LastEncrypt1 =>
				State <= WaitStart;
				--second flank of the last encrypt state
				
				load_key <= '0';
				load_loop <= '1';
				load_output <= '1';
			
			when others => 
				State <= WaitStart;-- loop back to start.
			
		end case;

		end if;


	end process;

end architecture;
