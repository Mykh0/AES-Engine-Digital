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
-- CREATED		"Mon Jan 21 08:46:38 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY AES_Engine IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		start_engine :  IN  STD_LOGIC;
		engine_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		key :  IN  STD_LOGIC_VECTOR(255 DOWNTO 0);
		key_length :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		engine_ready :  OUT  STD_LOGIC;
		engine_out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END AES_Engine;

ARCHITECTURE bdf_type OF AES_Engine IS 

COMPONENT mux128
	PORT(sel : IN STD_LOGIC;
		 a1 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 a2 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT aes_encryption_core
	PORT(last_round : IN STD_LOGIC;
		 AES_enc_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 AES_enc_ki : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 AES_enc_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT loadregister
	PORT(load : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT aes_encrypt_controller
	PORT(clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 start_core : IN STD_LOGIC;
		 key_l : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 load_input : OUT STD_LOGIC;
		 load_output : OUT STD_LOGIC;
		 load_loop : OUT STD_LOGIC;
		 load_key : OUT STD_LOGIC;
		 mux_s : OUT STD_LOGIC;
		 last_round : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT expandkeys
	PORT(clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 Key : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
		 Key_Length : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 Key_I : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT synchroniser
	PORT(start_engine : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 key_l : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 engine_ready : OUT STD_LOGIC;
		 start_core : OUT STD_LOGIC;
		 start_scheduler : OUT STD_LOGIC;
		 reset_engine : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT xor128
	PORT(a1 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 a2 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT subkeyselector
	PORT(decrypt : IN STD_LOGIC;
		 DecryptKey : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
		 EncryptKey : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
		 key_l : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	clear_register :  STD_LOGIC;
SIGNAL	core_in :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	core_key :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	core_out :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	input_data :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	key_I :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	last_round :  STD_LOGIC;
SIGNAL	load_input :  STD_LOGIC;
SIGNAL	load_key :  STD_LOGIC;
SIGNAL	load_loop :  STD_LOGIC;
SIGNAL	load_output :  STD_LOGIC;
SIGNAL	looped_data :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	mux_s :  STD_LOGIC;
SIGNAL	register_input :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	reset_register :  STD_LOGIC;
SIGNAL	start_core :  STD_LOGIC;
SIGNAL	start_scheduler :  STD_LOGIC;
SIGNAL	xor_in :  STD_LOGIC_VECTOR(127 DOWNTO 0);


BEGIN 



b2v_128B_mux : mux128
PORT MAP(sel => mux_s,
		 a1 => input_data,
		 a2 => looped_data,
		 output => core_in);


b2v_AES_Core : aes_encryption_core
PORT MAP(last_round => last_round,
		 AES_enc_in => core_in,
		 AES_enc_ki => core_key,
		 AES_enc_out => core_out);


b2v_Input_register : loadregister
PORT MAP(load => load_input,
		 nrst => nrst,
		 clk => clk,
		 data_in => register_input,
		 q => input_data);


b2v_inst : aes_encrypt_controller
PORT MAP(clk => clk,
		 nrst => nrst,
		 start_core => start_core,
		 key_l => key_length,
		 load_input => load_input,
		 load_output => load_output,
		 load_loop => load_loop,
		 load_key => load_key,
		 mux_s => mux_s,
		 last_round => last_round);


b2v_inst1 : expandkeys
PORT MAP(clk => clk,
		 nrst => nrst,
		 start => start_scheduler,
		 Key => key,
		 Key_Length => key_length,
		 Key_I => key_I);


b2v_inst2 : synchroniser
PORT MAP(start_engine => start_engine,
		 clk => clk,
		 nrst => nrst,
		 key_l => key_length,
		 engine_ready => engine_ready,
		 start_core => start_core,
		 start_scheduler => start_scheduler,
		 reset_engine => reset_register);


b2v_inst3 : xor128
PORT MAP(a1 => engine_in,
		 a2 => xor_in,
		 output => register_input);


b2v_inst4 : subkeyselector
PORT MAP(EncryptKey => key,
		 key_l => key_length,
		 output => xor_in);


clear_register <= nrst AND reset_register;


b2v_Key_register : loadregister
PORT MAP(load => load_key,
		 nrst => nrst,
		 clk => clk,
		 data_in => key_I,
		 q => core_key);


b2v_Loop_register : loadregister
PORT MAP(load => load_loop,
		 nrst => clear_register,
		 clk => clk,
		 data_in => core_out,
		 q => looped_data);


b2v_Output_register : loadregister
PORT MAP(load => load_output,
		 nrst => nrst,
		 clk => clk,
		 data_in => core_out,
		 q => engine_out);


END bdf_type;