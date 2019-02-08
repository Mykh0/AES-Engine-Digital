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
-- CREATED		"Thu Feb 07 16:15:41 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY AES_Core IS 
	PORT
	(
		keyAdd_only :  IN  STD_LOGIC;
		last_round :  IN  STD_LOGIC;
		decrypt :  IN  STD_LOGIC;
		AES_Core_In :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		ki_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		AES_Core_Out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END AES_Core;

ARCHITECTURE bdf_type OF AES_Core IS 

COMPONENT substitutebox
	PORT(s_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 s_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mux128b
	PORT(sel : IN STD_LOGIC;
		 a1 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 a2 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT inverseshiftrow
	PORT(data_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT inversesubstitutebox
	PORT(data_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 data_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT keyadd
	PORT(ka_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 ki_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 ka_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT inversemixcolumns
	PORT(RawData : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 Encrypted : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rowshift
	PORT(rs_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 rs_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT mixcolumns
	PORT(mc_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 mc_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	addkeyfrommux :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	addkeymuxin :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	decrypt_out :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	encrypt_out :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	imco_out :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	is_out0 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	is_out1 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	issr0 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	issr1 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	ka_in0 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	ka_in1 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	mc_out0 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	rs_out0 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	rs_out1 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	s_out0 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	s_out1 :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	skip_mix_column :  STD_LOGIC;
SIGNAL	SubDecryptOut :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	Subencrypt_res :  STD_LOGIC_VECTOR(127 DOWNTO 0);


BEGIN 



b2v_inst : substitutebox
PORT MAP(s_in => AES_Core_In,
		 s_out => s_out1);


skip_mix_column <= last_round OR keyAdd_only;


b2v_inst10 : mux128b
PORT MAP(sel => keyAdd_only,
		 a1 => AES_Core_In,
		 a2 => Subencrypt_res,
		 output => ka_in0);


b2v_inst11 : mux128b
PORT MAP(sel => keyAdd_only,
		 a1 => AES_Core_In,
		 a2 => SubDecryptOut,
		 output => ka_in1);


b2v_inst12 : mux128b
PORT MAP(sel => last_round,
		 a1 => issr1,
		 a2 => imco_out,
		 output => SubDecryptOut);


b2v_inst13 : inverseshiftrow
PORT MAP(data_in => is_out0,
		 data_out => issr0);


b2v_inst14 : inversesubstitutebox
PORT MAP(data_in => AES_Core_In,
		 data_out => is_out0);


b2v_inst15 : keyadd
PORT MAP(ka_in => ka_in1,
		 ki_in => addkeyfrommux,
		 ka_out => decrypt_out);


b2v_inst16 : inversemixcolumns
PORT MAP(RawData => issr0,
		 Encrypted => imco_out);


b2v_inst17 : inversesubstitutebox
PORT MAP(data_in => AES_Core_In,
		 data_out => is_out1);


b2v_inst18 : inverseshiftrow
PORT MAP(data_in => is_out1,
		 data_out => issr1);


b2v_inst19 : mux128b
PORT MAP(sel => decrypt,
		 a1 => decrypt_out,
		 a2 => encrypt_out,
		 output => AES_Core_Out);


b2v_inst20 : inversemixcolumns
PORT MAP(RawData => ki_in,
		 Encrypted => addkeymuxin);


b2v_inst21 : mux128b
PORT MAP(sel => skip_mix_column,
		 a1 => ki_in,
		 a2 => addkeymuxin,
		 output => addkeyfrommux);


b2v_inst4 : rowshift
PORT MAP(rs_in => s_out1,
		 rs_out => rs_out1);


b2v_inst5 : mixcolumns
PORT MAP(mc_in => rs_out1,
		 mc_out => mc_out0);


b2v_inst6 : keyadd
PORT MAP(ka_in => ka_in0,
		 ki_in => ki_in,
		 ka_out => encrypt_out);


b2v_inst7 : mux128b
PORT MAP(sel => last_round,
		 a1 => rs_out0,
		 a2 => mc_out0,
		 output => Subencrypt_res);


b2v_inst8 : substitutebox
PORT MAP(s_in => AES_Core_In,
		 s_out => s_out0);


b2v_inst9 : rowshift
PORT MAP(rs_in => s_out0,
		 rs_out => rs_out0);


END bdf_type;