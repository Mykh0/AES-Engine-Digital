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

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 17.0.0 Build 595 04/25/2017 SJ Standard Edition"
-- CREATED		"Tue Jan 08 21:53:41 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY KeySchedulerTopLevel IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		Key :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		Key_I :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END KeySchedulerTopLevel;

ARCHITECTURE bdf_type OF KeySchedulerTopLevel IS 

COMPONENT keyscheduler
	PORT(clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 Key : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 Key_I : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;



BEGIN 



b2v_inst : keyscheduler
PORT MAP(clk => clk,
		 nrst => nrst,
		 start => start,
		 Key => Key,
		 Key_I => Key_I);


END bdf_type;