LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity synchroniserTb is
end entity;

architecture tb of synchroniserTb is
  component synchroniser
    port (
	  start_engine 	:	IN 	STD_LOGIC;
	  clk				:	IN		STD_LOGIC;
	  nrst				:	IN		STD_LOGIC;
	  key_l				:	IN		STD_LOGIC_VECTOR(1 downto 0);
	  
	  engine_ready	:	OUT	STD_LOGIC;
	  start_core		:	OUT 	STD_LOGIC;
	  start_scheduler:	OUT	STD_LOGIC      
    );
    end component;

  signal start_engine 	: std_logic;
  signal clk			: std_logic := '0';
  signal nrst			: std_logic;
  signal key_l			: std_logic_vector(1 downto 0);
  signal engine_ready	: std_logic;
  signal start_core	    : std_logic;
  signal start_scheduler    : std_logic;
   
  signal halfPeriod : time := 10 ns;
  signal fullPeriod : time := 20 ns;
  signal testOne : time := 480 ns;
  signal testTwo : time := 560 ns;
  signal testThree : time := 640 ns;

  begin
    synchroniserPortmap : synchroniser port map(
      start_engine 	=> start_engine 	,
      clk			    => clk			,      
      nrst			=> nrst			,        
      key_l			=> key_l			,           
      engine_ready	=> engine_ready	,        
      start_core	    => start_core	    ,    
      start_scheduler => start_scheduler       
    );

    clockProcess : process
      begin
        clk <= not clk;
        wait for halfPeriod;
      end process;
  
    testbench : process
      begin
        nrst <= '0';
        wait for fullPeriod;
        nrst <= '1';
        key_l <= b"00";
        start_engine <= '1';
        wait for fullPeriod;
        start_engine <= '0';
        wait for fullPeriod;
        wait for fullPeriod;
        assert start_core = '1' report "start_core not logic high" severity error;
        assert start_scheduler = '1' report "start_scheduler not logic high" severity error;
        wait for fullPeriod;
        assert start_core = '0' report "start_core not logic low" severity error;
        assert start_scheduler = '0' report "start_scheduler not logic low" severity error;
        wait for testOne;
        assert engine_ready = '1' report "engine_ready not logic high" severity error;

        key_l <= b"01";
        start_engine <= '1';
        wait for fullPeriod;
        start_engine <= '0';
        wait for fullPeriod;
        wait for fullPeriod;
        assert start_core = '1' report "start_core not logic high" severity error;
        assert start_scheduler = '1' report "start_scheduler not logic high" severity error;
        wait for fullPeriod;
        assert start_core = '0' report "start_core not logic low" severity error;
        assert start_scheduler = '0' report "start_scheduler not logic low" severity error;
        wait for testTwo;
        assert engine_ready = '1' report "engine_ready not logic high" severity error;

        key_l <= b"10";
        start_engine <= '1';
        wait for fullPeriod;
        start_engine <= '0';
        wait for fullPeriod;
        wait for fullPeriod;
        assert start_core = '1' report "start_core not logic high" severity error;
        assert start_scheduler = '1' report "start_scheduler not logic high" severity error;
        wait for fullPeriod;
        assert start_core = '0' report "start_core not logic low" severity error;
        assert start_scheduler = '0' report "start_scheduler not logic low" severity error;
        wait for testThree;
        assert engine_ready = '1' report "engine_ready not logic high" severity error;
    end process;
end tb;