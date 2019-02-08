LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Testbench is
end Testbench;

architecture rtl of Testbench is
  component InverseShiftRow
    port
    (
      data_in : in std_logic_vector(127 downto 0);
      data_out : out std_logic_vector(127 downto 0)
    );
  end component;

  signal data_in : std_logic_vector(127 downto 0);
  signal data_out : std_logic_vector(127 downto 0);

  begin
    InverseShiftRowPort : InverseShiftRow port map
    (
      data_in => data_in,
      data_out => data_out
    );

    test : process

    impure function test(testIn : std_logic_vector(127 downto 0)) return boolean is
      begin
        data_in <= testIn;
        return true;
    end test;

    impure function assertFunc(test : std_logic_vector(127 downto 0)) return boolean is
      begin
        assert data_out = test report "Inverse shift row is wrong" severity error;
        return true;
    end assertFunc;

    variable delay : time := 2 ns;
    variable foo : boolean;

    begin
      foo := test(x"bdb52189f261b63d0b107c9e8b6e776e");
      wait for delay;
      foo := assertFunc(x"bd6e7c3df2b5779e0b61216e8b10b689");

      foo := test(x"fde596f1054737d235febad7f1e3d04e");
      wait for delay;
      foo := assertFunc(x"fde3bad205e5d0d73547964ef1fe37f1");

      foo := test(x"3bd92268fc74fb735767cbe0c0590e2d");
      wait for delay;
      foo := assertFunc(x"3b59cb73fcd90ee05774222dc067fb68");

      foo := test(x"2d6d7ef03f33e334093602dd5bfb12c7");
      wait for delay;
      foo := assertFunc(x"2dfb02343f6d12dd09337ec75b36e3f0");

      foo := test(x"36339d50f9b539269f2c092dc4406d23");
      wait for delay;
      foo := assertFunc(x"36400926f9336d2d9fb59d23c42c3950");

      foo := test(x"e8dab6901477d4653ff7f5e2e747dd4f");
      wait for delay;
      foo := assertFunc(x"e847f56514dadde23f77b64fe7f7d490");

      foo := test(x"b458124c68b68a014b99f82e5f15554c");
      wait for delay;
      foo := assertFunc(x"b415f8016858552e4bb6124c5f998a4c");

      foo := test(x"3e1c22c0b6fcbf768da85067f6170495");
      wait for delay;
      foo := assertFunc(x"3e175076b61c04678dfc2295f6a8bfc0");

      foo := test(x"54d990a16ba09ab596bbf40ea111702f");
      wait for delay;
      foo := assertFunc(x"5411f4b56bd9700e96a0902fa1bb9aa1");

      foo := test(x"7ad5fda789ef4e272bca100b3d9ff59f");
      wait for delay;
      foo := assertFunc(x"7a9f102789d5f50b2beffd9f3dca4ea7");

      foo := test(x"54d990a16ba09ab596bbf40ea111702f");
      wait for delay;
      foo := assertFunc(x"5411f4b56bd9700e96a0902fa1bb9aa1");

      foo := test(x"3e1c22c0b6fcbf768da85067f6170495");
      wait for delay;
      foo := assertFunc(x"3e175076b61c04678dfc2295f6a8bfc0");

      foo := test(x"b458124c68b68a014b99f82e5f15554c");
      wait for delay;
      foo := assertFunc(x"b415f8016858552e4bb6124c5f998a4c");

      foo := test(x"e8dab6901477d4653ff7f5e2e747dd4f");
      wait for delay;
      foo := assertFunc(x"e847f56514dadde23f77b64fe7f7d490");

      foo := test(x"36339d50f9b539269f2c092dc4406d23");
      wait for delay;
      foo := assertFunc(x"36400926f9336d2d9fb59d23c42c3950");

      foo := test(x"2d6d7ef03f33e334093602dd5bfb12c7");
      wait for delay;
      foo := assertFunc(x"2dfb02343f6d12dd09337ec75b36e3f0");

      foo := test(x"3bd92268fc74fb735767cbe0c0590e2d");
      wait for delay;
      foo := assertFunc(x"3b59cb73fcd90ee05774222dc067fb68");

      foo := test(x"a7be1a6997ad739bd8c9ca451f618b61");
      wait for delay;
      foo := assertFunc(x"a761ca9b97be8b45d8ad1a611fc97369");

      foo := test(x"6353e08c0960e104cd70b751bacad0e7");
      wait for delay;
      foo := assertFunc(x"63cab7040953d051cd60e0e7ba70e18c");

      foo := test(x"bdb52189f261b63d0b107c9e8b6e776e");
      wait for delay;
      foo := assertFunc(x"bd6e7c3df2b5779e0b61216e8b10b689");

      foo := test(x"fde596f1054737d235febad7f1e3d04e");
      wait for delay;
      foo := assertFunc(x"fde3bad205e5d0d73547964ef1fe37f1");

      foo := test(x"d1c4941f7955f40fb46f6c0ad68730ad");
      wait for delay;
      foo := assertFunc(x"d1876c0f79c4300ab45594add66ff41f");

      foo := test(x"c65e395df779cf09ccf9e1c3842fed5d");
      wait for delay;
      foo := assertFunc(x"c62fe109f75eedc3cc79395d84f9cf5d");

      foo := test(x"2466756c69d25b236e4240fa8872b332");
      wait for delay;
      foo := assertFunc(x"247240236966b3fa6ed2753288425b6c");

      foo := test(x"fab38a1725664d2840246ac957633931");
      wait for delay;
      foo := assertFunc(x"fa636a2825b339c940668a3157244d17");

      foo := test(x"49e594f755ca638fda0a59a01f15d7fa");
      wait for delay;
      foo := assertFunc(x"4915598f55e5d7a0daca94fa1f0a63f7");

      foo := test(x"793e76979c3403e9aab7b2d10fa96ccc");
      wait for delay;
      foo := assertFunc(x"79a9b2e99c3e6cd1aa3476cc0fb70397");
      foo := test(x"c494bffae62322ab4bb5dc4e6fce69dd");
      wait for delay;
      foo := assertFunc(x"c4cedcabe694694e4b23bfdd6fb522fa");
      foo := test(x"d37e3705907a1a208d1c371e8c6fbfb5");
      wait for delay;
      foo := assertFunc(x"d36f3720907ebf1e8d7a37b58c1c1a05");
      foo := test(x"406c501076d70066e17057ca09fc7b7f");
      wait for delay;
      foo := assertFunc(x"40fc5766766c7bcae1d7507f09700010");
      foo := test(x"fe7c7e71fe7f807047b95193f67b8e4b");
      wait for delay;
      foo := assertFunc(x"fe7b5170fe7c8e93477f7e4bf6b98071");
      foo := test(x"85e5c8042f8614549ebca17b277272df");
      wait for delay;
      foo := assertFunc(x"8572a1542fe5727b9e86c8df27bc1404");
      foo := test(x"cd54c7283864c0c55d4c727e90c9a465");
      wait for delay;
      foo := assertFunc(x"cdc972c53854a47e5d64c765904cc028");
      foo := test(x"93faa123c2903f4743e4dd83431692de");
      wait for delay;
      foo := assertFunc(x"9316dd47c2fa92834390a1de43e43f23");
      foo := test(x"68cc08ed0abbd2bc642ef555244ae878");
      wait for delay;
      foo := assertFunc(x"684af5bc0acce85564bb0878242ed2ed");
      foo := test(x"1fb5430ef0accf64aa370cde3d77792c");
      wait for delay;
      foo := assertFunc(x"1f770c64f0b579deaaac432c3d37cf0e");

      foo := test(x"afd10f851c28d5eb62203e51fbb7b827");
      wait for delay;
      foo := assertFunc(x"afb73eeb1cd1b85162280f27fb20d585");
      foo := test(x"88e7f414f532940eccd293b606ece4c9");
      wait for delay;
      foo := assertFunc(x"88ec930ef5e7e4b6cc32f4c906d29414");
      foo := test(x"a98ab23696bd4354b4c4b2e9f006f4d2");
      wait for delay;
      foo := assertFunc(x"a906b254968af4e9b4bdb2d2f0c44336");
      foo := test(x"72b86c7c0f0d52d3e0d0da104055036b");
      wait for delay;
      foo := assertFunc(x"7255dad30fb80310e00d6c6b40d0527c");
      foo := test(x"0c018a2c0c6b3ad016db7022d603e6cc");
      wait for delay;
      foo := assertFunc(x"0c0370d00c01e622166b8accd6db3a2c");
      foo := test(x"672ab1304edc9bfddf78f1033d1e1eef");
      wait for delay;
      foo := assertFunc(x"671ef1fd4e2a1e03dfdcb1ef3d789b30");
      foo := test(x"80fd31ee768c1f078d5d1e8a96121dbc");
      wait for delay;
      foo := assertFunc(x"80121e0776fd1d8a8d8c31bc965d1fee");
      foo := test(x"2214f132a896251664aec94164ff749c");
      wait for delay;
      foo := assertFunc(x"22ffc916a81474416496f19c64ae2532");
      foo := test(x"f727bf53a3fe7f788cc377eda65cc8c1");
      wait for delay;
      foo := assertFunc(x"f75c7778a327c8ed8cfebfc1a6c37f53");
      foo := test(x"cbd264d717aa5f8c62b2819c8b02af42");
      wait for delay;
      foo := assertFunc(x"cb02818c17d2af9c62aa64428bb25fd7");
      foo := test(x"4fe0c9e443f80d06affa76854163aad0");
      wait for delay;
      foo := assertFunc(x"4f63760643e0aa85aff8c9d041fa0de4");
      foo := test(x"0050a0f04090e03080d02070c01060b0");
      wait for delay;
      foo := assertFunc(x"00102030405060708090a0b0c0d0e0f0");

      foo := test(x"629deca599456db9c9f5ceaa237b5af4");
  wait for delay;
  foo := assertFunc(x"627bceb9999d5aaac945ecf423f56da5");
  foo := test(x"5153862143fb259514920403016695e4");
  wait for delay;
  foo := assertFunc(x"516604954353950314fb86e401922521");
  foo := test(x"5fc69f53ba4076bf50676aaa669c34a7");
  wait for delay;
  foo := assertFunc(x"5f9c6abfbac634aa50409fa766677653");
  foo := test(x"c13baaeccae9b5f6705207a03b493a31");
  wait for delay;
  foo := assertFunc(x"c14907f6ca3b3aa070e9aa313b52b5ec");
  foo := test(x"4a7ee5c9c53de85164f348472a827e0c");
  wait for delay;
  foo := assertFunc(x"4a824851c57e7e47643de50c2af3e8c9");
  foo := test(x"5ad2a3c55fe1b93905f3587d68a88d88");
  wait for delay;
  foo := assertFunc(x"5aa858395fd28d7d05e1a38868f3b9c5");
  foo := test(x"d6a0ab7d6cca5e695a6ca40fb953bc5d");
  wait for delay;
  foo := assertFunc(x"d653a4696ca0bc0f5acaab5db96c5e7d");
  foo := test(x"7f4e814ccb0cd543c175413e8307245d");
  wait for delay;
  foo := assertFunc(x"7f074143cb4e243ec10c815d8375d54c");
  foo := test(x"c345bdfa1bc799e1a2dcaab0a857b728");
  wait for delay;
  foo := assertFunc(x"c357aae11b45b7b0a2c7bd28a8dc99fa");
  foo := test(x"1c17c554a4211571f970f24f0405e0c1");
  wait for delay;
  foo := assertFunc(x"1c05f271a417e04ff921c5c104701554");
  foo := test(x"979f2863cb3a0fc1a9e166a88e5c3fdf");
  wait for delay;
  foo := assertFunc(x"975c66c1cb9f3fa8a93a28df8ee10f63");
  foo := test(x"181c8a098aed61c2782ffba0c45900ad");
  wait for delay;
  foo := assertFunc(x"1859fbc28a1c00a078ed8aadc42f6109");
  foo := test(x"4fe0210543a7e706efa476850163aa32");
  wait for delay;
  foo := assertFunc(x"4f63760643e0aa85efa7213201a4e705");
  foo := test(x"0050a0f04090e03080d02070c01060b0");
  wait for delay;
  foo := assertFunc(x"00102030405060708090a0b0c0d0e0f0");

      report "Tests complete";
    end process test;
end rtl;