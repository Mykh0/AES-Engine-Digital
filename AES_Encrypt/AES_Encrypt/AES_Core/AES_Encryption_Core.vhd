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
-- CREATED		"Mon Jan 21 08:49:04 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY AES_Encryption_Core IS 
	PORT
	(
		last_round :  IN  STD_LOGIC;
		AES_enc_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		AES_enc_ki :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		AES_enc_out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END AES_Encryption_Core;

ARCHITECTURE bdf_type OF AES_Encryption_Core IS 

COMPONENT keyadd
	PORT(ka_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 ki_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 ka_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mixcolumns
	PORT(mc_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 mc_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rowshift
	PORT(rs_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 rs_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT substitutebox
	PORT(s_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 s_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux2
	PORT(last_round : IN STD_LOGIC;
		 a1 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 a2 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC_VECTOR(127 DOWNTO 0);


BEGIN 



b2v_inst : keyadd
PORT MAP(ka_in => SYNTHESIZED_WIRE_0,
		 ki_in => AES_enc_ki,
		 ka_out => AES_enc_out);


b2v_inst2 : mixcolumns
PORT MAP(mc_in => SYNTHESIZED_WIRE_1,
		 mc_out => SYNTHESIZED_WIRE_5);


b2v_inst3 : rowshift
PORT MAP(rs_in => SYNTHESIZED_WIRE_2,
		 rs_out => SYNTHESIZED_WIRE_1);


b2v_inst4 : substitutebox
PORT MAP(s_in => AES_enc_in,
		 s_out => SYNTHESIZED_WIRE_2);


b2v_inst5 : substitutebox
PORT MAP(s_in => AES_enc_in,
		 s_out => SYNTHESIZED_WIRE_3);


b2v_inst6 : rowshift
PORT MAP(rs_in => SYNTHESIZED_WIRE_3,
		 rs_out => SYNTHESIZED_WIRE_4);


b2v_inst8 : mux2
PORT MAP(last_round => last_round,
		 a1 => SYNTHESIZED_WIRE_4,
		 a2 => SYNTHESIZED_WIRE_5,
		 output => SYNTHESIZED_WIRE_0);


END bdf_type;