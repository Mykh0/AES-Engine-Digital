-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "12/24/2018 11:46:30"
                                                            
-- Vhdl Test Bench template for design  :  MixColumns
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY MixColumns_vhd_tst IS
END MixColumns_vhd_tst;
ARCHITECTURE MixColumns_arch OF MixColumns_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL Encrypted : STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL RawData : STD_LOGIC_VECTOR(127 DOWNTO 0);
COMPONENT MixColumns
	PORT (
	Encrypted : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
	RawData : IN STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : MixColumns
	PORT MAP (
-- list connections between master ports and signals
	Encrypted => Encrypted,
	RawData => RawData
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
  RawData <= x"d4bf5d30d4bf5d30d4bf5d30d4bf5d30";
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list
		wait for 10ns;
		Assert (Encrypted = x"046681E5046681E5046681E5046681E5") report "Encryption is wrong" & Encrypted severity error;
WAIT;	                                                        
END PROCESS always;                                          
END MixColumns_arch;
