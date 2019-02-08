library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture tb of testbench is
  component inverseMixcolumns
    port
    (
      RawData : IN STD_LOGIC_VECTOR(127 downto 0);
      Encrypted : OUT STD_LOGIC_VECTOR(127 downto 0)     
    );
  end component;

  signal RawData : STD_LOGIC_VECTOR(127 downto 0);
  signal Encrypted : STD_LOGIC_VECTOR(127 downto 0);

  begin
    testPort : inverseMixColumns port map
    (
      RawData => RawData,
      Encrypted => Encrypted
    );

    test : process
      impure function ass(test : std_logic_vector(127 downto 0)) return boolean is
        begin
          assert Encrypted = test report "Inverse MixColumns WRONG" severity error;
          return true;
      end ass;
      variable delay : time := 2 ns;
      variable foo : boolean := false;
      begin
        RawData <= x"bd6e7c3df2b5779e0b61216e8b10b689";
        wait for delay;
        foo := ass(x"4773b91ff72f354361cb018ea1e6cf2c");
        
        RawData <= x"fde3bad205e5d0d73547964ef1fe37f1";
        wait for delay;
        foo := ass(x"2d7e86a339d9393ee6570a1101904e16");
        
        RawData <= x"d1876c0f79c4300ab45594add66ff41f";
        wait for delay;
        foo := ass(x"39daee38f4f1a82aaf432410c36d45b9");
        
        RawData <= x"c62fe109f75eedc3cc79395d84f9cf5d";
        wait for delay;
        foo := ass(x"9a39bf1d05b20a3a476a0bf79fe51184");
        
        RawData <= x"c81677bc9b7ac93b25027992b0261996";
        wait for delay;
        foo := ass(x"18f78d779a93eef4f6742967c47f5ffd");
        
        RawData <= x"247240236966b3fa6ed2753288425b6c";
        wait for delay;
        foo := ass(x"85cf8bf472d124c10348f545329c0053");
        
        RawData <= x"fa636a2825b339c940668a3157244d17";
        wait for delay;
        foo := ass(x"fc1fc1f91934c98210fbfb8da340eb21");
        
        RawData <= x"4915598f55e5d7a0daca94fa1f0a63f7";
        wait for delay;
        foo := ass(x"076518f0b52ba2fb7a15c8d93be45e00");
        
        RawData <= x"89d810e8855ace682d1843d8cb128fe4";
        wait for delay;
        foo := ass(x"ef053f7c8b3d32fd4d2a64ad3c93071a");
        
        RawData <= x"88ec930ef5e7e4b6cc32f4c906d29414";
        wait for delay;
        foo := ass(x"5cc7aecce3c872194ae5ef8309a933c7");
        
        RawData <= x"a906b254968af4e9b4bdb2d2f0c44336";
        wait for delay;
        foo := ass(x"b7113ed134e85489b20866b51d4b2c3b");
        
        RawData <= x"7255dad30fb80310e00d6c6b40d0527c";
        wait for delay;
        foo := ass(x"ef3b1be1b9b0e64bdcb79f1e0a707fbb");
        
        RawData <= x"0c0370d00c01e622166b8accd6db3a2c";
        wait for delay;
        foo := ass(x"592460b248832b2952e0b831923048f1");
        
        RawData <= x"671ef1fd4e2a1e03dfdcb1ef3d789b30";
        wait for delay;
        foo := ass(x"0b8a7783417ae3a1f9492dc0c641a7ce");
        
        RawData <= x"80121e0776fd1d8a8d8c31bc965d1fee";
        wait for delay;
        foo := ass(x"4ee1ddf9301d6352c9ad769ef8d20515");
        
        RawData <= x"22ffc916a81474416496f19c64ae2532";
        wait for delay;
        foo := ass(x"1008ffe53b36ee6af27b42549b8a7bb7");
        
        RawData <= x"f75c7778a327c8ed8cfebfc1a6c37f53";
        wait for delay;
        foo := ass(x"7f69ac1ed939ebaac8ece3cb12e159e3");
        
        RawData <= x"cb02818c17d2af9c62aa64428bb25fd7";
        wait for delay;
        foo := ass(x"cfaf16b2570c18b52e7fef50cab267ae");
        
        RawData <= x"4f63760643e0aa85aff8c9d041fa0de4";
        wait for delay;
        foo := ass(x"794cf891177bfd1d8a327086f3831b39");
        
        RawData <= x"bd6e7c3df2b5779e0b61216e8b10b689";
        wait for delay;

        report "Inverse MixColumns Tests done";
    end process test;
end tb;