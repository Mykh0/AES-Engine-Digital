entity AES_EngineTb is
end AES_EngineTb;

Architecture testbench of AES_EngineTb is
  component AES_Engine is
    port
    (
 	  clk :  IN  STD_LOGIC;
	  nrst :  IN  STD_LOGIC;
	  start :  IN  STD_LOGIC;
	  decrypt :  IN  STD_LOGIC;
	  engine_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
	  key :  IN  STD_LOGIC_VECTOR(255 DOWNTO 0);
	  key_length :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
	  ready :  OUT  STD_LOGIC;
	  engine_out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)     
    );
    end component;

  begin
    signal halfClk : time := 10 ns;
    signal clk : time := 20 ns;

    test : process
      begin
        
      end process;
end testbench;