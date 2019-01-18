LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MixColumnsTestBench is
end MixColumnsTestBench;

ARCHITECTURE TestArchitecture of MixColumnsTestBench is

  component MixColumns
    port
    (
      RawData     : in    std_logic_vector(127 downto 0);
      Encrypted   : out   std_logic_vector(127 downto 0)
    );
  end component;

  signal RawData   :  std_logic_vector(127 downto 0);
  signal Encrypted :  std_logic_vector(127 downto 0);

  begin
    MixColumnPort: MixColumns port map
    (
        RawData => RawData,
        Encrypted => Encrypted
    );

    test : process
      begin
        RawData <= x"d4bf5d30e0b452aeb84111f11e2798e5";
        wait for 10 ns;
        assert (Encrypted = x"046681e5e0cb199a48f8d37a2806264c") report "Wrong encryption" severity failure;
        RawData <= x"49db873b453953897f02d2f177de961a";
        wait for 10 ns;
        assert (Encrypted = x"584dcaf11b4b5aacdbe7caa81b6bb0e5") report "Wrong encryption" severity failure;
        RawData <= x"acc1d6b8efb55a7b1323cfdf457311b5";
        wait for 10 ns;
        assert (Encrypted = x"75ec0993200b633353c0cf7cbb25d0dc") report "Wrong encryption" severity failure;
        RawData <= x"52a4c89485116a28e3cf2fd7f6505e07";
        wait for 10 ns;
        assert (Encrypted = x"0fd6daa9603138bf6fc0106b5eb31301") report "Wrong encryption" severity failure;
        RawData <= x"e1fb967ce8c8ae9b356cd2ba974ffb53";
        wait for 10 ns;
        assert (Encrypted = x"25d1a9adbd11d168b63a338e4c4cc0b0") report "Wrong encryption" severity failure;
        RawData <= x"a14f3dfe78e803fc10d5a8df4c632923";
        wait for 10 ns;
        assert (Encrypted = x"4b868d6d2c4a8980339df4e837d218d8") report "Wrong encryption" severity failure;
        RawData <= x"f783403f27433df09bb531ff54aba9d3";
        wait for 10 ns;
        assert (Encrypted = x"1415b5bf461615ec274656d7342ad843") report "Wrong encryption" severity failure;
        RawData <= x"be3bd4fed4e1f2c80a642cc0da83864d";
        wait for 10 ns;
        assert (Encrypted = x"00512fd1b1c889ff54766dcdfa1b99ea") report "Wrong encryption" severity failure;
        RawData <= x"6353e08c0960e104cd70b751bacad0e7";
        wait for 10 ns;
        assert (Encrypted = x"5f72641557f5bc92f7be3b291db9f91a") report "Wrong encryption" severity failure;
        RawData <= x"a7be1a6997ad739bd8c9ca451f618b61";
        wait for 10 ns;
        assert (Encrypted = x"ff87968431d86a51645151fa773ad009") report "Wrong encryption" severity failure;
        RawData <= x"3bd92268fc74fb735767cbe0c0590e2d";
        wait for 10 ns;
        assert (Encrypted = x"4c9c1e66f771f0762c3f868e534df256") report "Wrong encryption" severity failure;
        RawData <= x"2d6d7ef03f33e334093602dd5bfb12c7";
        wait for 10 ns;
        assert (Encrypted = x"6385b79ffc538df997be478e7547d691") report "Wrong encryption" severity failure;
        RawData <= x"36339d50f9b539269f2c092dc4406d23";
        wait for 10 ns;
        assert (Encrypted = x"f4bcd45432e554d075f1d6c51dd03b3c") report "Wrong encryption" severity failure;
        RawData <= x"e8dab6901477d4653ff7f5e2e747dd4f";
        wait for 10 ns;
        assert (Encrypted = x"9816ee7400f87f556b2c049c8e5ad036") report "Wrong encryption" severity failure;
        RawData <= x"b458124c68b68a014b99f82e5f15554c";
        wait for 10 ns;
        assert (Encrypted = x"c57e1c159a9bd286f05f4be098c63439") report "Wrong encryption" severity failure;
        RawData <= x"3e1c22c0b6fcbf768da85067f6170495";
        wait for 10 ns;
        assert (Encrypted = x"baa03de7a1f9b56ed5512cba5f414d23") report "Wrong encryption" severity failure;
        RawData <= x"54d990a16ba09ab596bbf40ea111702f";
        wait for 10 ns;
        assert (Encrypted = x"e9f74eec023020f61bf2ccf2353c21c7") report "Wrong encryption" severity failure;
        report "All tests OK";
    end process;
end TestArchitecture;