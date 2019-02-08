library ieee;
USE ieee.std_logic_1164.all; 

entity led is
  port(
    controlLed : in std_logic;
    ledOut : out std_logic
  );
end led;

architecture rtl of led is
  begin
    ledOut <= controlLed;
end rtl;