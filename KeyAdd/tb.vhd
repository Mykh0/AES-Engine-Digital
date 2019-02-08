library IEEE;
use IEEE.std_logic_1164.all;

entity xortb is
end xortb;

architecture tb of xortb is
  component xor128
  port(
    a1      : in  std_logic_vector(127 downto 0);
    a2      : in  std_logic_vector(127 downto 0);
    output       : out std_logic_vector(127 downto 0)
  );
  end component;

  signal a1 : std_logic_vector(127 downto 0);
  signal a2 : std_logic_vector(127 downto 0);
  signal output : std_logic_vector(127 downto 0);

  signal delay : time := 20 ns;

  begin
    xorPortMap : xor128
      port map(
        a1 => a1,
        a2 => a2,
        output => output
      );

    process
      begin
      a1 <= x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
      a2 <= x"BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";
      wait for delay;
      assert output = x"11111111111111111111111111111111" report "xor wrong" severity error;
      a1 <= x"88888888888888888888888888888888";
      a2 <= x"11111111111111111111111111111111";
      wait for delay;
      assert output = x"99999999999999999999999999999999" report "xor wrong" severity error;    
      end process;
end tb;