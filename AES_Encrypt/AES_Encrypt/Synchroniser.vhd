LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Synchroniser IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(		
		start_engine 	:	IN 	STD_LOGIC;
		clk				:	IN		STD_LOGIC;
		nrst				:	IN		STD_LOGIC;
		key_l				:	IN		STD_LOGIC_VECTOR(1 downto 0);
		
		engine_ready	:	OUT	STD_LOGIC;
		start_core		:	OUT 	STD_LOGIC;
		start_scheduler:	OUT	STD_LOGIC;
		reset_engine	:	OUT	STD_LOGIC
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

END entity;

ARCHITECTURE rtl of Synchroniser IS
	type synch_state is (WaitForStart, StartScheduler, StartCore, EndScheduler, EndCore, EngineReady);
	
	signal State : synch_state;
	

BEGIN

behaviour : process(clk, nrst)

	variable cround	:	integer  range 0 to 32;	-- current round count
	variable mround	:	integer	range 0 to 32;	-- maximal round count
	
begin
	if nrst = '0' then
	State <= WaitForStart;
	
	start_core <= '0';
	start_scheduler <= '0';
	cround := 0;
	mround := 0;
	reset_engine <= '0';
	engine_ready <= '0';
	
	elsif rising_edge(clk) then
	case State is
		when WaitForStart =>
		reset_engine <= '1';
		engine_ready <= '1';
		
		if start_engine = '1'then
		cround := 0;
		State <= StartScheduler;
		engine_ready <= '0';
		end if;
		
		when StartScheduler =>
		State <= StartCore;
		
		case key_l is
			when "00" =>
				mround := 22;
			when "01" =>
				mround := 26; 
			when "10" =>
					mround := 30; 
			when others => mround := 0; --do nothing/reserved
		end case;
		
		start_scheduler <= '1';
		
		cround := cround +1;
		
		when StartCore =>
		start_core <= '1';
		cround := cround +1;
		
		State <= endCore;
		
		when endCore =>
		start_core <= '0';
		cround := cround + 1;
		
		if(cround >= mround) then
		State <= endScheduler;
		end if;
		
		when endScheduler =>
		State <= EngineReady;
		start_scheduler <= '0';
		
	
		when EngineReady =>
		State <= WaitForStart;
		engine_ready <= '1';
		reset_engine <= '0';
	
	end case;
	
	end if;


end process;

END architecture;