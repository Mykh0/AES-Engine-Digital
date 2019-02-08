LIBRARY ieee;
USE ieee.std_logic_1164.all; 

entity aesCoreTb is
end aesCoreTb;

architecture tb of aesCoreTb is
  component AES_CORE
    port (
	  keyAdd_only :  IN  STD_LOGIC;
	  last_round :  IN  STD_LOGIC;
	  decrypt :  IN  STD_LOGIC;
	  AES_Core_In :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
	  ki_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
	  AES_Core_Out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)      
    );
  end component;

  signal keyAdd_only : STD_LOGIC;
  signal last_round :   STD_LOGIC;
  signal decrypt :     STD_LOGIC;
  signal AES_Core_In : STD_LOGIC_VECTOR(127 DOWNTO 0);
  signal ki_in :       STD_LOGIC_VECTOR(127 DOWNTO 0);
  signal AES_Core_Out :  STD_LOGIC_VECTOR(127 DOWNTO 0);

  signal delay : time := 20 ns;

  begin
    aesPortMap : AES_CORE port map (
        keyAdd_only  => keyAdd_only ,
        last_round  => last_round ,
        decrypt     => decrypt    ,
        AES_Core_In  => AES_Core_In ,
        ki_in       => ki_in      ,
        AES_Core_Out => AES_Core_Out
    );
    process
      begin
      AES_Core_In <= x"00102030405060708090a0b0c0d0e0f0";
      ki_in <= x"d6aa74fdd2af72fadaa678f1d6ab76fe";
      decrypt <= '0';
      last_round <= '0';
      keyAdd_only <= '0';
      wait for delay;      
      assert AES_Core_Out = x"89d810e8855ace682d1843d8cb128fe4" report "Normal Encrypt path wrong" severity error;
      report "Test 1/6 Complete : Encrypt normal path";
      AES_Core_In <= x"00112233445566778899aabbccddeeff";
      ki_in <= x"000102030405060708090a0b0c0d0e0f";
      decrypt <= '0';
      last_round <= '0';
      keyAdd_only <= '1';
      wait for delay;      
      assert AES_Core_Out = x"00102030405060708090a0b0c0d0e0f0" report "First round Encrypt path wrong" severity error;
      report "Test 2/6 Complete : Encrypt first round";
      AES_Core_In <= x"bd6e7c3df2b5779e0b61216e8b10b689";
      ki_in <= x"13111d7fe3944a17f307a78b4d2b30c5";
      decrypt <= '0';
      last_round <= '1';
      keyAdd_only <= '0';
      wait for delay;          
      assert AES_Core_Out = x"69c4e0d86a7b0430d8cdb78070b4c55a" report "Last round Encrypt path wrong" severity error;
      report "Test 3/6 Complete : Encrypt last round";  
      decrypt <= '1';
      last_round <= '0';
      keyAdd_only <= '0';
      AES_Core_In <= x"7ad5fda789ef4e272bca100b3d9ff59f";
      ki_in <= x"549932d1f08557681093ed9cbe2c974e";
      wait for delay;       
      assert AES_Core_Out = x"54d990a16ba09ab596bbf40ea111702f" report "Normal decrypt path wrong" severity error;
      report "Test 4/6 Complete : Decrypt normal path";     
      AES_Core_In <= x"69c4e0d86a7b0430d8cdb78070b4c55a";
      ki_in <= x"13111d7fe3944a17f307a78b4d2b30c5";
      decrypt <= '1';
      last_round <= '0';
      keyAdd_only <= '1';
      wait for delay;         
      assert AES_Core_Out = x"7ad5fda789ef4e272bca100b3d9ff59f" report "First round decrypt path wrong" severity error;
      report "Test 5/6 Complete : Decrypt first round";   
      AES_Core_In <= x"6353e08c0960e104cd70b751bacad0e7";
      ki_in <= x"000102030405060708090a0b0c0d0e0f";
      decrypt <= '1';
      last_round <= '1';
      keyAdd_only <= '0';
      wait for delay;       
      assert AES_Core_Out = x"00112233445566778899aabbccddeeff" report "Last round decrypt path wrong" severity error;
      wait for delay;      
      report "Test 6/6 Complete : Decrypt last round";     
      end process;
end tb;