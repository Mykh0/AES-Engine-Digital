-- Created on Fri Dec 21 12:10:48 2018

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY InverseMixcolumns IS
  PORT  
  (
    RawData : IN STD_LOGIC_VECTOR(127 downto 0);
    Encrypted : OUT STD_LOGIC_VECTOR(127 downto 0)
  );
END InverseMixcolumns;

ARCHITECTURE rtl OF InverseMixcolumns IS
  function MULTIPLY1(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_VECTOR is
    begin
      return A;
  end MULTIPLY1;
  
  function MULTIPLY2(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_vECTOR is
    begin
      if (A(7) = '1') then
        return (A(6 downto 0) & '0') xor x"1B";
      else
        return (A(6 downto 0) & '0');
      end if;
  end MULTIPLY2;
    
  function MULTIPLY3(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_VECTOR is
    begin
      return MULTIPLY2(A) xor A;
  end MULTIPLY3;
  
  function MULTIPLY9(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_VECTOR is
    begin
      return MULTIPLY2(MULTIPLY2(MULTIPLY2(A))) xor A;
  end MULTIPLY9;
  
  function MULTIPLY11(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_VECTOR is
    begin
      return MULTIPLY2(MULTIPLY2(MULTIPLY2(A)) XOR A) XOR A;
  end MULTIPLY11;
  
  function MULTIPLY13(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_VECTOR is
    begin
      return MULTIPLY2(MULTIPLY2(MULTIPLY2(A) XOR A)) XOR A;
  end MULTIPLY13;
  
  function MULTIPLY14(A : STD_LOGIC_VECTOR(7 downto 0) := x"00") return STD_LOGIC_VECTOR is
    begin
      return MULTIPLY2(MULTIPLY2(MULTIPLY2(A) XOR A) XOR A);
  end MULTIPLY14;
                  
  
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
      byteAEcrypted := MULTIPLY14(byteA)      xor MULTIPLY11(byteB)   xor MULTIPLY13(byteC)     xor MULTIPLY9(byteD);
      byteBEcrypted := MULTIPLY9(byteA)      xor MULTIPLY14(byteB)     xor MULTIPLY11(byteC)   xor MULTIPLY13(byteD);
      byteCEcrypted := MULTIPLY13(byteA)      xor MULTIPLY9(byteB)     xor MULTIPLY14(byteC)     xor MULTIPLY11(byteD);
      byteDEcrypted := MULTIPLY11(byteA)    xor MULTIPLY13(byteB)     xor MULTIPLY9(byteC)     xor MULTIPLY14(byteD);
      return byteAEcrypted & byteBEcrypted & byteCEcrypted & byteDEcrypted;
  end MIX_ONE_COLUMN;
  
  BEGIN
    MixDatBish : process(RawData)
    begin
      Encrypted <= MIX_ONE_COLUMN(RawData(127 downto 96)) & MIX_ONE_COLUMN(RawData(95 downto 64)) & MIX_ONE_COLUMN(RawData(63 downto 32)) & MIX_ONE_COLUMN(RawData(31 downto 0));
    end process;
END rtl;