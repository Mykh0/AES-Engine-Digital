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
  signal clk           : STD_LOGIC := '0';
  signal nrst          : STD_LOGIC;
  signal start         : STD_LOGIC;
  signal Decrypt       : STD_LOGIC;
  signal Key_I         : STD_LOGIC_VECTOR(127 downto 0);
  
  constant period : time := 10 ns;
  constant halfPeriod : time := 5 ns;
  constant doublePeriod : time := 20 ns;

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
      clk <= not clk after halfPeriod;
    end process clocking;
  
    test : process
    begin
      report "Begin Keyscheduler tests";  
      -- Test nrst
      nrst <= '0';
      wait for doublePeriod;
      assert Key_I = x"00000000000000000000000000000000" report "nrst wrong" severity note;
      Key_Length <= b"00";
      Key <= x"000000000000000000000000000000002b7e151628aed2a6abf7158809cf4f3c";
      wait for doublePeriod;
      assert Key_I = x"00000000000000000000000000000000" report "started too soon" severity error;
      nrst <= '1';
      wait for period;
      start <= '1';
      report "nrst tests finished";
      report "begin Encrypt tests";
      Decrypt <= '0';
      -- Test Key schedule Encrypt 128 bit
      wait for doublePeriod;
      start <= '0';
      assert Key_I = x"2b7e151628aed2a6abf7158809cf4f3c" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"a0fafe1788542cb123a339392a6c7605" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"f2c295f27a96b9435935807a7359f67f" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"3d80477d4716fe3e1e237e446d7a883b" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"ef44a541a8525b7fb671253bdb0bad00" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"d4d1c6f87c839d87caf2b8bc11f915bc" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"6d88a37a110b3efddbf98641ca0093fd" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"4e54f70e5f5fc9f384a64fb24ea6dc4f" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"ead27321b58dbad2312bf5607f8d292f" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"ac7766f319fadc2128d12941575c006e" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"d014f9a8c9ee2589e13f0cc8b6630ca6" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"d014f9a8c9ee2589e13f0cc8b6630ca6" report "Key scheduler incorrect" severity error;
      -- Test that only the keys relevant for AES are released
      wait for doublePeriod;
      assert Key_I = x"d014f9a8c9ee2589e13f0cc8b6630ca6" report "Key scheduler incorrect" severity error;  
      report "AES128 Tests finished";
      -- 192 bit test
      Key_Length <= b"01";
      Key <= x"00000000000000008e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b";
      start <= '1';
      wait for period;
      start <= '0';
      wait for period;
      assert Key_I = x"8e73b0f7da0e6452c810f32b809079e5" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"62f8ead2522c6b7bfe0c91f72402f5a5" report "Key scheduler incorrect" severity error;     
      wait for doublePeriod;
      assert Key_I = x"ec12068e6c827f6b0e7a95b95c56fec2" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"4db7b4bd69b5411885a74796e92538fd" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"e75fad44bb095386485af05721efb14f" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"a448f6d94d6dce24aa326360113b30e6" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"a25e7ed583b1cf9a27f939436a94f767" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"c0a69407d19da4e1ec1786eb6fa64971" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"485f703222cb8755e26d135233f0b7b3" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"40beeb282f18a2596747d26b458c553e" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"a7e1466c9411f1df821f750aad07d753" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"ca4005388fcc5006282d166abc3ce7b5" report "Key scheduler incorrect" severity error;  
      wait for doublePeriod;
      assert Key_I = x"e98ba06f448c773c8ecc720401002202" report "Key scheduler incorrect" severity error;
      report "AES192 tests finished";
      -- 256 bit test
      Key_Length <= b"10";
      start <= '1';
      Key <= x"603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4";
      wait for period;
      start <= '0';
      wait for period;
      assert Key_I = x"603deb1015ca71be2b73aef0857d7781" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"1f352c073b6108d72d9810a30914dff4" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"9ba354118e6925afa51a8b5f2067fcde" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"a8b09c1a93d194cdbe49846eb75d5b9a" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"d59aecb85bf3c917fee94248de8ebe96" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"b5a9328a2678a647983122292f6c79b3" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"812c81addadf48ba24360af2fab8b464" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"98c5bfc9bebd198e268c3ba709e04214" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"68007bacb2df331696e939e46c518d80" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"c814e20476a9fb8a5025c02d59c58239" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"de1369676ccc5a71fa2563959674ee15" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"5886ca5d2e2f31d77e0af1fa27cf73c3" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"749c47ab18501ddae2757e4f7401905a" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"cafaaae3e4d59b349adf6acebd10190d" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"fe4890d1e6188d0b046df344706c631e" report "Key scheduler incorrect" severity error;
      report "Key scheduler 256 bits tests complete";
      report "Encrypt tests complete";
      report "Begin decrypt tests";
      Decrypt <= '1';
      Key <= x"000000000000000000000000000000002b7e151628aed2a6abf7158809cf4f3c";
      Key_Length <= b"00";
      start <= '1';
      wait for period;
      start <= '0';
      wait for period;
      -- Test that only the keys relevant for AES are released
      assert Key_I = x"d014f9a8c9ee2589e13f0cc8b6630ca6" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"ac7766f319fadc2128d12941575c006e" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"ead27321b58dbad2312bf5607f8d292f" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"4e54f70e5f5fc9f384a64fb24ea6dc4f" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"6d88a37a110b3efddbf98641ca0093fd" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"d4d1c6f87c839d87caf2b8bc11f915bc" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"ef44a541a8525b7fb671253bdb0bad00" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"3d80477d4716fe3e1e237e446d7a883b" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"f2c295f27a96b9435935807a7359f67f" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"a0fafe1788542cb123a339392a6c7605" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"2b7e151628aed2a6abf7158809cf4f3c" report "Key scheduler incorrect" severity error;
      -- 192 bit test
      Key_Length <= b"01";
      Key <= x"00000000000000008e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b";
      start <= '1';
      wait for period;
      start <= '0';
      wait for period;
      assert Key_I = x"e98ba06f448c773c8ecc720401002202" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"ca4005388fcc5006282d166abc3ce7b5" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"a7e1466c9411f1df821f750aad07d753" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"40beeb282f18a2596747d26b458c553e" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"485f703222cb8755e26d135233f0b7b3" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"c0a69407d19da4e1ec1786eb6fa64971" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"a25e7ed583b1cf9a27f939436a94f767" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"a448f6d94d6dce24aa326360113b30e6" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"e75fad44bb095386485af05721efb14f" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"4db7b4bd69b5411885a74796e92538fd" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"ec12068e6c827f6b0e7a95b95c56fec2" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"62f8ead2522c6b7bfe0c91f72402f5a5" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"8e73b0f7da0e6452c810f32b809079e5" report "Key scheduler incorrect" severity error;
      report "AES192 tests finished";
      -- 256 bit test
      Key_Length <= b"10";
      start <= '1';
      Key <= x"603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4";
      wait for period;
      start <= '0';
      wait for period;
      assert Key_I = x"fe4890d1e6188d0b046df344706c631e" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"cafaaae3e4d59b349adf6acebd10190d" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"749c47ab18501ddae2757e4f7401905a" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"5886ca5d2e2f31d77e0af1fa27cf73c3" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"de1369676ccc5a71fa2563959674ee15" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"c814e20476a9fb8a5025c02d59c58239" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"68007bacb2df331696e939e46c518d80" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"98c5bfc9bebd198e268c3ba709e04214" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"812c81addadf48ba24360af2fab8b464" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"b5a9328a2678a647983122292f6c79b3" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"d59aecb85bf3c917fee94248de8ebe96" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"a8b09c1a93d194cdbe49846eb75d5b9a" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"9ba354118e6925afa51a8b5f2067fcde" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"1f352c073b6108d72d9810a30914dff4" report "Key scheduler incorrect" severity error;
      wait for doublePeriod;
      assert Key_I = x"603deb1015ca71be2b73aef0857d7781" report "Key scheduler incorrect" severity error;
      report "Key scheduler 256 bits tests complete";
      report "Key scheduler tests complete";
    end process test;
end rtl;