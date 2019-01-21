LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MixColumns IS
	PORT
	(
		RawData : IN STD_LOGIC_VECTOR(127 downto 0);
		Encrypted : OUT STD_LOGIC_VECTOR(127 downto 0)
	);
END MixColumns;

ARCHITECTURE rtl OF MixColumns IS

function MULTIPLY_ONE(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_VECTOR is
begin
  return A;
end MULTIPLY_ONE;

function MULTIPLY_TWO(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_vECTOR is
begin
  if (A(7) = '1') then
    return (A(6 downto 0) & '0') xor x"1B";
  else
    return (A(6 downto 0) & '0');
  end if;
end MULTIPLY_TWO;
  
function MULTIPLY_THREE(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_VECTOR is
begin
  return MULTIPLY_TWO(A) xor A;
end MULTIPLY_THREE;

function MIX_ONE_COLUMN(A : STD_LOGIC_VECTOR(31 downto 0) := x"00000000") return STD_LOGIC_VECTOR is
  variable byteA : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  variable byteB : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  variable byteC : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  variable byteD : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  variable byteAEcrypted : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  variable byteBEcrypted : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  variable byteCEcrypted : STD_LOGIC_VECTOR(7 downto 0) := x"00";
  variable byteDEcrypted : STD_LOGIC_VECTOR(7 downto 0) := x"00";
begin
  byteA := A(31 downto 24);
  byteB := A(23 downto 16);
  byteC := A(15 downto 8);
  byteD := A(7 downto 0);
  byteAEcrypted := MULTIPLY_TWO(byteA) xor MULTIPLY_THREE(byteB) xor MULTIPLY_ONE(byteC) xor MULTIPLY_ONE(byteD);
  byteBEcrypted := MULTIPLY_ONE(byteA) xor MULTIPLY_TWO(byteB) xor MULTIPLY_THREE(byteC) xor MULTIPLY_ONE(byteD);
  byteCEcrypted := MULTIPLY_ONE(byteA) xor MULTIPLY_ONE(byteB) xor MULTIPLY_TWO(byteC) xor MULTIPLY_THREE(byteD);
  byteDEcrypted := MULTIPLY_THREE(byteA) xor MULTIPLY_ONE(byteB) xor MULTIPLY_ONE(byteC) xor MULTIPLY_TWO(byteD);
  return byteAEcrypted & byteBEcrypted & byteCEcrypted & byteDEcrypted;
end MIX_ONE_COLUMN;

BEGIN

MixDatBish : process(RawData)
begin
  Encrypted <= MIX_ONE_COLUMN(RawData(127 downto 96)) & MIX_ONE_COLUMN(RawData(95 downto 64)) & MIX_ONE_COLUMN(RawData(63 downto 32)) & MIX_ONE_COLUMN(RawData(31 downto 0));
end process;

END rtl;