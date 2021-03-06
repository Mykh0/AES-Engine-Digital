-- Created on Mon Jan 07 01:01:25 2019

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ExpandKeys IS
	PORT
	(
        Key : IN STD_LOGIC_VECTOR(255 downto 0);
        Key_Length : IN STD_LOGIC_VECTOR(1 downto 0);
		clk : IN STD_LOGIC;
		nrst : IN STD_LOGIC;
		start : IN STD_LOGIC;
		Decrypt : IN STD_LOGIC;
		Key_I : OUT STD_LOGIC_VECTOR(127 downto 0)
	);
END ExpandKeys;

ARCHITECTURE ExpandKeys_architecture OF ExpandKeys IS

  type KeyRegisters is array(0 to 14) of std_logic_vector(127 downto 0);
  type aesMode is (aes128, aes192, aes256);
  
  function setrcon(rcon: std_logic_vector(31 downto 0)) return std_logic_vector is
    variable tmp : std_logic_vector(31 downto 0) := x"00000000";
    begin
      tmp := rcon(30 downto 0) & '0';
      if(tmp = x"00000000") then
  	    tmp := tmp xor x"1B000000";
      end if;
        return tmp;
  end function setrcon;
  
  function rotWord(source : std_logic_vector(31 downto 0)) return std_logic_vector is
    begin
      return source(23 downto 0) & source(31 downto 24);
  end function rotWord;
  
  function SBox(A : std_logic_vector(7 downto 0)) return std_logic_vector is
    variable MSB_Nibble : std_logic_vector (3 DOWNTO 0);
	 variable LSB_Nibble : std_logic_vector (3 DOWNTO 0);
	 variable B : std_logic_vector(7 downto 0);
	 
	 begin
	 MSB_Nibble := A(7 downto 4);
	 LSB_Nibble := A(3 downto 0);
	 
	 case MSB_Nibble is --determine row
	 
	 when X"0" => 
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"63";
	 when X"1" => B := X"7C";
	 when X"2" => B := X"77";
	 when X"3" => B := X"7B";
	 when X"4" => B := X"F2";
	 when X"5" => B := X"6B";
	 when X"6" => B := X"6F";
	 when X"7" => B := X"C5";
	 when X"8" => B := X"30";
	 when X"9" => B := X"01";
	 when X"A" => B := X"67";
	 when X"B" => B := X"2B";
	 when X"C" => B := X"FE";
	 when X"D" => B := X"D7";
	 when X"E" => B := X"AB";
	 when X"F" => B := X"76";
	 when others => B := "--------";
	 end case;
	 
	 when X"1" =>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"CA";
	 when X"1" => B := X"82";
	 when X"2" => B := X"C9";
	 when X"3" => B := X"7D";
	 when X"4" => B := X"FA";
	 when X"5" => B := X"59";
	 when X"6" => B := X"47";
	 when X"7" => B := X"F0";
	 when X"8" => B := X"AD";
	 when X"9" => B := X"D4";
	 when X"A" => B := X"A2";
	 when X"B" => B := X"AF";
	 when X"C" => B := X"9C";
	 when X"D" => B := X"A4";
	 when X"E" => B := X"72";
	 when X"F" => B := X"C0";
	 when others => B := "--------";
	 end case;		
 
	 when X"2" =>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"B7";
	 when X"1" => B := X"FD";
	 when X"2" => B := X"93";
	 when X"3" => B := X"26";
	 when X"4" => B := X"36";
	 when X"5" => B := X"3F";
	 when X"6" => B := X"F7";
	 when X"7" => B := X"CC";
	 when X"8" => B := X"34";
	 when X"9" => B := X"A5";
	 when X"A" => B := X"E5";
	 when X"B" => B := X"F1";
	 when X"C" => B := X"71";
	 when X"D" => B := X"D8";
	 when X"E" => B := X"31";
	 when X"F" => B := X"15";
	 when others => B := "--------";
	 end case;
 
	 when X"3"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"04";
	 when X"1" => B := X"C7";
	 when X"2" => B := X"23";
	 when X"3" => B := X"C3";
	 when X"4" => B := X"18";
	 when X"5" => B := X"96";
	 when X"6" => B := X"05";
	 when X"7" => B := X"9A";
	 when X"8" => B := X"07";
	 when X"9" => B := X"12";
	 when X"A" => B := X"80";
	 when X"B" => B := X"E2";
	 when X"C" => B := X"EB";
	 when X"D" => B := X"27";
	 when X"E" => B := X"B2";
	 when X"F" => B := X"75";
	 when others => B := "--------";
	 end case;
	 
	 when X"4"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"09";
	 when X"1" => B := X"83";
	 when X"2" => B := X"2C";
	 when X"3" => B := X"1A";
	 when X"4" => B := X"1B";
	 when X"5" => B := X"6E";
	 when X"6" => B := X"5A";
	 when X"7" => B := X"A0";
	 when X"8" => B := X"52";
	 when X"9" => B := X"3B";
	 when X"A" => B := X"D6";
	 when X"B" => B := X"B3";
	 when X"C" => B := X"29";
	 when X"D" => B := X"E3";
	 when X"E" => B := X"2F";
	 when X"F" => B := X"84";
	 when others => B := "--------";
	 end case;
	 
	 when X"5"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"53";
	 when X"1" => B := X"D1";
	 when X"2" => B := X"00";
	 when X"3" => B := X"ED";
	 when X"4" => B := X"20";
	 when X"5" => B := X"FC";
	 when X"6" => B := X"B1";
	 when X"7" => B := X"5B";
	 when X"8" => B := X"6A";
	 when X"9" => B := X"CB";
	 when X"A" => B := X"BE";
	 when X"B" => B := X"39";
	 when X"C" => B := X"4A";
	 when X"D" => B := X"4C";
	 when X"E" => B := X"58";
	 when X"F" => B := X"CF";
	 when others => B := "--------";
	 end case;
	 
	 when X"6"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"D0";
	 when X"1" => B := X"EF";
	 when X"2" => B := X"AA";
	 when X"3" => B := X"FB";
	 when X"4" => B := X"43";
	 when X"5" => B := X"4D";
	 when X"6" => B := X"33";
	 when X"7" => B := X"85";
	 when X"8" => B := X"45";
	 when X"9" => B := X"F9";
	 when X"A" => B := X"02";
	 when X"B" => B := X"7F";
	 when X"C" => B := X"50";
	 when X"D" => B := X"3C";
	 when X"E" => B := X"9F";
	 when X"F" => B := X"A8";
	 when others => B := "--------";
	 end case;
	 
	 when X"7"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"51";
	 when X"1" => B := X"A3";
	 when X"2" => B := X"40";
	 when X"3" => B := X"8F";
	 when X"4" => B := X"92";
	 when X"5" => B := X"9D";
	 when X"6" => B := X"38";
	 when X"7" => B := X"F5";
	 when X"8" => B := X"BC";
	 when X"9" => B := X"B6";
	 when X"A" => B := X"DA";
	 when X"B" => B := X"21";
	 when X"C" => B := X"10";
	 when X"D" => B := X"FF";
	 when X"E" => B := X"F3";
	 when X"F" => B := X"D2";
	 when others => B := "--------";
	 end case;
	 
	 when X"8"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"CD";
	 when X"1" => B := X"0C";
	 when X"2" => B := X"13";
	 when X"3" => B := X"EC";
	 when X"4" => B := X"5F";
	 when X"5" => B := X"97";
	 when X"6" => B := X"44";
	 when X"7" => B := X"17";
	 when X"8" => B := X"C4";
	 when X"9" => B := X"A7";
	 when X"A" => B := X"7E";
	 when X"B" => B := X"3D";
	 when X"C" => B := X"64";
	 when X"D" => B := X"5D";
	 when X"E" => B := X"19";
	 when X"F" => B := X"73";
	 when others => B := "--------";
	 end case;
	 
	 when X"9"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"60";
	 when X"1" => B := X"81";
	 when X"2" => B := X"4F";
	 when X"3" => B := X"DC";
	 when X"4" => B := X"22";
	 when X"5" => B := X"2A";
	 when X"6" => B := X"90";
	 when X"7" => B := X"88";
	 when X"8" => B := X"46";
	 when X"9" => B := X"EE";
	 when X"A" => B := X"B8";
	 when X"B" => B := X"14";
	 when X"C" => B := X"DE";
	 when X"D" => B := X"5E";
	 when X"E" => B := X"0B";
	 when X"F" => B := X"DB";
	 when others => B := "--------";
	 end case;
	 
	 when X"A"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"E0";
	 when X"1" => B := X"32";
	 when X"2" => B := X"3A";
	 when X"3" => B := X"0A";
	 when X"4" => B := X"49";
	 when X"5" => B := X"06";
	 when X"6" => B := X"24";
	 when X"7" => B := X"5C";
	 when X"8" => B := X"C2";
	 when X"9" => B := X"D3";
	 when X"A" => B := X"AC";
	 when X"B" => B := X"62";
	 when X"C" => B := X"91";
	 when X"D" => B := X"95";
	 when X"E" => B := X"E4";
	 when X"F" => B := X"79";
	 when others => B := "--------";
	 end case;
	 
	 when X"B"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"E7";
	 when X"1" => B := X"C8";
	 when X"2" => B := X"37";
	 when X"3" => B := X"6D";
	 when X"4" => B := X"8D";
	 when X"5" => B := X"D5";
	 when X"6" => B := X"4E";
	 when X"7" => B := X"A9";
	 when X"8" => B := X"6C";
	 when X"9" => B := X"56";
	 when X"A" => B := X"F4";
	 when X"B" => B := X"EA";
	 when X"C" => B := X"65";
	 when X"D" => B := X"7A";
	 when X"E" => B := X"AE";
	 when X"F" => B := X"08";
	 when others => B := "--------";
	 end case;
	 
	 when X"C"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"BA";
	 when X"1" => B := X"78";
	 when X"2" => B := X"25";
	 when X"3" => B := X"2E";
	 when X"4" => B := X"1C";
	 when X"5" => B := X"A6";
	 when X"6" => B := X"B4";
	 when X"7" => B := X"C6";
	 when X"8" => B := X"E8";
	 when X"9" => B := X"DD";
	 when X"A" => B := X"74";
	 when X"B" => B := X"1F";
	 when X"C" => B := X"4B";
	 when X"D" => B := X"BD";
	 when X"E" => B := X"8B";
	 when X"F" => B := X"8A";
	 when others => B := "--------";
	 end case;
	 
	 when X"D"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"70";
	 when X"1" => B := X"3E";
	 when X"2" => B := X"B5";
	 when X"3" => B := X"66";
	 when X"4" => B := X"48";
	 when X"5" => B := X"03";
	 when X"6" => B := X"F6";
	 when X"7" => B := X"0E";
	 when X"8" => B := X"61";
	 when X"9" => B := X"35";
	 when X"A" => B := X"57";
	 when X"B" => B := X"B9";
	 when X"C" => B := X"86";
	 when X"D" => B := X"C1";
	 when X"E" => B := X"1D";
	 when X"F" => B := X"9E";
	 when others => B := "--------";
	 end case;
	 
	 when X"E"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"E1";
	 when X"1" => B := X"F8";
	 when X"2" => B := X"98";
	 when X"3" => B := X"11";
	 when X"4" => B := X"69";
	 when X"5" => B := X"D9";
	 when X"6" => B := X"8E";
	 when X"7" => B := X"94";
	 when X"8" => B := X"9B";
	 when X"9" => B := X"1E";
	 when X"A" => B := X"87";
	 when X"B" => B := X"E9";
	 when X"C" => B := X"CE";
	 when X"D" => B := X"55";
	 when X"E" => B := X"28";
	 when X"F" => B := X"DF";
	 when others => B := "--------";
	 end case;
	 
	 when X"F"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"8C";
	 when X"1" => B := X"A1";
	 when X"2" => B := X"89";
	 when X"3" => B := X"0D";
	 when X"4" => B := X"BF";
	 when X"5" => B := X"E6";
	 when X"6" => B := X"42";
	 when X"7" => B := X"68";
	 when X"8" => B := X"41";
	 when X"9" => B := X"99";
	 when X"A" => B := X"2D";
	 when X"B" => B := X"0F";
	 when X"C" => B := X"B0";
	 when X"D" => B := X"54";
	 when X"E" => B := X"BB";
	 when X"F" => B := X"16";
	 when others => B := "--------";
	 end case;
	 
	 when others => B := "--------";
	 end case;
	 return B;
  end function;  
	 
  function SBox32(A: std_logic_vector(31 downto 0)) return std_logic_vector is
    variable word : std_logic_vector(31 downto 0) := x"00000000";
    begin
      word(31 downto 24) := SBox(A(31 downto 24));
  	  word(23 downto 16) := SBox(A(23 downto 16));
  	  word(15 downto 8)  := SBox(A(15 downto 8));
  	  word(7  downto 0)  := SBox(A(7  downto 0));
  	  return word;
  end function SBox32;

  function GenerateKeySchedules(Key : std_logic_vector(255 downto 0); Mode : aesMode) return KeyRegisters is
	  type aesState is array (7 downto 0) of std_logic_vector(31 downto 0);
	  type outputState is (init_128, a0to3_128, init_192, first4to1_192, a0to3_192, a4to1_192, a2to5_192, init_256, first4to7_256, a0to3_256, a4to7_256);
	  variable generatedKeys : KeyRegisters;
	  variable word: aesState;
	  variable states : outputState;
	  variable first : boolean := true;
	  variable rcon : std_logic_vector(31 downto 0) := x"00000000";
	  variable prevWord : std_logic_vector(31 downto 0) := x"00000000";
	  variable waitfor1clk : boolean := false;
	  begin
	    case Mode is
	  	  when aes128 =>
	  		states := init_128;
	  	  when aes192 =>
	  		states := init_192;
	  	  when aes256 =>
	  		states := init_256;
	    end case;
	    for i in 0 to 14 loop
	      case states is
      	  when init_256 =>
      	    word(0) := Key(255 downto 224);
      	    word(1) := Key(223 downto 192);
      	    word(2) := Key(191 downto 160);
      	    word(3) := Key(159 downto 128);
      	    word(4) := Key(127 downto 96);
      	    word(5) := Key(95 downto 64);
      	    word(6) := Key(63 downto 32);
      	    word(7) := Key(31 downto 0);
      	    rcon :=  x"01000000";
      	    prevWord := word(0);
      	    states := first4to7_256;
      	    generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      	  when first4to7_256 =>
      		generatedKeys(i) := word(4) & word(5) & word(6) & word(7);
      		states := a0to3_256;
      	  when a0to3_256 =>
      		prevWord := word(0);
      		word(0) := rotWord(word(7));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor word(0);
      		word(2) := word(2) xor word(1);
      		word(3) := word(3) xor word(2);
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      		states := a4to7_256;
      	  when a4to7_256 =>
      		prevWord := word(4);
      		word(4) := SBox32(word(3));
      		word(4) := word(4) xor prevWord;
      		word(5) := word(5) xor word(4);
      		word(6) := word(6) xor word(5);
      		word(7) := word(7) xor word(6);
      		generatedKeys(i) := word(4) & word(5) & word(6) & word(7);
      		states := a0to3_256;
      		rcon := setrcon(rcon);
      	  when init_128 =>
      		word(0) := Key(127 downto 96);
      		word(1) := Key(95 downto 64);
      		word(2) := Key(63 downto 32);
      		word(3) := Key(31 downto 0);
      		first := false;
      		rcon :=  x"01000000";
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      		states := a0to3_128;
      	  when a0to3_128 =>
      		prevWord := word(0);
      		word(0) := rotWord(word(3));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor word(0);
      		word(2) := word(2) xor word(1);
      		word(3) := word(3) xor word(2);
      		rcon := setrcon(rcon);
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      	  when init_192 =>
      		word(0) := Key(191 downto 160);
      		word(1) := Key(159 downto 128);
      		word(2) := Key(127 downto 96);
      		word(3) := Key(95 downto 64);
      		word(4) := Key(63 downto 32);
      		word(5) := Key(31 downto 0);
      		rcon :=  x"01000000";
      		states := first4to1_192;
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      	  when first4to1_192 =>
      		prevWord := word(0);
      		word(0) := rotWord(word(5));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor word(0);
      		generatedKeys(i) := word(4) & word(5) & word(0) & word(1);
      		states := a2to5_192;
      	  when a0to3_192 =>
      		prevWord := word(0);
      		word(0) := rotWord(word(5));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor word(0);
      		word(2) := word(2) xor word(1);
      		word(3) := word(3) xor word(2);
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      		states := a4to1_192;
      	  when a4to1_192 =>
      		word(4) := word(4) xor word(3);
      		word(5) := word(5) xor word(4);
      		rcon := setrcon(rcon);
      		prevWord := word(0);
      		word(0) := rotWord(word(5));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor (word(0));
      		generatedKeys(i) := word(4) & word(5) & word(0) & word(1);
      		states := a2to5_192;
      	  when a2to5_192 =>
      		word(2) := word(2) xor word(1);
      		word(3) := word(3) xor word(2);
      		word(4) := word(4) xor word(3);
      		word(5) := word(5) xor word(4);
      		generatedKeys(i) := word(2) & word(3) & word(4) & word(5);
      		rcon := setrcon(rcon);
      		states := a0to3_192;
      	end case;
        end loop;
	    return generatedKeys;
  end function;
  
  BEGIN 
    KeyExpansion : process(clk, nrst, start, Key, Key_Length, Decrypt)
      type aesState is array (7 downto 0) of std_logic_vector(31 downto 0);
	    type outputState is (init_128, a0to3_128, init_192, first4to1_192, a0to3_192, a4to1_192, a2to5_192, init_256, first4to7_256, a0to3_256, a4to7_256);
	    variable keys : KeyRegisters;
	    variable mode : aesMode;
	    variable waitfor1clk : boolean := false;
	    variable counter : integer := 0;
			variable isRunning : boolean := false;
			variable isDecrypting : boolean := false;
			begin
		  if Key_Length'event and isRunning = false then
		    case Key_Length is
		  	when b"00" =>
		  	  mode := aes128;
		  	when b"01" =>
		  	  mode := aes192;
		  	when b"10" =>
		  	  mode := aes256;
		  	when others =>
		  	  mode := aes256;
		    end case;
			end if;
			if Decrypt'event and isRunning = false then
				if Decrypt = '1' then
					isDecrypting := true;
				else
					isDecrypting := false;
				end if;
			end if;
		  if(nrst = '0') then
		    waitfor1clk := false;
		    counter := 0;
		    isRunning := false;
				Key_I <= x"00000000000000000000000000000000";
				isDecrypting := false;
		  elsif(rising_edge(clk)) then
		    if start = '1' and isRunning = false then
					isRunning := true;
					keys := GenerateKeySchedules(Key, mode);
					if isDecrypting = false then
						counter := 0;
					else
						case mode is
							when aes128 =>
								counter := 10;
							when aes192 =>
								counter := 12;
						 when aes256 =>
								counter := 14;
						end case;
					end if;
		    end if;
				if isRunning and (waitfor1clk = false) then
						Key_I <= keys(counter);
						if isDecrypting = false then
					    counter := counter + 1;
		  	      case mode is
		  	      	when aes128 =>
		  	      	  if counter > 10 then
		  	      	    isRunning := false;
		  	      	  end if;
		  	      	when aes192 =>
		  	      	  if counter > 12 then
		  	      		  isRunning := false;
		  	      	  end if;
		  	      	when aes256 =>
		  	      	  if counter > 14 then
		  	      		  isRunning := false;
		  	      	  end if;
							end case;
						else
							counter := counter - 1;
							if counter < 0 then
								isRunning := false;
							end if;
						end if;
		  	    if isRunning = false then
		  	      counter := 0;
		  	    end if;
						waitfor1clk := true;
  	    elsif(waitfor1clk) then
  	      waitfor1clk := false;
  	    end if;	
       end if; 
    end process;
END ExpandKeys_architecture;