LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity InverseSubstituteBox is
  port
  (
    data_in : in std_logic_vector(127 downto 0);
    data_out : out std_logic_Vector(127 downto 0)
  );
end InverseSubstituteBox;

architecture rtl of InverseSubstituteBox is
  function SBox(A : std_logic_vector(7 downto 0)) return std_logic_vector is
      variable MSB_Nibble : std_logic_vector (3 DOWNTO 0);
      variable LSB_Nibble : std_logic_vector (3 DOWNTO 0);
      variable B : std_logic_vector(7 downto 0);
      begin
        MSB_Nibble := A(7 downto 4);
        LSB_Nibble := A(3 downto 0);
        
        case MSB_Nibble is --determine row
    --   
          when X"0" => 
            case LSB_Nibble is --determine column
              when X"0" => B := X"52";
              when X"1" => B := X"09";
              when X"2" => B := X"6a";
              when X"3" => B := X"d5";
              when X"4" => B := X"30";
              when X"5" => B := X"36";
              when X"6" => B := X"a5";
              when X"7" => B := X"38";
              when X"8" => B := X"bf";
              when X"9" => B := X"40";
              when X"A" => B := X"a3";
              when X"B" => B := X"9e";
              when X"C" => B := X"81";
              when X"D" => B := X"f3";
              when X"E" => B := X"d7";
              when X"F" => B := X"fb";
              when others => B := "--------";
            end case;
        -- 
          when X"1" =>
            case LSB_Nibble is --determinte column
              when X"0" => B := X"7c";
              when X"1" => B := X"e3";
              when X"2" => B := X"39";
              when X"3" => B := X"82";
              when X"4" => B := X"9b";
              when X"5" => B := X"2f";
              when X"6" => B := X"ff";
              when X"7" => B := X"87";
              when X"8" => B := X"34";
              when X"9" => B := X"8e";
              when X"A" => B := X"43";
              when X"B" => B := X"44";
              when X"C" => B := X"c4";
              when X"D" => B := X"de";
              when X"E" => B := X"e9";
              when X"F" => B := X"cb";
              when others => B := "--------";
            end case;		
    --   
          when X"2" =>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"54";
            when X"1" => B := X"7b";
            when X"2" => B := X"94";
            when X"3" => B := X"32";
            when X"4" => B := X"a6";
            when X"5" => B := X"c2";
            when X"6" => B := X"23";
            when X"7" => B := X"3d";
            when X"8" => B := X"ee";
            when X"9" => B := X"4c";
            when X"A" => B := X"95";
            when X"B" => B := X"0b";
            when X"C" => B := X"42";
            when X"D" => B := X"fa";
            when X"E" => B := X"c3";
            when X"F" => B := X"4e";
            when others => B := "--------";
            end case;
    --   
          when X"3"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"08";
            when X"1" => B := X"2e";
            when X"2" => B := X"a1";
            when X"3" => B := X"66";
            when X"4" => B := X"28";
            when X"5" => B := X"d9";
            when X"6" => B := X"24";
            when X"7" => B := X"b2";
            when X"8" => B := X"76";
            when X"9" => B := X"5b";
            when X"A" => B := X"a2";
            when X"B" => B := X"49";
            when X"C" => B := X"6d";
            when X"D" => B := X"8b";
            when X"E" => B := X"d1";
            when X"F" => B := X"25";
            when others => B := "--------";
            end case;
        -- 
          when X"4"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"72";
            when X"1" => B := X"f8";
            when X"2" => B := X"f6";
            when X"3" => B := X"64";
            when X"4" => B := X"86";
            when X"5" => B := X"68";
            when X"6" => B := X"98";
            when X"7" => B := X"16";
            when X"8" => B := X"d4";
            when X"9" => B := X"a4";
            when X"A" => B := X"5c";
            when X"B" => B := X"cc";
            when X"C" => B := X"5d";
            when X"D" => B := X"65";
            when X"E" => B := X"b6";
            when X"F" => B := X"92";
            when others => B := "--------";
            end case;
        -- 
          when X"5"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"6c";
            when X"1" => B := X"70";
            when X"2" => B := X"48";
            when X"3" => B := X"50";
            when X"4" => B := X"fd";
            when X"5" => B := X"ed";
            when X"6" => B := X"b9";
            when X"7" => B := X"da";
            when X"8" => B := X"5e";
            when X"9" => B := X"15";
            when X"A" => B := X"46";
            when X"B" => B := X"57";
            when X"C" => B := X"a7";
            when X"D" => B := X"8d";
            when X"E" => B := X"9d";
            when X"F" => B := X"84";
            when others => B := "--------";
            end case;
        -- 
          when X"6"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"90";
            when X"1" => B := X"d8";
            when X"2" => B := X"ab";
            when X"3" => B := X"00";
            when X"4" => B := X"8c";
            when X"5" => B := X"bc";
            when X"6" => B := X"d3";
            when X"7" => B := X"0a";
            when X"8" => B := X"f7";
            when X"9" => B := X"e4";
            when X"A" => B := X"58";
            when X"B" => B := X"05";
            when X"C" => B := X"b8";
            when X"D" => B := X"b3";
            when X"E" => B := X"45";
            when X"F" => B := X"06";
            when others => B := "--------";
            end case;
        -- 
          when X"7"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"d0";
            when X"1" => B := X"2c";
            when X"2" => B := X"1e";
            when X"3" => B := X"8f";
            when X"4" => B := X"ca";
            when X"5" => B := X"3f";
            when X"6" => B := X"0f";
            when X"7" => B := X"02";
            when X"8" => B := X"c1";
            when X"9" => B := X"af";
            when X"A" => B := X"bd";
            when X"B" => B := X"03";
            when X"C" => B := X"01";
            when X"D" => B := X"13";
            when X"E" => B := X"8a";
            when X"F" => B := X"6b";
            when others => B := "--------";
            end case;
        -- 
          when X"8"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"3a";
            when X"1" => B := X"91";
            when X"2" => B := X"11";
            when X"3" => B := X"41";
            when X"4" => B := X"4f";
            when X"5" => B := X"67";
            when X"6" => B := X"dc";
            when X"7" => B := X"ea";
            when X"8" => B := X"97";
            when X"9" => B := X"f2";
            when X"A" => B := X"cf";
            when X"B" => B := X"ce";
            when X"C" => B := X"f0";
            when X"D" => B := X"b4";
            when X"E" => B := X"e6";
            when X"F" => B := X"73";
            when others => B := "--------";
            end case;
        -- 
          when X"9"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"96";
            when X"1" => B := X"ac";
            when X"2" => B := X"74";
            when X"3" => B := X"22";
            when X"4" => B := X"e7";
            when X"5" => B := X"ad";
            when X"6" => B := X"35";
            when X"7" => B := X"85";
            when X"8" => B := X"e2";
            when X"9" => B := X"f9";
            when X"A" => B := X"37";
            when X"B" => B := X"e8";
            when X"C" => B := X"1c";
            when X"D" => B := X"75";
            when X"E" => B := X"df";
            when X"F" => B := X"6e";
            when others => B := "--------";
            end case;
        -- 
          when X"A"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"47";
            when X"1" => B := X"f1";
            when X"2" => B := X"1a";
            when X"3" => B := X"71";
            when X"4" => B := X"1d";
            when X"5" => B := X"29";
            when X"6" => B := X"c5";
            when X"7" => B := X"89";
            when X"8" => B := X"6f";
            when X"9" => B := X"b7";
            when X"A" => B := X"62";
            when X"B" => B := X"0e";
            when X"C" => B := X"aa";
            when X"D" => B := X"18";
            when X"E" => B := X"be";
            when X"F" => B := X"1b";
            when others => B := "--------";
            end case;
        -- 
          when X"B"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"fc";
            when X"1" => B := X"56";
            when X"2" => B := X"3e";
            when X"3" => B := X"4b";
            when X"4" => B := X"c6";
            when X"5" => B := X"d2";
            when X"6" => B := X"79";
            when X"7" => B := X"20";
            when X"8" => B := X"9a";
            when X"9" => B := X"db";
            when X"A" => B := X"c0";
            when X"B" => B := X"fe";
            when X"C" => B := X"78";
            when X"D" => B := X"cd";
            when X"E" => B := X"5a";
            when X"F" => B := X"f4";
            when others => B := "--------";
            end case;
        -- 
          when X"C"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"1f";
            when X"1" => B := X"dd";
            when X"2" => B := X"a8";
            when X"3" => B := X"33";
            when X"4" => B := X"88";
            when X"5" => B := X"07";
            when X"6" => B := X"c7";
            when X"7" => B := X"31";
            when X"8" => B := X"b1";
            when X"9" => B := X"12";
            when X"A" => B := X"10";
            when X"B" => B := X"59";
            when X"C" => B := X"27";
            when X"D" => B := X"80";
            when X"E" => B := X"ec";
            when X"F" => B := X"5f";
            when others => B := "--------";
            end case;
        -- 
          when X"D"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"60";
            when X"1" => B := X"51";
            when X"2" => B := X"7f";
            when X"3" => B := X"a9";
            when X"4" => B := X"19";
            when X"5" => B := X"b5";
            when X"6" => B := X"4a";
            when X"7" => B := X"0d";
            when X"8" => B := X"2d";
            when X"9" => B := X"e5";
            when X"A" => B := X"7a";
            when X"B" => B := X"9f";
            when X"C" => B := X"93";
            when X"D" => B := X"c9";
            when X"E" => B := X"9c";
            when X"F" => B := X"ef";
            when others => B := "--------";
            end case;
        -- 
          when X"E"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"a0";
            when X"1" => B := X"e0";
            when X"2" => B := X"3b";
            when X"3" => B := X"4d";
            when X"4" => B := X"ae";
            when X"5" => B := X"2a";
            when X"6" => B := X"f5";
            when X"7" => B := X"b0";
            when X"8" => B := X"c8";
            when X"9" => B := X"eb";
            when X"A" => B := X"bb";
            when X"B" => B := X"3c";
            when X"C" => B := X"83";
            when X"D" => B := X"53";
            when X"E" => B := X"99";
            when X"F" => B := X"61";
            when others => B := "--------";
            end case;
        -- 
          when X"F"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"17";
            when X"1" => B := X"2b";
            when X"2" => B := X"04";
            when X"3" => B := X"7e";
            when X"4" => B := X"ba";
            when X"5" => B := X"77";
            when X"6" => B := X"d6";
            when X"7" => B := X"26";
            when X"8" => B := X"e1";
            when X"9" => B := X"69";
            when X"A" => B := X"14";
            when X"B" => B := X"63";
            when X"C" => B := X"55";
            when X"D" => B := X"21";
            when X"E" => B := X"0c";
            when X"F" => B := X"7d";
            when others => B := "--------";
          end case;
        --   
          when others => B := "--------";
        end case;
        return B;
  end function SBox;
  begin
    process(data_in)
      begin
        data_out(7 downto 0)     <= SBox(data_in(7   downto 0) )   ;
        data_out(15 downto 8)    <= SBox(data_in(15  downto 8) )  ;
        data_out(23 downto 16)   <= SBox(data_in(23  downto 16))  ;
        data_out(31 downto 24)   <= SBox(data_in(31  downto 24))  ;
        data_out(39 downto 32)   <= SBox(data_in(39  downto 32))  ;
        data_out(47 downto 40)   <= SBox(data_in(47  downto 40))  ;
        data_out(55 downto 48)   <= SBox(data_in(55  downto 48))  ;
        data_out(63 downto 56)   <= SBox(data_in(63  downto 56))  ;
        data_out(71 downto 64)   <= SBox(data_in(71  downto 64))  ;
        data_out(79 downto 72)   <= SBox(data_in(79  downto 72))  ;
        data_out(87 downto 80)   <= SBox(data_in(87  downto 80))  ;
        data_out(95 downto 88)   <= SBox(data_in(95  downto 88))  ;
        data_out(103 downto 96)  <= SBox(data_in(103 downto 96)) ;
        data_out(111 downto 104) <= SBox(data_in(111 downto 104));
        data_out(119 downto 112) <= SBox(data_in(119 downto 112));
        data_out(127 downto 120) <= SBox(data_in(127 downto 120));
    end process;
end rtl;