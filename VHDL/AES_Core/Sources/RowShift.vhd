-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"
-- CREATED		"Mon Jan 21 08:51:45 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY RowShift IS 
	PORT
	(
		rs_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		rs_out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END RowShift;

ARCHITECTURE bdf_type OF RowShift IS 

COMPONENT remap_block
	PORT(virtual_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 virtual_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	rs_out_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(127 DOWNTO 0);


BEGIN 



b2v_inst : remap_block
PORT MAP(virtual_in => rs_in(7 DOWNTO 0),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(103 DOWNTO 96));


b2v_inst10 : remap_block
PORT MAP(virtual_in => rs_in(71 DOWNTO 64),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(39 DOWNTO 32));


b2v_inst11 : remap_block
PORT MAP(virtual_in => rs_in(79 DOWNTO 72),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(15 DOWNTO 8));


b2v_inst12 : remap_block
PORT MAP(virtual_in => rs_in(87 DOWNTO 80),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(119 DOWNTO 112));


b2v_inst13 : remap_block
PORT MAP(virtual_in => rs_in(95 DOWNTO 88),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(95 DOWNTO 88));


b2v_inst14 : remap_block
PORT MAP(virtual_in => rs_in(103 DOWNTO 96),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(71 DOWNTO 64));


b2v_inst15 : remap_block
PORT MAP(virtual_in => rs_in(111 DOWNTO 104),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(47 DOWNTO 40));


b2v_inst16 : remap_block
PORT MAP(virtual_in => rs_in(119 DOWNTO 112),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(23 DOWNTO 16));


b2v_inst17 : remap_block
PORT MAP(virtual_in => rs_in(127 DOWNTO 120),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(127 DOWNTO 120));


b2v_inst3 : remap_block
PORT MAP(virtual_in => rs_in(15 DOWNTO 8),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(79 DOWNTO 72));


b2v_inst4 : remap_block
PORT MAP(virtual_in => rs_in(23 DOWNTO 16),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(55 DOWNTO 48));


b2v_inst5 : remap_block
PORT MAP(virtual_in => rs_in(31 DOWNTO 24),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(31 DOWNTO 24));


b2v_inst6 : remap_block
PORT MAP(virtual_in => rs_in(39 DOWNTO 32),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(7 DOWNTO 0));


b2v_inst7 : remap_block
PORT MAP(virtual_in => rs_in(47 DOWNTO 40),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(111 DOWNTO 104));


b2v_inst8 : remap_block
PORT MAP(virtual_in => rs_in(55 DOWNTO 48),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(87 DOWNTO 80));


b2v_inst9 : remap_block
PORT MAP(virtual_in => rs_in(63 DOWNTO 56),
		 virtual_out => rs_out_ALTERA_SYNTHESIZED(63 DOWNTO 56));

rs_out <= rs_out_ALTERA_SYNTHESIZED;

END bdf_type;