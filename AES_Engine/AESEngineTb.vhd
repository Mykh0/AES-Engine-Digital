LIBRARY ieee;
USE ieee.std_logic_1164.all; 

entity aesEngineTb is
end aesEngineTb;

architecture tb of aesEngineTb is
  component AES_Engine
    PORT
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
  
    signal clk        : std_logic := '0';
    signal nrst       : std_logic;
    signal start      : std_logic;
    signal decrypt    : std_logic;
    signal engine_in  : std_logic_vector(127 downto 0);
    signal key        : std_logic_vector(255 downto 0);
    signal key_length : std_logic_vector(1 downto 0);
    signal ready      : std_logic;
    signal engine_out : std_logic_vector(127 downto 0);

    signal delay : time := 10 ns;
    signal clock : time := 20 ns;
    signal aesDelay : time := 400 ns;

  begin
    aesEnginePort : AES_Engine port map (
      clk        => clk       ,       
      nrst       => nrst      ,       
      start      => start     ,       
      decrypt    => decrypt   ,     
      engine_in  => engine_in ,       
      key        => key       ,   
      key_length => key_length,
      ready      => ready     ,   
      engine_out => engine_out
      );

    process
      begin
        clk <= not clk;
        wait for delay;
      end process;

    process
      begin
        nrst <= '0';
        wait for clock;
        nrst <= '1';
        start <= '1';
        decrypt <= '0';
        key_length <= b"00";
        engine_in <= x"00112233445566778899aabbccddeeff";
        key <= x"00000000000000000000000000000000000102030405060708090a0b0c0d0e0f";
        wait for clock;
        start <= '0';
        wait for aesDelay;
        wait for aesDelay;
        wait for aesDelay;
        assert ready = '1' report "Ready signal is not logic high" severity error;
        assert engine_out = x"69c4e0d86a7b0430d8cdb78070b4c55a" report "AES128 encrypt is wrong" severity error;
        start <= '1';
        decrypt <= '0';
        key_length <= b"01";
        engine_in <= x"00112233445566778899aabbccddeeff";
        key <= x"0000000000000000000102030405060708090a0b0c0d0e0f1011121314151617";
        wait for clock;
        start <= '0';
        wait for aesDelay;
        wait for aesDelay;
        wait for aesDelay;
        assert ready = '1' report "Ready signal is not logic high" severity error;
        assert engine_out = x"dda97ca4864cdfe06eaf70a0ec0d7191" report "AES192 encrypt wrong" severity error;
        start <= '1';
        decrypt <= '0';
        key_length <= b"10";
        engine_in <= x"00112233445566778899aabbccddeeff";
        key <= x"000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f";
        wait for clock;
        start <= '0';
        wait for aesDelay;
        wait for aesDelay;
        wait for aesDelay;
        assert ready = '1' report "Ready signal is not logic high" severity error;
        assert engine_out = x"8ea2b7ca516745bfeafc49904b496089" report "AES256 encrypt wrong" severity error;
        start <= '1';
        decrypt <= '1';
        key_length <= b"00";
        engine_in <= x"69c4e0d86a7b0430d8cdb78070b4c55a";
        key <= x"00000000000000000000000000000000000102030405060708090a0b0c0d0e0f";
        wait for clock;
        start <= '0';
        wait for aesDelay;
        wait for aesDelay;
        wait for aesDelay;
        assert ready = '1' report "Ready signal is not logic high" severity error;
        assert engine_out = x"00112233445566778899aabbccddeeff" report "AES128 decrypt is wrong" severity error;
        start <= '1';
        decrypt <= '1';
        key_length <= b"01";
        engine_in <= x"dda97ca4864cdfe06eaf70a0ec0d7191";
        key <= x"0000000000000000000102030405060708090a0b0c0d0e0f1011121314151617";
        wait for clock;
        start <= '0';
        wait for aesDelay;
        wait for aesDelay;
        wait for aesDelay;
        assert ready = '1' report "Ready signal is not logic high" severity error;
        assert engine_out = x"00112233445566778899aabbccddeeff" report "AES192 decrypt wrong" severity error;
        start <= '1';
        decrypt <= '1';
        key_length <= b"10";
        engine_in <= x"8ea2b7ca516745bfeafc49904b496089";
        key <= x"000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f";
        wait for clock;
        start <= '0';
        wait for aesDelay;
        wait for aesDelay;
        wait for aesDelay;
        assert ready = '1' report "Ready signal is not logic high" severity error;
        assert engine_out = x"00112233445566778899aabbccddeeff" report "AES256 decrypt wrong" severity error;
        end process;
      end tb;