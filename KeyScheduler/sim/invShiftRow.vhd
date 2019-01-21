LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity InverseShiftRow is
  port
  (
    data_in : in std_logic_vector(127 downto 0);
    data_out : out std_logic_Vector(127 downto 0)
  );
end InverseShiftRow;

architecture shiftrow of InverseShiftRow is
  function ShiftRow(source : std_logic_vector(127 downto 0)) return std_logic_vector is
    variable tmp : std_logic_vector(127 downto 0);
    begin
      tmp := source;
      tmp(127 downto 96)  :=  source(127 downto 120)  & source(23 downto 16)   & source(47 downto 40)    & source(71 downto 64);
      tmp(95 downto 64)   :=  source(95 downto 88)    & source(119 downto 112) & source(15 downto 8)     & source(39 downto 32); 
      tmp(63 downto 32)   :=  source(63 downto 56)    & source(87 downto 80)   & source(111 downto 104)  & source(7 downto 0);
      tmp(31 downto 0)    :=  source(31 downto 24)    & source(55 downto 48)   & source(79 downto 72)    & source(103 downto 96);
      return tmp;
  end function ShiftRow;
  begin
  process(data_in)
    begin
    data_out <= ShiftRow(data_in);
  end process;
end shiftrow;