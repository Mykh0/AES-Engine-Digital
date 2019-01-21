LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ExpandKeysTestbench is
end ExpandKeysTestbench;

architecture rtl of ExpandKeysTestbench is
  component ExpandKeys
    port
    (
      Key           : IN    STD_LOGIC_VECTOR(255 downto 0);
      Key_Length    : IN    STD_LOGIC_VECTOR(1 downto 0);
	  clk           : IN    STD_LOGIC;
	  nrst          : IN    STD_LOGIC;
	  start         : IN    STD_LOGIC;
	  Decrypt       : IN    STD_LOGIC;
	  Key_I         : OUT   STD_LOGIC_VECTOR(127 downto 0)
    );
  end component;

  signal Key           : STD_LOGIC_VECTOR(255 downto 0);
  signal Key_Length    : STD_LOGIC_VECTOR(1 downto 0);
  signal clk           : STD_LOGIC;
  signal nrst          : STD_LOGIC;
  signal start         : STD_LOGIC;
  signal Decrypt       : STD_LOGIC;
  signal Key_I         : STD_LOGIC_VECTOR(127 downto 0);

  begin
    KeySchedulerPort : ExpandKeys port map
    (
        Key        => Key,         
        Key_Length => Key_Length,
        clk        => clk,       
        nrst       => nrst,      
        start      => start,     
        Decrypt    => Decrypt,   
        Key_I      => Key_I     
    );

    clocking : process(clk)
    begin
      clk <= not clk after 8 ns;
    end process clocking;
  
    test : process
    begin
      nrst <= '0';
      wait for 10 ns;
      assert Key_I = x"00000000000000000000000000000000" report "nrst wrong" severity note;
      Key_Length <= b"00";
      Key <= x"000000000000000000000000000000002b7e151628aed2a6abf7158809cf4f3c";
      wait for 10 ns;
      assert Key_I = x"00000000000000000000000000000000" report "started too soon" severity error;
      start <= '1';
      wait for 20 ns;
      assert Key_I = x"2b7e151628aed2a6abf7158809cf4f3c" report "Key scheduler incorrect" severity error;
      report "Key scheduler OK";
    end process test;
end rtl;