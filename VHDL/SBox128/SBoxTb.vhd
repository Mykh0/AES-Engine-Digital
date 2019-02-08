LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity sboxTb is
end sboxTb;

architecture tb of sboxTb is
  component SubstituteBox
    port(
      s_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
      s_out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)   
    );
  end component;

  signal s_in  : std_logic_vector(127 downto 0);
  signal s_out : std_logic_vector(127 downto 0);

  signal delay : time := 20 ns;

  begin
    sBoxPort : SubstituteBox port map (
      s_in => s_in,
      s_out => s_out
    );

    process
      begin
        s_in <= x"00102030405060708090a0b0c0d0e0f0";
        wait for delay;
        assert s_out = x"63cab7040953d051cd60e0e7ba70e18c" report "Sbox wrong output" severity error;
        s_in <= x"89d810e8855ace682d1843d8cb128fe4";
        wait for delay;
        assert s_out = x"a761ca9b97be8b45d8ad1a611fc97369" report "Sbox wrong output" severity error;
    end process;
end tb;