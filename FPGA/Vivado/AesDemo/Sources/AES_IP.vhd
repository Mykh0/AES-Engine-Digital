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
-- CREATED		"Thu Jan 31 18:39:06 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY AES_IP IS 
	PORT
	(
		S_AXI_ACLK :  IN  STD_LOGIC;
		S_AXI_ARESETN :  IN  STD_LOGIC;
		S_AXI_AWVALID :  IN  STD_LOGIC;
		S_AXI_WVALID :  IN  STD_LOGIC;
		S_AXI_BREADY :  IN  STD_LOGIC;
		S_AXI_ARVALID :  IN  STD_LOGIC;
		S_AXI_RREADY :  IN  STD_LOGIC;
		S_AXI_ARADDR :  IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		S_AXI_ARPROT :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		S_AXI_AWADDR :  IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		S_AXI_AWPROT :  IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		S_AXI_WDATA :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		S_AXI_WSTRB :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		S_AXI_AWREADY :  OUT  STD_LOGIC;
		S_AXI_WREADY :  OUT  STD_LOGIC;
		S_AXI_BVALID :  OUT  STD_LOGIC;
		S_AXI_ARREADY :  OUT  STD_LOGIC;
		S_AXI_RVALID :  OUT  STD_LOGIC;
		S_AXI_BRESP :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);
		S_AXI_RDATA :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		S_AXI_RRESP :  OUT  STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END AES_IP;

ARCHITECTURE bdf_type OF AES_IP IS 

COMPONENT aes_engine
	PORT(clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 decrypt : IN STD_LOGIC;
		 engine_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 key : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
		 key_length : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 ready : OUT STD_LOGIC;
		 engine_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT aes_axi_v1_0_s00_axi
GENERIC (C_S_AXI_ADDR_WIDTH : INTEGER;
			C_S_AXI_DATA_WIDTH : INTEGER
			);
	PORT(S_AXI_ACLK : IN STD_LOGIC;
		 S_AXI_ARESETN : IN STD_LOGIC;
		 S_AXI_AWVALID : IN STD_LOGIC;
		 S_AXI_WVALID : IN STD_LOGIC;
		 S_AXI_BREADY : IN STD_LOGIC;
		 S_AXI_ARVALID : IN STD_LOGIC;
		 S_AXI_RREADY : IN STD_LOGIC;
		 AES_ready : IN STD_LOGIC;
		 AES_DATA_OUT : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 S_AXI_ARADDR : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 S_AXI_ARPROT : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 S_AXI_AWADDR : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		 S_AXI_AWPROT : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		 S_AXI_WDATA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 S_AXI_WSTRB : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 S_AXI_AWREADY : OUT STD_LOGIC;
		 S_AXI_WREADY : OUT STD_LOGIC;
		 S_AXI_BVALID : OUT STD_LOGIC;
		 S_AXI_ARREADY : OUT STD_LOGIC;
		 S_AXI_RVALID : OUT STD_LOGIC;
		 AES_start : OUT STD_LOGIC;
		 AES_decrypt : OUT STD_LOGIC;
		 AES_clk : OUT STD_LOGIC;
		 AES_nrst : OUT STD_LOGIC;
		 AES_DATA_IN : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
		 AES_KEY : OUT STD_LOGIC_VECTOR(255 DOWNTO 0);
		 AES_keylength : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 S_AXI_BRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		 S_AXI_RDATA : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 S_AXI_RRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	AES_Engine_in :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	AES_Engine_key :  STD_LOGIC_VECTOR(255 DOWNTO 0);
SIGNAL	AES_Engine_out :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	clk :  STD_LOGIC;
SIGNAL	Engine_decrypt :  STD_LOGIC;
SIGNAL	Engine_mode :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL	engine_ready :  STD_LOGIC;
SIGNAL	Engine_start :  STD_LOGIC;
SIGNAL	nrst :  STD_LOGIC;


BEGIN 



b2v_inst : aes_engine
PORT MAP(clk => clk,
		 nrst => nrst,
		 start => Engine_start,
		 decrypt => Engine_decrypt,
		 engine_in => AES_Engine_in,
		 key => AES_Engine_key,
		 key_length => Engine_mode,
		 ready => engine_ready,
		 engine_out => AES_Engine_out);


b2v_inst5 : aes_axi_v1_0_s00_axi
GENERIC MAP(C_S_AXI_ADDR_WIDTH => 7,
			C_S_AXI_DATA_WIDTH => 32
			)
PORT MAP(S_AXI_ACLK => S_AXI_ACLK,
		 S_AXI_ARESETN => S_AXI_ARESETN,
		 S_AXI_AWVALID => S_AXI_AWVALID,
		 S_AXI_WVALID => S_AXI_WVALID,
		 S_AXI_BREADY => S_AXI_BREADY,
		 S_AXI_ARVALID => S_AXI_ARVALID,
		 S_AXI_RREADY => S_AXI_RREADY,
		 AES_ready => engine_ready,
		 AES_DATA_OUT => AES_Engine_out,
		 S_AXI_ARADDR => S_AXI_ARADDR,
		 S_AXI_ARPROT => S_AXI_ARPROT,
		 S_AXI_AWADDR => S_AXI_AWADDR,
		 S_AXI_AWPROT => S_AXI_AWPROT,
		 S_AXI_WDATA => S_AXI_WDATA,
		 S_AXI_WSTRB => S_AXI_WSTRB,
		 S_AXI_AWREADY => S_AXI_AWREADY,
		 S_AXI_WREADY => S_AXI_WREADY,
		 S_AXI_BVALID => S_AXI_BVALID,
		 S_AXI_ARREADY => S_AXI_ARREADY,
		 S_AXI_RVALID => S_AXI_RVALID,
		 AES_start => Engine_start,
		 AES_decrypt => Engine_decrypt,
		 AES_clk => clk,
		 AES_nrst => nrst,
		 AES_DATA_IN => AES_Engine_in,
		 AES_KEY => AES_Engine_key,
		 AES_keylength => Engine_mode,
		 S_AXI_BRESP => S_AXI_BRESP,
		 S_AXI_RDATA => S_AXI_RDATA,
		 S_AXI_RRESP => S_AXI_RRESP);


END bdf_type;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY AES_Engine IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		nrst :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		decrypt :  IN  STD_LOGIC;
		engine_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		key :  IN  STD_LOGIC_VECTOR(255 DOWNTO 0);
		key_length :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		ready :  OUT  STD_LOGIC;
		engine_out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END AES_Engine;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity AES_AXI_v1_0_S00_AXI is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	: integer	:= 7
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		S_AXI_ACLK	: in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN	: in std_logic;
		-- Write address (issued by master, acceped by Slave)
		S_AXI_AWADDR	: in std_logic_vector(6 downto 0);
		-- Write channel Protection type. This signal indicates the
    		-- privilege and security level of the transaction, and whether
    		-- the transaction is a data access or an instruction access.
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		-- Write address valid. This signal indicates that the master signaling
    		-- valid write address and control information.
		S_AXI_AWVALID	: in std_logic;
		-- Write address ready. This signal indicates that the slave is ready
    		-- to accept an address and associated control signals.
		S_AXI_AWREADY	: out std_logic;
		-- Write data (issued by master, acceped by Slave) 
		S_AXI_WDATA	: in std_logic_vector(31 downto 0);
		-- Write strobes. This signal indicates which byte lanes hold
    		-- valid data. There is one write strobe bit for each eight
    		-- bits of the write data bus.    
		S_AXI_WSTRB	: in std_logic_vector(3 downto 0);
		-- Write valid. This signal indicates that valid write
    		-- data and strobes are available.
		S_AXI_WVALID	: in std_logic;
		-- Write ready. This signal indicates that the slave
    		-- can accept the write data.
		S_AXI_WREADY	: out std_logic;
		-- Write response. This signal indicates the status
    		-- of the write transaction.
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		-- Write response valid. This signal indicates that the channel
    		-- is signaling a valid write response.
		S_AXI_BVALID	: out std_logic;
		-- Response ready. This signal indicates that the master
    		-- can accept a write response.
		S_AXI_BREADY	: in std_logic;
		-- Read address (issued by master, acceped by Slave)
		S_AXI_ARADDR	: in std_logic_vector(6 downto 0);
		-- Protection type. This signal indicates the privilege
    		-- and security level of the transaction, and whether the
    		-- transaction is a data access or an instruction access.
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		-- Read address valid. This signal indicates that the channel
    		-- is signaling valid read address and control information.
		S_AXI_ARVALID	: in std_logic;
		-- Read address ready. This signal indicates that the slave is
    		-- ready to accept an address and associated control signals.
		S_AXI_ARREADY	: out std_logic;
		-- Read data (issued by slave)
		S_AXI_RDATA	: out std_logic_vector(31 downto 0);
		-- Read response. This signal indicates the status of the
    		-- read transfer.
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is
    		-- signaling the required read data.
		S_AXI_RVALID	: out std_logic;
		-- Read ready. This signal indicates that the master can
    		-- accept the read data and response information.
		S_AXI_RREADY	: in std_logic;
		
		--custom ports
		
		--control ports
		AES_start		:	out	std_logic;
		AES_decrypt		:	out	std_logic;
		AES_keylength	:	out	std_logic_vector(1 	downto 0);
		AES_ready		:	in		std_logic;
		
		--data ports
		AES_DATA_IN		:	out	std_logic_vector(127 downto 0);
		AES_KEY 			:	out 	std_logic_vector(255 downto 0);
		AES_DATA_OUT	:	in		std_logic_vector(127 downto 0);
		
		--other ports
		AES_clk			:	out	std_logic;
		AES_nrst			:	out	std_logic
	);
end AES_AXI_v1_0_S00_AXI;

architecture arch_imp of AES_AXI_v1_0_S00_AXI is

	-- AXI4LITE signals
	signal axi_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_awready	: std_logic;
	signal axi_wready	: std_logic;
	signal axi_bresp	: std_logic_vector(1 downto 0);
	signal axi_bvalid	: std_logic;
	signal axi_araddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_arready	: std_logic;
	signal axi_rdata	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_rresp	: std_logic_vector(1 downto 0);
	signal axi_rvalid	: std_logic;

	-- Example-specific design signals
	-- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	-- ADDR_LSB is used for addressing 32/64 bit registers/memories
	-- ADDR_LSB = 2 for 32 bits (n downto 2)
	-- ADDR_LSB = 3 for 64 bits (n downto 3)
	constant ADDR_LSB  : integer := (C_S_AXI_DATA_WIDTH/32)+ 1;
	constant OPT_MEM_ADDR_BITS : integer := 4;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 17
	signal slv_reg0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES DATA_IN[31..0]
	signal slv_reg1	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES DATA_IN[63..32]
	signal slv_reg2	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES DATA_IN[95..64]
	signal slv_reg3	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES DATA_IN[127..96]
	
	signal slv_reg4	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES_KEY[31..0]
	signal slv_reg5	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES_KEY[63..32]
	signal slv_reg6	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES_KEY[95..64]
	signal slv_reg7	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES_KEY[127..96]
	signal slv_reg8	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES_KEY[159..128]
	signal slv_reg9	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES_KEY[191..160]
	signal slv_reg10	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES_KEY[223..192]
	signal slv_reg11	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES_KEY[255..224]
	
	signal slv_reg12	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES DATA_OUT[31..0]
	signal slv_reg13	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES DATA_OUT[63..32]
	signal slv_reg14	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES DATA_OUT[95..64]
	signal slv_reg15	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES DATA_OUT[127..96]
	
	signal slv_reg16	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);--AES CTRL [ reserved | rdy | start | decrypt | length_1 | length_0 |]
	
	signal slv_reg_rden	: std_logic;
	signal slv_reg_wren	: std_logic;
	signal reg_data_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal byte_index	: integer;

begin
	-- I/O Connections assignments
	
	
--	AES_DATA_IN(31 downto 0) <= slv_reg0;
--	AES_DATA_IN(63 downto 32) <= slv_reg1;
--	AES_DATA_IN(95 downto 64) <= slv_reg2;
--	AES_DATA_IN(127 downto 96) <= slv_reg3;
--	
--	AES_KEY(31 downto 0) <= slv_reg4;
--	AES_KEY(63 downto 32) <= slv_reg5;
--	AES_KEY(95 downto 63) <= slv_reg6;
--	AES_KEY(127 downto 96) <= slv_reg7;
--	AES_KEY(159 downto 128) <= slv_reg8;
--	AES_KEY(191 downto 160) <= slv_reg9;
--	AES_KEY(223 downto 192) <= slv_reg10;
--	AES_KEY(255 downto 244) <= slv_reg11;
--	
--	slv_reg12 <= AES_DATA_OUT(31 downto 0);
--	slv_reg13 <= AES_DATA_OUT(63 downto 32);
--	slv_reg14 <= AES_DATA_OUT(95 downto 64);
--	slv_reg15 <= AES_DATA_OUT(127 downto 96);
--	
--	AES_keylength <= slv_reg16(1 downto 0);
--	AES_decrypt <=  slv_reg16(2);
--	AES_start <= slv_reg16(3);
--	slv_reg16(4) <= AES_ready;
--	
--	AES_nrst <= S_AXI_ARESETN;
--	AES_clk	<=	S_AXI_ACLK;
	

	S_AXI_AWREADY	<= axi_awready;
	S_AXI_WREADY	<= axi_wready;
	S_AXI_BRESP	<= axi_bresp;
	S_AXI_BVALID	<= axi_bvalid;
	S_AXI_ARREADY	<= axi_arready;
	S_AXI_RDATA	<= axi_rdata;
	S_AXI_RRESP	<= axi_rresp;
	S_AXI_RVALID	<= axi_rvalid;
	-- Implement axi_awready generation
	-- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	-- de-asserted when reset is low.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awready <= '0';
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1') then
	        -- slave is ready to accept write address when
	        -- there is a valid write address and write data
	        -- on the write address and data bus. This design 
	        -- expects no outstanding transactions. 
	        axi_awready <= '1';
	      else
	        axi_awready <= '0';
	      end if;
	    end if;
	  end if;
	end process;

	-- Implement axi_awaddr latching
	-- This process is used to latch the address when both 
	-- S_AXI_AWVALID and S_AXI_WVALID are valid. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awaddr <= (others => '0');
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1') then
	        -- Write Address latching
	        axi_awaddr <= S_AXI_AWADDR;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_wready generation
	-- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	-- de-asserted when reset is low. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_wready <= '0';
	    else
	      if (axi_wready = '0' and S_AXI_WVALID = '1' and S_AXI_AWVALID = '1') then
	          -- slave is ready to accept write data when 
	          -- there is a valid write address and write data
	          -- on the write address and data bus. This design 
	          -- expects no outstanding transactions.           
	          axi_wready <= '1';
	      else
	        axi_wready <= '0';
	      end if;
	    end if;
	  end if;
	end process; 

	-- Implement memory mapped register select and write logic generation
	-- The write data is accepted and written to memory mapped registers when
	-- axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	-- select byte enables of slave registers while writing.
	-- These registers are cleared when reset (active low) is applied.
	-- Slave register write enable is asserted when valid address and data are available
	-- and the slave is ready to accept the write address and write data.
	slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID ;

	process (S_AXI_ACLK)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      slv_reg0 <= (others => '0');
	      slv_reg1 <= (others => '0');
	      slv_reg2 <= (others => '0');
	      slv_reg3 <= (others => '0');
	      slv_reg4 <= (others => '0');
	      slv_reg5 <= (others => '0');
	      slv_reg6 <= (others => '0');
	      slv_reg7 <= (others => '0');
	      slv_reg8 <= (others => '0');
	      slv_reg9 <= (others => '0');
	      slv_reg10 <= (others => '0');
	      slv_reg11 <= (others => '0');
	      --slv_reg12 <= (others => '0');
	      --slv_reg13 <= (others => '0');
	      --slv_reg14 <= (others => '0');
	      --slv_reg15 <= (others => '0');
			--slv_reg16 <= (others => '0');
			
	    else
	      loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	      if (slv_reg_wren = '1') then
	        case loc_addr is
	          when b"00000" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 0
	                slv_reg0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00001" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 1
	                slv_reg1(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00010" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 2
	                slv_reg2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00011" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 3
	                slv_reg3(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00100" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 4
	                slv_reg4(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00101" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 5
	                slv_reg5(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00110" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 6
	                slv_reg6(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00111" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 7
	                slv_reg7(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01000" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 8
	                slv_reg8(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01001" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 9
	                slv_reg9(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01010" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 10
	                slv_reg10(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01011" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 11
	                slv_reg11(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
--	          when b"01100" =>
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 12
--	                slv_reg12(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
--	          when b"01101" =>
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 13
--	                slv_reg13(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
--	          when b"01110" =>
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 14
--	                slv_reg14(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
--	          when b"01111" =>
--	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
--	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
--	                -- Respective byte enables are asserted as per write strobes                   
--	                -- slave registor 15
--	                slv_reg15(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
--	              end if;
--	            end loop;
	          when b"10000" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 16
	                slv_reg16(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8); 
	              end if;
	            end loop;
	          when others =>
	            slv_reg0 <= slv_reg0;
	            slv_reg1 <= slv_reg1;
	            slv_reg2 <= slv_reg2;
	            slv_reg3 <= slv_reg3;
	            slv_reg4 <= slv_reg4;
	            slv_reg5 <= slv_reg5;
	            slv_reg6 <= slv_reg6;
	            slv_reg7 <= slv_reg7;
	            slv_reg8 <= slv_reg8;
	            slv_reg9 <= slv_reg9;
	            slv_reg10 <= slv_reg10;
	            slv_reg11 <= slv_reg11;
	            --slv_reg12 <= slv_reg12;
	            --slv_reg13 <= slv_reg13;
	            --slv_reg14 <= slv_reg14;
	            --slv_reg15 <= slv_reg15;
	            --slv_reg16 <= slv_reg16;
	        end case;
	      end if;
	    end if;
	  end if;                   
	end process; 
	
	process (S_AXI_ACLK)
	begin
		if rising_edge(S_AXI_ACLK)	then
		--control register
			AES_start <= slv_reg16(3);
			AES_decrypt <= slv_reg16(2);
			AES_keylength <= slv_reg16(1 downto 0);
			--slv_reg16(4) <= AES_ready;
			
			AES_DATA_IN(31 downto 0) <= slv_reg0;
			AES_DATA_IN(63 downto 32) <= slv_reg1;
			AES_DATA_IN(95 downto 64) <= slv_reg2;
			AES_DATA_IN(127 downto 96) <= slv_reg3;
			
			AES_KEY(31 downto 0) <= slv_reg4;
			AES_KEY(63 downto 32) <= slv_reg5;
			AES_KEY(95 downto 64) <= slv_reg6;
			AES_KEY(127 downto 96) <= slv_reg7;
			AES_KEY(159 downto 128) <= slv_reg8;
			AES_KEY(191 downto 160) <= slv_reg9;
			AES_KEY(223 downto 192) <= slv_reg10;
			AES_KEY(255 downto 224) <= slv_reg11;
			
			slv_reg12 <= AES_DATA_OUT(31 downto 0);
			slv_reg13 <= AES_DATA_OUT(63 downto 32);
			slv_reg14 <= AES_DATA_OUT(95 downto 64);
			slv_reg15 <= AES_DATA_OUT(127 downto 96);
			
			AES_clk <= S_AXI_ACLK;
			AES_nrst <= S_AXI_ARESETN;
			
			
		end if;
	end process;

	-- Implement write response logic generation
	-- The write response and response valid signals are asserted by the slave 
	-- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	-- This marks the acceptance of address and indicates the status of 
	-- write transaction.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_bvalid  <= '0';
	      axi_bresp   <= "00"; --need to work more on the responses
	    else
	      if (axi_awready = '1' and S_AXI_AWVALID = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0'  ) then
	        axi_bvalid <= '1';
	        axi_bresp  <= "00"; 
	      elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
	        axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arready generation
	-- axi_arready is asserted for one S_AXI_ACLK clock cycle when
	-- S_AXI_ARVALID is asserted. axi_awready is 
	-- de-asserted when reset (active low) is asserted. 
	-- The read address is also latched when S_AXI_ARVALID is 
	-- asserted. axi_araddr is reset to zero on reset assertion.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_arready <= '0';
	      axi_araddr  <= (others => '1');
	    else
	      if (axi_arready = '0' and S_AXI_ARVALID = '1') then
	        -- indicates that the slave has acceped the valid read address
	        axi_arready <= '1';
	        -- Read Address latching 
	        axi_araddr  <= S_AXI_ARADDR;           
	      else
	        axi_arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arvalid generation
	-- axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	-- S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	-- data are available on the axi_rdata bus at this instance. The 
	-- assertion of axi_rvalid marks the validity of read data on the 
	-- bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	-- is deasserted on reset (active low). axi_rresp and axi_rdata are 
	-- cleared to zero on reset (active low).  
	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then
	    if S_AXI_ARESETN = '0' then
	      axi_rvalid <= '0';
	      axi_rresp  <= "00";
	    else
	      if (axi_arready = '1' and S_AXI_ARVALID = '1' and axi_rvalid = '0') then
	        -- Valid read data is available at the read data bus
	        axi_rvalid <= '1';
	        axi_rresp  <= "00"; -- 'OKAY' response
	      elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
	        -- Read data is accepted by the master
	        axi_rvalid <= '0';
	      end if;            
	    end if;
	  end if;
	end process;

	-- Implement memory mapped register select and read logic generation
	-- Slave register read enable is asserted when valid address is available
	-- and the slave is ready to accept the read address.
	slv_reg_rden <= axi_arready and S_AXI_ARVALID and (not axi_rvalid) ;

	process (slv_reg0, slv_reg1, slv_reg2, slv_reg3, slv_reg4, slv_reg5, slv_reg6, slv_reg7, slv_reg8, slv_reg9, slv_reg10, slv_reg11, slv_reg12, slv_reg13, slv_reg14, slv_reg15, slv_reg16, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
	begin
	    -- Address decoding for reading registers
	    loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	    case loc_addr is
	      when b"00000" =>
	        reg_data_out <= slv_reg0;
	      when b"00001" =>
	        reg_data_out <= slv_reg1;
	      when b"00010" =>
	        reg_data_out <= slv_reg2;
	      when b"00011" =>
	        reg_data_out <= slv_reg3;
	      when b"00100" =>
	        reg_data_out <= slv_reg4;
	      when b"00101" =>
	        reg_data_out <= slv_reg5;
	      when b"00110" =>
	        reg_data_out <= slv_reg6;
	      when b"00111" =>
	        reg_data_out <= slv_reg7;
	      when b"01000" =>
	        reg_data_out <= slv_reg8;
	      when b"01001" =>
	        reg_data_out <= slv_reg9;
	      when b"01010" =>
	        reg_data_out <= slv_reg10;
	      when b"01011" =>
	        reg_data_out <= slv_reg11;
	      when b"01100" =>
	        reg_data_out <= slv_reg12;
	      when b"01101" =>
	        reg_data_out <= slv_reg13;
	      when b"01110" =>
	        reg_data_out <= slv_reg14;
	      when b"01111" =>
	        reg_data_out <= slv_reg15;
	      when b"10000" =>
	        reg_data_out <= slv_reg16;
	      when others =>
	        reg_data_out  <= (others => '0');
	    end case;
	end process; 

	-- Output register or memory read data
	process( S_AXI_ACLK ) is
	begin
	  if (rising_edge (S_AXI_ACLK)) then
	    if ( S_AXI_ARESETN = '0' ) then
	      axi_rdata  <= (others => '0');
	    else
	      if (slv_reg_rden = '1') then
	        -- When there is a valid read address (S_AXI_ARVALID) with 
	        -- acceptance of read address by the slave (axi_arready), 
	        -- output the read dada 
	        -- Read address mux
	          axi_rdata <= reg_data_out;     -- register read data
	      end if;   
	    end if;
	  end if;
	end process;


	-- Add user logic here

	-- User logic ends

end arch_imp;

ARCHITECTURE bdf_type OF AES_Engine IS 

COMPONENT aes_core
	PORT(last_round : IN STD_LOGIC;
		 decrypt : IN STD_LOGIC;
		 keyAdd_only : IN STD_LOGIC;
		 AES_Core_In : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 ki_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 AES_Core_Out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
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

COMPONENT mux128
	PORT(sel : IN STD_LOGIC;
		 a1 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 a2 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT synchroniser
	PORT(start_engine : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 key_l : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 engine_ready : OUT STD_LOGIC;
		 start_core : OUT STD_LOGIC;
		 start_scheduler : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT keyscheduler
	PORT(clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 Decrypt : IN STD_LOGIC;
		 Key : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
		 Key_Length : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 Key_I : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END COMPONENT;

COMPONENT core_controller
	PORT(clk : IN STD_LOGIC;
		 nrst : IN STD_LOGIC;
		 start_core : IN STD_LOGIC;
		 key_l : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 load_input : OUT STD_LOGIC;
		 load_output : OUT STD_LOGIC;
		 load_loop : OUT STD_LOGIC;
		 load_key : OUT STD_LOGIC;
		 mux_s : OUT STD_LOGIC;
		 last_round : OUT STD_LOGIC;
		 addKeyOnly : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	addKeyOnly :  STD_LOGIC;
SIGNAL	AES_Core_In :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	AES_Core_Out :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	core_start :  STD_LOGIC;
SIGNAL	Input_load :  STD_LOGIC;
SIGNAL	input_reg_out :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	key_load :  STD_LOGIC;
SIGNAL	keyregister_in :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	ki_in :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	last_round :  STD_LOGIC;
SIGNAL	loop_load :  STD_LOGIC;
SIGNAL	loop_reg_out :  STD_LOGIC_VECTOR(127 DOWNTO 0);
SIGNAL	output_load :  STD_LOGIC;
SIGNAL	scheduler_start :  STD_LOGIC;
SIGNAL	sel :  STD_LOGIC;


BEGIN 



b2v_ArithmaticBlock : aes_core
PORT MAP(last_round => last_round,
		 decrypt => decrypt,
		 keyAdd_only => addKeyOnly,
		 AES_Core_In => AES_Core_In,
		 ki_in => ki_in,
		 AES_Core_Out => AES_Core_Out);


b2v_InputRegister : loadregister
PORT MAP(load => Input_load,
		 nrst => nrst,
		 clk => clk,
		 data_in => engine_in,
		 q => input_reg_out);


b2v_inst : mux128
PORT MAP(sel => sel,
		 a1 => input_reg_out,
		 a2 => loop_reg_out,
		 output => AES_Core_In);


b2v_inst2 : synchroniser
PORT MAP(start_engine => start,
		 clk => clk,
		 nrst => nrst,
		 key_l => key_length,
		 engine_ready => ready,
		 start_core => core_start,
		 start_scheduler => scheduler_start);


b2v_inst3 : keyscheduler
PORT MAP(clk => clk,
		 nrst => nrst,
		 start => scheduler_start,
		 Decrypt => decrypt,
		 Key => key,
		 Key_Length => key_length,
		 Key_I => keyregister_in);


b2v_KeyRegister : loadregister
PORT MAP(load => key_load,
		 nrst => nrst,
		 clk => clk,
		 data_in => keyregister_in,
		 q => ki_in);


b2v_LoopRegister : loadregister
PORT MAP(load => loop_load,
		 nrst => nrst,
		 clk => clk,
		 data_in => AES_Core_Out,
		 q => loop_reg_out);


b2v_OutputRegister : loadregister
PORT MAP(load => output_load,
		 nrst => nrst,
		 clk => clk,
		 data_in => AES_Core_Out,
		 q => engine_out);


b2v_RegisterController : core_controller
PORT MAP(clk => clk,
		 nrst => nrst,
		 start_core => core_start,
		 key_l => key_length,
		 load_input => Input_load,
		 load_output => output_load,
		 load_loop => loop_load,
		 load_key => key_load,
		 mux_s => sel,
		 last_round => last_round,
		 addKeyOnly => addKeyOnly);


END bdf_type;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY synchroniser IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(		
		start_engine 	:	IN 	STD_LOGIC;
		clk				:	IN		STD_LOGIC;
		nrst				:	IN		STD_LOGIC;
		key_l				:	IN		STD_LOGIC_VECTOR(1 downto 0);
		
		engine_ready	:	OUT	STD_LOGIC;
		start_core		:	OUT 	STD_LOGIC;
		start_scheduler:	OUT	STD_LOGIC
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

END entity;

ARCHITECTURE rtl of synchroniser IS
	type synch_state is (WaitForStart, StartScheduler, StartCore, EndScheduler, EndCore, EngineReady);
	
	signal State : synch_state;
	

BEGIN

behaviour : process(clk, nrst)

	variable cround	:	integer  range 0 to 32;	-- current round count
	variable mround	:	integer	range 0 to 32;	-- maximal round count
	
begin
	if nrst = '0' then
	State <= WaitForStart;
	
	start_core <= '0';
	start_scheduler <= '0';
	cround := 0;
	mround := 0;
	engine_ready <= '0';
	
	elsif rising_edge(clk) then
	case State is
		when WaitForStart =>
		engine_ready <= '1';
		
		if start_engine = '1'then
		cround := 0;
		State <= StartScheduler;
		engine_ready <= '0';
		end if;
		
		when StartScheduler =>
		State <= StartCore;
		
		case key_l is
			when "00" =>
				mround := 24;
			when "01" =>
				mround := 28; 
			when "10" =>
					mround := 32; 
			when others => mround := 0; --do nothing/reserved
		end case;
		
		
		
		cround := cround +1;
		
		when StartCore =>
		start_core <= '1';
		start_scheduler <= '1';
		
		
		cround := cround +1;
		
		State <= endCore;
		
		when endCore =>
		start_core <= '0';
		start_scheduler <= '0';
		cround := cround + 1;
		
		if(cround >= mround) then
		State <= endScheduler;
		end if;
		
		when endScheduler =>
		State <= EngineReady;
		start_scheduler <= '0';
	
		when EngineReady =>
		State <= WaitForStart;
		engine_ready <= '1';
	
	end case;
	
	end if;


end process;

END architecture;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity Mux128 is
port(
  a1      : in  std_logic_vector(127 downto 0);
  a2      : in  std_logic_vector(127 downto 0);
  sel : in  std_logic;
  output       : out std_logic_vector(127 downto 0));
end Mux128;

architecture rtl of Mux128 is

begin

p_mux : process(a1,a2,sel)
begin

if( sel = '0' ) then
output <= a1;


else
output <= a2; 

end if;

end process p_mux;

end rtl;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY LoadRegister IS PORT(
    data_in   	: IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    load  		: IN STD_LOGIC; -- load/enable.
    nrst 		: IN STD_LOGIC; -- async. clear.
    clk 		: IN STD_LOGIC; 
    q   		: OUT STD_LOGIC_VECTOR(127 DOWNTO 0) -- output
);
END LoadRegister;

ARCHITECTURE description OF LoadRegister IS

BEGIN

    process(clk, nrst)
	 variable data : std_logic_vector(127 downto 0);
	 
    begin
        if nrst = '0' then
            data := X"00000000000000000000000000000000";
			
				
        elsif rising_edge(clk) and (load = '1' )then
                data := data_in;
        end if;
		  
		  q <= data;
		  
    end process;
END description;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;


ENTITY KeyScheduler IS
	PORT
	(
        Key : IN STD_LOGIC_VECTOR(255 downto 0);
        Key_Length : IN STD_LOGIC_VECTOR(1 downto 0);
		clk : IN STD_LOGIC;
		nrst : IN STD_LOGIC;
		start : IN STD_LOGIC;
		Decrypt : IN STD_LOGIC;
		Key_I : OUT STD_LOGIC_VECTOR(127 downto 0)
	);
END KeyScheduler;

ARCHITECTURE ExpandKeys_architecture OF KeyScheduler IS

  type KeyRegisters is array(0 to 14) of std_logic_vector(127 downto 0);
  type aesMode is (aes128, aes192, aes256);
  
  function setrcon(rcon: std_logic_vector(31 downto 0)) return std_logic_vector is
    variable tmp : std_logic_vector(31 downto 0) := x"00000000";
    begin
      tmp := rcon(30 downto 0) & '0';
      if(tmp = x"00000000") then
  	    tmp := tmp xor x"1B000000";
      end if;
        return tmp;
  end function setrcon;
  
  function rotWord(source : std_logic_vector(31 downto 0)) return std_logic_vector is
    begin
      return source(23 downto 0) & source(31 downto 24);
  end function rotWord;
  
  function SBox(A : std_logic_vector(7 downto 0)) return std_logic_vector is
    variable MSB_Nibble : std_logic_vector (3 DOWNTO 0);
	 variable LSB_Nibble : std_logic_vector (3 DOWNTO 0);
	 variable B : std_logic_vector(7 downto 0);
	 
	 begin
	 MSB_Nibble := A(7 downto 4);
	 LSB_Nibble := A(3 downto 0);
	 
	 case MSB_Nibble is --determine row
	 
	 when X"0" => 
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"63";
	 when X"1" => B := X"7C";
	 when X"2" => B := X"77";
	 when X"3" => B := X"7B";
	 when X"4" => B := X"F2";
	 when X"5" => B := X"6B";
	 when X"6" => B := X"6F";
	 when X"7" => B := X"C5";
	 when X"8" => B := X"30";
	 when X"9" => B := X"01";
	 when X"A" => B := X"67";
	 when X"B" => B := X"2B";
	 when X"C" => B := X"FE";
	 when X"D" => B := X"D7";
	 when X"E" => B := X"AB";
	 when X"F" => B := X"76";
	 when others => B := "--------";
	 end case;
	 
	 when X"1" =>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"CA";
	 when X"1" => B := X"82";
	 when X"2" => B := X"C9";
	 when X"3" => B := X"7D";
	 when X"4" => B := X"FA";
	 when X"5" => B := X"59";
	 when X"6" => B := X"47";
	 when X"7" => B := X"F0";
	 when X"8" => B := X"AD";
	 when X"9" => B := X"D4";
	 when X"A" => B := X"A2";
	 when X"B" => B := X"AF";
	 when X"C" => B := X"9C";
	 when X"D" => B := X"A4";
	 when X"E" => B := X"72";
	 when X"F" => B := X"C0";
	 when others => B := "--------";
	 end case;		
 
	 when X"2" =>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"B7";
	 when X"1" => B := X"FD";
	 when X"2" => B := X"93";
	 when X"3" => B := X"26";
	 when X"4" => B := X"36";
	 when X"5" => B := X"3F";
	 when X"6" => B := X"F7";
	 when X"7" => B := X"CC";
	 when X"8" => B := X"34";
	 when X"9" => B := X"A5";
	 when X"A" => B := X"E5";
	 when X"B" => B := X"F1";
	 when X"C" => B := X"71";
	 when X"D" => B := X"D8";
	 when X"E" => B := X"31";
	 when X"F" => B := X"15";
	 when others => B := "--------";
	 end case;
 
	 when X"3"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"04";
	 when X"1" => B := X"C7";
	 when X"2" => B := X"23";
	 when X"3" => B := X"C3";
	 when X"4" => B := X"18";
	 when X"5" => B := X"96";
	 when X"6" => B := X"05";
	 when X"7" => B := X"9A";
	 when X"8" => B := X"07";
	 when X"9" => B := X"12";
	 when X"A" => B := X"80";
	 when X"B" => B := X"E2";
	 when X"C" => B := X"EB";
	 when X"D" => B := X"27";
	 when X"E" => B := X"B2";
	 when X"F" => B := X"75";
	 when others => B := "--------";
	 end case;
	 
	 when X"4"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"09";
	 when X"1" => B := X"83";
	 when X"2" => B := X"2C";
	 when X"3" => B := X"1A";
	 when X"4" => B := X"1B";
	 when X"5" => B := X"6E";
	 when X"6" => B := X"5A";
	 when X"7" => B := X"A0";
	 when X"8" => B := X"52";
	 when X"9" => B := X"3B";
	 when X"A" => B := X"D6";
	 when X"B" => B := X"B3";
	 when X"C" => B := X"29";
	 when X"D" => B := X"E3";
	 when X"E" => B := X"2F";
	 when X"F" => B := X"84";
	 when others => B := "--------";
	 end case;
	 
	 when X"5"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"53";
	 when X"1" => B := X"D1";
	 when X"2" => B := X"00";
	 when X"3" => B := X"ED";
	 when X"4" => B := X"20";
	 when X"5" => B := X"FC";
	 when X"6" => B := X"B1";
	 when X"7" => B := X"5B";
	 when X"8" => B := X"6A";
	 when X"9" => B := X"CB";
	 when X"A" => B := X"BE";
	 when X"B" => B := X"39";
	 when X"C" => B := X"4A";
	 when X"D" => B := X"4C";
	 when X"E" => B := X"58";
	 when X"F" => B := X"CF";
	 when others => B := "--------";
	 end case;
	 
	 when X"6"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"D0";
	 when X"1" => B := X"EF";
	 when X"2" => B := X"AA";
	 when X"3" => B := X"FB";
	 when X"4" => B := X"43";
	 when X"5" => B := X"4D";
	 when X"6" => B := X"33";
	 when X"7" => B := X"85";
	 when X"8" => B := X"45";
	 when X"9" => B := X"F9";
	 when X"A" => B := X"02";
	 when X"B" => B := X"7F";
	 when X"C" => B := X"50";
	 when X"D" => B := X"3C";
	 when X"E" => B := X"9F";
	 when X"F" => B := X"A8";
	 when others => B := "--------";
	 end case;
	 
	 when X"7"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"51";
	 when X"1" => B := X"A3";
	 when X"2" => B := X"40";
	 when X"3" => B := X"8F";
	 when X"4" => B := X"92";
	 when X"5" => B := X"9D";
	 when X"6" => B := X"38";
	 when X"7" => B := X"F5";
	 when X"8" => B := X"BC";
	 when X"9" => B := X"B6";
	 when X"A" => B := X"DA";
	 when X"B" => B := X"21";
	 when X"C" => B := X"10";
	 when X"D" => B := X"FF";
	 when X"E" => B := X"F3";
	 when X"F" => B := X"D2";
	 when others => B := "--------";
	 end case;
	 
	 when X"8"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"CD";
	 when X"1" => B := X"0C";
	 when X"2" => B := X"13";
	 when X"3" => B := X"EC";
	 when X"4" => B := X"5F";
	 when X"5" => B := X"97";
	 when X"6" => B := X"44";
	 when X"7" => B := X"17";
	 when X"8" => B := X"C4";
	 when X"9" => B := X"A7";
	 when X"A" => B := X"7E";
	 when X"B" => B := X"3D";
	 when X"C" => B := X"64";
	 when X"D" => B := X"5D";
	 when X"E" => B := X"19";
	 when X"F" => B := X"73";
	 when others => B := "--------";
	 end case;
	 
	 when X"9"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"60";
	 when X"1" => B := X"81";
	 when X"2" => B := X"4F";
	 when X"3" => B := X"DC";
	 when X"4" => B := X"22";
	 when X"5" => B := X"2A";
	 when X"6" => B := X"90";
	 when X"7" => B := X"88";
	 when X"8" => B := X"46";
	 when X"9" => B := X"EE";
	 when X"A" => B := X"B8";
	 when X"B" => B := X"14";
	 when X"C" => B := X"DE";
	 when X"D" => B := X"5E";
	 when X"E" => B := X"0B";
	 when X"F" => B := X"DB";
	 when others => B := "--------";
	 end case;
	 
	 when X"A"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"E0";
	 when X"1" => B := X"32";
	 when X"2" => B := X"3A";
	 when X"3" => B := X"0A";
	 when X"4" => B := X"49";
	 when X"5" => B := X"06";
	 when X"6" => B := X"24";
	 when X"7" => B := X"5C";
	 when X"8" => B := X"C2";
	 when X"9" => B := X"D3";
	 when X"A" => B := X"AC";
	 when X"B" => B := X"62";
	 when X"C" => B := X"91";
	 when X"D" => B := X"95";
	 when X"E" => B := X"E4";
	 when X"F" => B := X"79";
	 when others => B := "--------";
	 end case;
	 
	 when X"B"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"E7";
	 when X"1" => B := X"C8";
	 when X"2" => B := X"37";
	 when X"3" => B := X"6D";
	 when X"4" => B := X"8D";
	 when X"5" => B := X"D5";
	 when X"6" => B := X"4E";
	 when X"7" => B := X"A9";
	 when X"8" => B := X"6C";
	 when X"9" => B := X"56";
	 when X"A" => B := X"F4";
	 when X"B" => B := X"EA";
	 when X"C" => B := X"65";
	 when X"D" => B := X"7A";
	 when X"E" => B := X"AE";
	 when X"F" => B := X"08";
	 when others => B := "--------";
	 end case;
	 
	 when X"C"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"BA";
	 when X"1" => B := X"78";
	 when X"2" => B := X"25";
	 when X"3" => B := X"2E";
	 when X"4" => B := X"1C";
	 when X"5" => B := X"A6";
	 when X"6" => B := X"B4";
	 when X"7" => B := X"C6";
	 when X"8" => B := X"E8";
	 when X"9" => B := X"DD";
	 when X"A" => B := X"74";
	 when X"B" => B := X"1F";
	 when X"C" => B := X"4B";
	 when X"D" => B := X"BD";
	 when X"E" => B := X"8B";
	 when X"F" => B := X"8A";
	 when others => B := "--------";
	 end case;
	 
	 when X"D"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"70";
	 when X"1" => B := X"3E";
	 when X"2" => B := X"B5";
	 when X"3" => B := X"66";
	 when X"4" => B := X"48";
	 when X"5" => B := X"03";
	 when X"6" => B := X"F6";
	 when X"7" => B := X"0E";
	 when X"8" => B := X"61";
	 when X"9" => B := X"35";
	 when X"A" => B := X"57";
	 when X"B" => B := X"B9";
	 when X"C" => B := X"86";
	 when X"D" => B := X"C1";
	 when X"E" => B := X"1D";
	 when X"F" => B := X"9E";
	 when others => B := "--------";
	 end case;
	 
	 when X"E"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"E1";
	 when X"1" => B := X"F8";
	 when X"2" => B := X"98";
	 when X"3" => B := X"11";
	 when X"4" => B := X"69";
	 when X"5" => B := X"D9";
	 when X"6" => B := X"8E";
	 when X"7" => B := X"94";
	 when X"8" => B := X"9B";
	 when X"9" => B := X"1E";
	 when X"A" => B := X"87";
	 when X"B" => B := X"E9";
	 when X"C" => B := X"CE";
	 when X"D" => B := X"55";
	 when X"E" => B := X"28";
	 when X"F" => B := X"DF";
	 when others => B := "--------";
	 end case;
	 
	 when X"F"=>
	 case LSB_Nibble is --determinte column
	 when X"0" => B := X"8C";
	 when X"1" => B := X"A1";
	 when X"2" => B := X"89";
	 when X"3" => B := X"0D";
	 when X"4" => B := X"BF";
	 when X"5" => B := X"E6";
	 when X"6" => B := X"42";
	 when X"7" => B := X"68";
	 when X"8" => B := X"41";
	 when X"9" => B := X"99";
	 when X"A" => B := X"2D";
	 when X"B" => B := X"0F";
	 when X"C" => B := X"B0";
	 when X"D" => B := X"54";
	 when X"E" => B := X"BB";
	 when X"F" => B := X"16";
	 when others => B := "--------";
	 end case;
	 
	 when others => B := "--------";
	 end case;
	 return B;
  end function;  
	 
  function SBox32(A: std_logic_vector(31 downto 0)) return std_logic_vector is
    variable word : std_logic_vector(31 downto 0) := x"00000000";
    begin
      word(31 downto 24) := SBox(A(31 downto 24));
  	  word(23 downto 16) := SBox(A(23 downto 16));
  	  word(15 downto 8)  := SBox(A(15 downto 8));
  	  word(7  downto 0)  := SBox(A(7  downto 0));
  	  return word;
  end function SBox32;

  function GenerateKeySchedules(Key : std_logic_vector(255 downto 0); Mode : aesMode) return KeyRegisters is
	  type aesState is array (7 downto 0) of std_logic_vector(31 downto 0);
	  type outputState is (init_128, a0to3_128, init_192, first4to1_192, a0to3_192, a4to1_192, a2to5_192, init_256, first4to7_256, a0to3_256, a4to7_256);
	  variable generatedKeys : KeyRegisters;
	  variable word: aesState;
	  variable states : outputState;
	  variable first : boolean := true;
	  variable rcon : std_logic_vector(31 downto 0) := x"00000000";
	  variable prevWord : std_logic_vector(31 downto 0) := x"00000000";
	  variable waitfor1clk : boolean := false;
	  begin
	    case Mode is
	  	  when aes128 =>
	  		states := init_128;
	  	  when aes192 =>
	  		states := init_192;
	  	  when aes256 =>
	  		states := init_256;
	    end case;
	    for i in 0 to 14 loop
	      case states is
      	  when init_256 =>
      	    word(0) := Key(255 downto 224);
      	    word(1) := Key(223 downto 192);
      	    word(2) := Key(191 downto 160);
      	    word(3) := Key(159 downto 128);
      	    word(4) := Key(127 downto 96);
      	    word(5) := Key(95 downto 64);
      	    word(6) := Key(63 downto 32);
      	    word(7) := Key(31 downto 0);
      	    rcon :=  x"01000000";
      	    prevWord := word(0);
      	    states := first4to7_256;
      	    generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      	  when first4to7_256 =>
      		generatedKeys(i) := word(4) & word(5) & word(6) & word(7);
      		states := a0to3_256;
      	  when a0to3_256 =>
      		prevWord := word(0);
      		word(0) := rotWord(word(7));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor word(0);
      		word(2) := word(2) xor word(1);
      		word(3) := word(3) xor word(2);
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      		states := a4to7_256;
      	  when a4to7_256 =>
      		prevWord := word(4);
      		word(4) := SBox32(word(3));
      		word(4) := word(4) xor prevWord;
      		word(5) := word(5) xor word(4);
      		word(6) := word(6) xor word(5);
      		word(7) := word(7) xor word(6);
      		generatedKeys(i) := word(4) & word(5) & word(6) & word(7);
      		states := a0to3_256;
      		rcon := setrcon(rcon);
      	  when init_128 =>
      		word(0) := Key(127 downto 96);
      		word(1) := Key(95 downto 64);
      		word(2) := Key(63 downto 32);
      		word(3) := Key(31 downto 0);
      		first := false;
      		rcon :=  x"01000000";
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      		states := a0to3_128;
      	  when a0to3_128 =>
      		prevWord := word(0);
      		word(0) := rotWord(word(3));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor word(0);
      		word(2) := word(2) xor word(1);
      		word(3) := word(3) xor word(2);
      		rcon := setrcon(rcon);
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      	  when init_192 =>
      		word(0) := Key(191 downto 160);
      		word(1) := Key(159 downto 128);
      		word(2) := Key(127 downto 96);
      		word(3) := Key(95 downto 64);
      		word(4) := Key(63 downto 32);
      		word(5) := Key(31 downto 0);
      		rcon :=  x"01000000";
      		states := first4to1_192;
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      	  when first4to1_192 =>
      		prevWord := word(0);
      		word(0) := rotWord(word(5));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor word(0);
      		generatedKeys(i) := word(4) & word(5) & word(0) & word(1);
      		states := a2to5_192;
      	  when a0to3_192 =>
      		prevWord := word(0);
      		word(0) := rotWord(word(5));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor word(0);
      		word(2) := word(2) xor word(1);
      		word(3) := word(3) xor word(2);
      		generatedKeys(i) := word(0) & word(1) & word(2) & word(3);
      		states := a4to1_192;
      	  when a4to1_192 =>
      		word(4) := word(4) xor word(3);
      		word(5) := word(5) xor word(4);
      		rcon := setrcon(rcon);
      		prevWord := word(0);
      		word(0) := rotWord(word(5));
      		word(0) := SBox32(word(0));
      		word(0) := word(0) xor rcon xor prevWord;
      		word(1) := word(1) xor (word(0));
      		generatedKeys(i) := word(4) & word(5) & word(0) & word(1);
      		states := a2to5_192;
      	  when a2to5_192 =>
      		word(2) := word(2) xor word(1);
      		word(3) := word(3) xor word(2);
      		word(4) := word(4) xor word(3);
      		word(5) := word(5) xor word(4);
      		generatedKeys(i) := word(2) & word(3) & word(4) & word(5);
      		rcon := setrcon(rcon);
      		states := a0to3_192;
      	end case;
        end loop;
	    return generatedKeys;
  end function;
  
  BEGIN 
    KeyExpansion : process(clk, nrst, start, Key, Key_Length, Decrypt)
      type aesState is array (7 downto 0) of std_logic_vector(31 downto 0);
	    type outputState is (init_128, a0to3_128, init_192, first4to1_192, a0to3_192, a4to1_192, a2to5_192, init_256, first4to7_256, a0to3_256, a4to7_256);
	    variable keys : KeyRegisters;
	    variable mode : aesMode;
	    variable waitfor1clk : boolean := false;
	    variable counter : integer := 0;
			variable isRunning : boolean := false;
			variable isDecrypting : boolean := false;
			begin
		  if rising_edge(clk) and isRunning = false then
		    case Key_Length is
		  	when b"00" =>
		  	  mode := aes128;
		  	when b"01" =>
		  	  mode := aes192;
		  	when b"10" =>
		  	  mode := aes256;
		  	when others =>
		  	  mode := aes256;
		    end case;
			end if;
			if rising_edge(clk) and isRunning = false then
				if Decrypt = '1' then
					isDecrypting := true;
				else
					isDecrypting := false;
				end if;
			end if;
		  if(nrst = '0') then
		    waitfor1clk := false;
		    counter := 0;
		    isRunning := false;
				Key_I <= x"00000000000000000000000000000000";
				isDecrypting := false;
		  elsif(rising_edge(clk)) then
		    if start = '1' and isRunning = false then
					isRunning := true;
					keys := GenerateKeySchedules(Key, mode);
					if isDecrypting = false then
						counter := 0;
					else
						case mode is
							when aes128 =>
								counter := 10;
							when aes192 =>
								counter := 12;
						 when aes256 =>
								counter := 14;
						end case;
					end if;
		    end if;
				if isRunning and (waitfor1clk = false) then
						Key_I <= keys(counter);
						if isDecrypting = false then
					    counter := counter + 1;
		  	      case mode is
		  	      	when aes128 =>
		  	      	  if counter > 10 then
		  	      	    isRunning := false;
		  	      	  end if;
		  	      	when aes192 =>
		  	      	  if counter > 12 then
		  	      		  isRunning := false;
		  	      	  end if;
		  	      	when aes256 =>
		  	      	  if counter > 14 then
		  	      		  isRunning := false;
		  	      	  end if;
							end case;
						else
							counter := counter - 1;
							if counter < 0 then
								isRunning := false;
							end if;
						end if;
		  	    if isRunning = false then
		  	      counter := 0;
		  	    end if;
						waitfor1clk := true;
  	    elsif(waitfor1clk) then
  	      waitfor1clk := false;
  	    end if;	
       end if; 
    end process;
END ExpandKeys_architecture;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity core_controller is

	port(
	clk 	: in std_logic;
	nrst 	: in std_logic;

	start_core	: in std_logic;
	key_l			: in std_logic_vector(1 downto 0);

	load_input	: out std_logic;
	load_output : out std_logic;
	load_loop	: out std_logic;
	load_key		: out std_logic;

	mux_s			: out std_logic;
	last_round 	: out std_logic;
	addKeyOnly	: out std_logic
	);


end entity;

architecture sim of core_controller is
	type t_state is(WaitStart, FirstEncrypt0, FirstEncrypt1, normalEncrypt0
	,normalEncrypt1, LastEncrypt0, LastEncrypt1);
	type boolean is (false,true);

	signal State : t_state;

begin
	process(clk,nrst) is
	
	variable nRounds 	: integer range 0 to 12; -- number of NORMALrounds to loop
	variable cRounds 	: integer range 0 to 12; -- number of NORMALrounds that have been looped
	
	begin
		if nrst = '0' then
			load_input	<= '0';
			load_output <= '0';
			load_loop	<= '0';
			load_key		<= '0';
			
			mux_s <= '0';
			last_round <= '0';
			addKeyOnly <= '0';
			
			nRounds := 0;
			cRounds := 0;

		elsif rising_edge(clk) then
		
		case State is
			when WaitStart =>
				-- everything off	
				load_input	<= '0';
				load_output <= '0';
				load_loop	<= '0';
				load_key		<= '0';
				
				mux_s <= '0';
				last_round <= '0';
				
				nRounds := 0;
				cRounds := 0;
				
				if start_core = '1' then
				State <= FirstEncrypt0;	
				end if;
		
			when FirstEncrypt0 =>
			State <= FirstEncrypt1;
				
				case key_l is
				when "00" =>
					nRounds := 8;
				when "01" =>
					nRounds := 10; 
				when "10" =>
					nRounds := 12; 
				when others => 
					nRounds := 0; --do nothing/reserved	
					State <= WaitStart;
				end case;
				
				load_input <= '1';
				load_key <= '1';
				addKeyOnly <= '1';
		
			when FirstEncrypt1	=>
				State <= normalEncrypt0;
				
				load_input <= '0';
				load_key <= '0';
				load_loop <= '1';
				addKeyOnly <= '1';
				
			when normalEncrypt0 =>
				State <= normalEncrypt1;
				
				mux_s <= '1';
				load_key <= '1';
				load_loop <= '0';
				addKeyOnly <= '0';
				
			when normalEncrypt1 =>
				State <= normalEncrypt0;
				
				load_key <= '0';
				load_loop <= '1';
				
				cRounds := cRounds + 1;
				
				if (cRounds > nRounds) then
				State <= LastEncrypt0;
				end if;
				
			when LastEncrypt0 => 
				State <= LastEncrypt1;
				
				last_round <= '1';
				
				load_key <= '1';
				load_loop <= '0';
				
			when LastEncrypt1 =>
				State <= WaitStart;
				
				load_key <= '0';
				load_loop <= '1';
				load_output <= '1';
			
			when others => 
				State <= WaitStart;-- loop back to start.
			
		end case;

		end if;


	end process;

end architecture;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

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

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY SubstituteBox IS 
	PORT
	(
		s_in :  IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
		s_out :  OUT  STD_LOGIC_VECTOR(127 DOWNTO 0)
	);
END SubstituteBox;

ARCHITECTURE bdf_type OF SubstituteBox IS 

COMPONENT s_box
	PORT(A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 B : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	s_out_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(127 DOWNTO 0);


BEGIN 



b2v_inst : s_box
PORT MAP(A => s_in(7 DOWNTO 0),
		 B => s_out_ALTERA_SYNTHESIZED(7 DOWNTO 0));


b2v_inst10 : s_box
PORT MAP(A => s_in(95 DOWNTO 88),
		 B => s_out_ALTERA_SYNTHESIZED(95 DOWNTO 88));


b2v_inst11 : s_box
PORT MAP(A => s_in(111 DOWNTO 104),
		 B => s_out_ALTERA_SYNTHESIZED(111 DOWNTO 104));


b2v_inst12 : s_box
PORT MAP(A => s_in(119 DOWNTO 112),
		 B => s_out_ALTERA_SYNTHESIZED(119 DOWNTO 112));


b2v_inst13 : s_box
PORT MAP(A => s_in(127 DOWNTO 120),
		 B => s_out_ALTERA_SYNTHESIZED(127 DOWNTO 120));


b2v_inst18 : s_box
PORT MAP(A => s_in(39 DOWNTO 32),
		 B => s_out_ALTERA_SYNTHESIZED(39 DOWNTO 32));


b2v_inst19 : s_box
PORT MAP(A => s_in(71 DOWNTO 64),
		 B => s_out_ALTERA_SYNTHESIZED(71 DOWNTO 64));


b2v_inst2 : s_box
PORT MAP(A => s_in(15 DOWNTO 8),
		 B => s_out_ALTERA_SYNTHESIZED(15 DOWNTO 8));


b2v_inst20 : s_box
PORT MAP(A => s_in(103 DOWNTO 96),
		 B => s_out_ALTERA_SYNTHESIZED(103 DOWNTO 96));


b2v_inst3 : s_box
PORT MAP(A => s_in(23 DOWNTO 16),
		 B => s_out_ALTERA_SYNTHESIZED(23 DOWNTO 16));


b2v_inst4 : s_box
PORT MAP(A => s_in(31 DOWNTO 24),
		 B => s_out_ALTERA_SYNTHESIZED(31 DOWNTO 24));


b2v_inst5 : s_box
PORT MAP(A => s_in(47 DOWNTO 40),
		 B => s_out_ALTERA_SYNTHESIZED(47 DOWNTO 40));


b2v_inst6 : s_box
PORT MAP(A => s_in(55 DOWNTO 48),
		 B => s_out_ALTERA_SYNTHESIZED(55 DOWNTO 48));


b2v_inst7 : s_box
PORT MAP(A => s_in(63 DOWNTO 56),
		 B => s_out_ALTERA_SYNTHESIZED(63 DOWNTO 56));


b2v_inst8 : s_box
PORT MAP(A => s_in(79 DOWNTO 72),
		 B => s_out_ALTERA_SYNTHESIZED(79 DOWNTO 72));


b2v_inst9 : s_box
PORT MAP(A => s_in(87 DOWNTO 80),
		 B => s_out_ALTERA_SYNTHESIZED(87 DOWNTO 80));

s_out <= s_out_ALTERA_SYNTHESIZED;

END bdf_type;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY S_Box IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(
		A : IN STD_LOGIC_VECTOR(7 downto 0);
		B : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

END S_Box;


--  Architecture Body

ARCHITECTURE S_Box_architecture OF S_Box IS

BEGIN
		process(A)
		--variable declaration
		variable MSB_Nibble : std_logic_vector (3 DOWNTO 0);
		variable LSB_Nibble : std_logic_vector (3 DOWNTO 0);
		
		begin
		MSB_Nibble := A(7 downto 4);
		LSB_Nibble := A(3 downto 0);
		
		case MSB_Nibble is --determine row
		
		when X"0" => 
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"63";
		when X"1" => B <= X"7C";
		when X"2" => B <= X"77";
		when X"3" => B <= X"7B";
		when X"4" => B <= X"F2";
		when X"5" => B <= X"6B";
		when X"6" => B <= X"6F";
		when X"7" => B <= X"C5";
		when X"8" => B <= X"30";
		when X"9" => B <= X"01";
		when X"A" => B <= X"67";
		when X"B" => B <= X"2B";
		when X"C" => B <= X"FE";
		when X"D" => B <= X"D7";
		when X"E" => B <= X"AB";
		when X"F" => B <= X"76";
		when others => B <= "--------";
		end case;
		
		when X"1" =>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"CA";
		when X"1" => B <= X"82";
		when X"2" => B <= X"C9";
		when X"3" => B <= X"7D";
		when X"4" => B <= X"FA";
		when X"5" => B <= X"59";
		when X"6" => B <= X"47";
		when X"7" => B <= X"F0";
		when X"8" => B <= X"AD";
		when X"9" => B <= X"D4";
		when X"A" => B <= X"A2";
		when X"B" => B <= X"AF";
		when X"C" => B <= X"9C";
		when X"D" => B <= X"A4";
		when X"E" => B <= X"72";
		when X"F" => B <= X"C0";
		when others => B <= "--------";
		end case;		

		when X"2" =>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"B7";
		when X"1" => B <= X"FD";
		when X"2" => B <= X"93";
		when X"3" => B <= X"26";
		when X"4" => B <= X"36";
		when X"5" => B <= X"3F";
		when X"6" => B <= X"F7";
		when X"7" => B <= X"CC";
		when X"8" => B <= X"34";
		when X"9" => B <= X"A5";
		when X"A" => B <= X"E5";
		when X"B" => B <= X"F1";
		when X"C" => B <= X"71";
		when X"D" => B <= X"D8";
		when X"E" => B <= X"31";
		when X"F" => B <= X"15";
		when others => B <= "--------";
		end case;

		when X"3"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"04";
		when X"1" => B <= X"C7";
		when X"2" => B <= X"23";
		when X"3" => B <= X"C3";
		when X"4" => B <= X"18";
		when X"5" => B <= X"96";
		when X"6" => B <= X"05";
		when X"7" => B <= X"9A";
		when X"8" => B <= X"07";
		when X"9" => B <= X"12";
		when X"A" => B <= X"80";
		when X"B" => B <= X"E2";
		when X"C" => B <= X"EB";
		when X"D" => B <= X"27";
		when X"E" => B <= X"B2";
		when X"F" => B <= X"75";
		when others => B <= "--------";
		end case;
		
		when X"4"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"09";
		when X"1" => B <= X"83";
		when X"2" => B <= X"2C";
		when X"3" => B <= X"1A";
		when X"4" => B <= X"1B";
		when X"5" => B <= X"6E";
		when X"6" => B <= X"5A";
		when X"7" => B <= X"A0";
		when X"8" => B <= X"52";
		when X"9" => B <= X"3B";
		when X"A" => B <= X"D6";
		when X"B" => B <= X"B3";
		when X"C" => B <= X"29";
		when X"D" => B <= X"E3";
		when X"E" => B <= X"2F";
		when X"F" => B <= X"84";
		when others => B <= "--------";
		end case;
		
		when X"5"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"53";
		when X"1" => B <= X"D1";
		when X"2" => B <= X"00";
		when X"3" => B <= X"ED";
		when X"4" => B <= X"20";
		when X"5" => B <= X"FC";
		when X"6" => B <= X"B1";
		when X"7" => B <= X"5B";
		when X"8" => B <= X"6A";
		when X"9" => B <= X"CB";
		when X"A" => B <= X"BE";
		when X"B" => B <= X"39";
		when X"C" => B <= X"4A";
		when X"D" => B <= X"4C";
		when X"E" => B <= X"58";
		when X"F" => B <= X"CF";
		when others => B <= "--------";
		end case;
		
		when X"6"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"D0";
		when X"1" => B <= X"EF";
		when X"2" => B <= X"AA";
		when X"3" => B <= X"FB";
		when X"4" => B <= X"43";
		when X"5" => B <= X"4D";
		when X"6" => B <= X"33";
		when X"7" => B <= X"85";
		when X"8" => B <= X"45";
		when X"9" => B <= X"F9";
		when X"A" => B <= X"02";
		when X"B" => B <= X"7F";
		when X"C" => B <= X"50";
		when X"D" => B <= X"3C";
		when X"E" => B <= X"9F";
		when X"F" => B <= X"A8";
		when others => B <= "--------";
		end case;
		
		when X"7"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"51";
		when X"1" => B <= X"A3";
		when X"2" => B <= X"40";
		when X"3" => B <= X"8F";
		when X"4" => B <= X"92";
		when X"5" => B <= X"9D";
		when X"6" => B <= X"38";
		when X"7" => B <= X"F5";
		when X"8" => B <= X"BC";
		when X"9" => B <= X"B6";
		when X"A" => B <= X"DA";
		when X"B" => B <= X"21";
		when X"C" => B <= X"10";
		when X"D" => B <= X"FF";
		when X"E" => B <= X"F3";
		when X"F" => B <= X"D2";
		when others => B <= "--------";
		end case;
		
		when X"8"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"CD";
		when X"1" => B <= X"0C";
		when X"2" => B <= X"13";
		when X"3" => B <= X"EC";
		when X"4" => B <= X"5F";
		when X"5" => B <= X"97";
		when X"6" => B <= X"44";
		when X"7" => B <= X"17";
		when X"8" => B <= X"C4";
		when X"9" => B <= X"A7";
		when X"A" => B <= X"7E";
		when X"B" => B <= X"3D";
		when X"C" => B <= X"64";
		when X"D" => B <= X"5D";
		when X"E" => B <= X"19";
		when X"F" => B <= X"73";
		when others => B <= "--------";
		end case;
		
		when X"9"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"60";
		when X"1" => B <= X"81";
		when X"2" => B <= X"4F";
		when X"3" => B <= X"DC";
		when X"4" => B <= X"22";
		when X"5" => B <= X"2A";
		when X"6" => B <= X"90";
		when X"7" => B <= X"88";
		when X"8" => B <= X"46";
		when X"9" => B <= X"EE";
		when X"A" => B <= X"B8";
		when X"B" => B <= X"14";
		when X"C" => B <= X"DE";
		when X"D" => B <= X"5E";
		when X"E" => B <= X"0B";
		when X"F" => B <= X"DB";
		when others => B <= "--------";
		end case;
		
		when X"A"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"E0";
		when X"1" => B <= X"32";
		when X"2" => B <= X"3A";
		when X"3" => B <= X"0A";
		when X"4" => B <= X"49";
		when X"5" => B <= X"06";
		when X"6" => B <= X"24";
		when X"7" => B <= X"5C";
		when X"8" => B <= X"C2";
		when X"9" => B <= X"D3";
		when X"A" => B <= X"AC";
		when X"B" => B <= X"62";
		when X"C" => B <= X"91";
		when X"D" => B <= X"95";
		when X"E" => B <= X"E4";
		when X"F" => B <= X"79";
		when others => B <= "--------";
		end case;
		
		when X"B"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"E7";
		when X"1" => B <= X"C8";
		when X"2" => B <= X"37";
		when X"3" => B <= X"6D";
		when X"4" => B <= X"8D";
		when X"5" => B <= X"D5";
		when X"6" => B <= X"4E";
		when X"7" => B <= X"A9";
		when X"8" => B <= X"6C";
		when X"9" => B <= X"56";
		when X"A" => B <= X"F4";
		when X"B" => B <= X"EA";
		when X"C" => B <= X"65";
		when X"D" => B <= X"7A";
		when X"E" => B <= X"AE";
		when X"F" => B <= X"08";
		when others => B <= "--------";
		end case;
		
		when X"C"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"BA";
		when X"1" => B <= X"78";
		when X"2" => B <= X"25";
		when X"3" => B <= X"2E";
		when X"4" => B <= X"1C";
		when X"5" => B <= X"A6";
		when X"6" => B <= X"B4";
		when X"7" => B <= X"C6";
		when X"8" => B <= X"E8";
		when X"9" => B <= X"DD";
		when X"A" => B <= X"74";
		when X"B" => B <= X"1F";
		when X"C" => B <= X"4B";
		when X"D" => B <= X"BD";
		when X"E" => B <= X"8B";
		when X"F" => B <= X"8A";
		when others => B <= "--------";
		end case;
		
		when X"D"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"70";
		when X"1" => B <= X"3E";
		when X"2" => B <= X"B5";
		when X"3" => B <= X"66";
		when X"4" => B <= X"48";
		when X"5" => B <= X"03";
		when X"6" => B <= X"F6";
		when X"7" => B <= X"0E";
		when X"8" => B <= X"61";
		when X"9" => B <= X"35";
		when X"A" => B <= X"57";
		when X"B" => B <= X"B9";
		when X"C" => B <= X"86";
		when X"D" => B <= X"C1";
		when X"E" => B <= X"1D";
		when X"F" => B <= X"9E";
		when others => B <= "--------";
		end case;
		
		when X"E"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"E1";
		when X"1" => B <= X"F8";
		when X"2" => B <= X"98";
		when X"3" => B <= X"11";
		when X"4" => B <= X"69";
		when X"5" => B <= X"D9";
		when X"6" => B <= X"8E";
		when X"7" => B <= X"94";
		when X"8" => B <= X"9B";
		when X"9" => B <= X"1E";
		when X"A" => B <= X"87";
		when X"B" => B <= X"E9";
		when X"C" => B <= X"CE";
		when X"D" => B <= X"55";
		when X"E" => B <= X"28";
		when X"F" => B <= X"DF";
		when others => B <= "--------";
		end case;
		
		when X"F"=>
		case LSB_Nibble is --determinte column
		when X"0" => B <= X"8C";
		when X"1" => B <= X"A1";
		when X"2" => B <= X"89";
		when X"3" => B <= X"0D";
		when X"4" => B <= X"BF";
		when X"5" => B <= X"E6";
		when X"6" => B <= X"42";
		when X"7" => B <= X"68";
		when X"8" => B <= X"41";
		when X"9" => B <= X"99";
		when X"A" => B <= X"2D";
		when X"B" => B <= X"0F";
		when X"C" => B <= X"B0";
		when X"D" => B <= X"54";
		when X"E" => B <= X"BB";
		when X"F" => B <= X"16";
		when others => B <= "--------";
		end case;
		
		when others => B <= "--------";
		end case;
		
		end process;

END S_Box_architecture; 

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;


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

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

--  Entity Declaration
ENTITY remap_block IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(
		virtual_in : IN STD_LOGIC_VECTOR(7 downto 0);
		virtual_out : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

END remap_block;


ARCHITECTURE remap_block_architecture OF remap_block IS

BEGIN
	process(virtual_in)
	
	begin
	virtual_out <= virtual_in;
	end process;

END remap_block_architecture;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity Mux128B is
port(
  a1      : in  std_logic_vector(127 downto 0);
  a2      : in  std_logic_vector(127 downto 0);
  sel : in  std_logic;
  output       : out std_logic_vector(127 downto 0));
end Mux128B;

architecture rtl of Mux128B is

begin

p_mux : process(a1,a2,sel)
begin

if( sel = '1' ) then
output <= a1;


else
output <= a2; 

end if;

end process p_mux;

end rtl;


--  Entity Declaration
LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY MixColumns IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(
		mc_in : IN STD_LOGIC_VECTOR(127 downto 0);
		mc_out : OUT STD_LOGIC_VECTOR(127 downto 0)
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!

END MixColumns;

--  Architecture Body

ARCHITECTURE MixColumns_architecture OF MixColumns IS

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

MixDatBish : process(mc_in)
begin
--  for I in 16 downto 0 loop
--    mc_out(7+I*8 downto I*8) <= MIX_ONE_COLUMN(7+I*8 downto I*8);
--  end loop;
  mc_out <= MIX_ONE_COLUMN(mc_in(127 downto 96))
               & MIX_ONE_COLUMN(mc_in(95 downto 64))
					& MIX_ONE_COLUMN(mc_in(63 downto 32))
					& MIX_ONE_COLUMN(mc_in(31 downto 0));
end process;

END MixColumns_architecture;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY KeyAdd IS
	-- {{ALTERA_IO_BEGIN}} DO NOT REMOVE THIS LINE!
	PORT
	(
		ki_in : IN STD_LOGIC_VECTOR(127 downto 0);
		ka_in : IN STD_LOGIC_VECTOR(127 downto 0);
		ka_out : OUT STD_LOGIC_VECTOR(127 downto 0)
	);
	-- {{ALTERA_IO_END}} DO NOT REMOVE THIS LINE!
END KeyAdd;

ARCHITECTURE KeyAdd_architecture OF KeyAdd IS


BEGIN

process(ka_in,ki_in)
begin

ka_out <= ki_in xor ka_in;

end process;

END KeyAdd_architecture;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

entity InverseSubstituteBox is
  port
  (
    data_in : in std_logic_vector(127 downto 0);
    data_out : out std_logic_Vector(127 downto 0)
  );
end InverseSubstituteBox;

architecture rtl of InverseSubstituteBox is
  function SBox(A : std_logic_vector(7 downto 0)) return std_logic_vector is
      variable MSB_Nibble : std_logic_vector (3 DOWNTO 0);
      variable LSB_Nibble : std_logic_vector (3 DOWNTO 0);
      variable B : std_logic_vector(7 downto 0);
      begin
        MSB_Nibble := A(7 downto 4);
        LSB_Nibble := A(3 downto 0);
        
        case MSB_Nibble is --determine row
    --   
          when X"0" => 
            case LSB_Nibble is --determine column
              when X"0" => B := X"52";
              when X"1" => B := X"09";
              when X"2" => B := X"6a";
              when X"3" => B := X"d5";
              when X"4" => B := X"30";
              when X"5" => B := X"36";
              when X"6" => B := X"a5";
              when X"7" => B := X"38";
              when X"8" => B := X"bf";
              when X"9" => B := X"40";
              when X"A" => B := X"a3";
              when X"B" => B := X"9e";
              when X"C" => B := X"81";
              when X"D" => B := X"f3";
              when X"E" => B := X"d7";
              when X"F" => B := X"fb";
              when others => B := "--------";
            end case;
        -- 
          when X"1" =>
            case LSB_Nibble is --determinte column
              when X"0" => B := X"7c";
              when X"1" => B := X"e3";
              when X"2" => B := X"39";
              when X"3" => B := X"82";
              when X"4" => B := X"9b";
              when X"5" => B := X"2f";
              when X"6" => B := X"ff";
              when X"7" => B := X"87";
              when X"8" => B := X"34";
              when X"9" => B := X"8e";
              when X"A" => B := X"43";
              when X"B" => B := X"44";
              when X"C" => B := X"c4";
              when X"D" => B := X"de";
              when X"E" => B := X"e9";
              when X"F" => B := X"cb";
              when others => B := "--------";
            end case;		
    --   
          when X"2" =>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"54";
            when X"1" => B := X"7b";
            when X"2" => B := X"94";
            when X"3" => B := X"32";
            when X"4" => B := X"a6";
            when X"5" => B := X"c2";
            when X"6" => B := X"23";
            when X"7" => B := X"3d";
            when X"8" => B := X"ee";
            when X"9" => B := X"4c";
            when X"A" => B := X"95";
            when X"B" => B := X"0b";
            when X"C" => B := X"42";
            when X"D" => B := X"fa";
            when X"E" => B := X"c3";
            when X"F" => B := X"4e";
            when others => B := "--------";
            end case;
    --   
          when X"3"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"08";
            when X"1" => B := X"2e";
            when X"2" => B := X"a1";
            when X"3" => B := X"66";
            when X"4" => B := X"28";
            when X"5" => B := X"d9";
            when X"6" => B := X"24";
            when X"7" => B := X"b2";
            when X"8" => B := X"76";
            when X"9" => B := X"5b";
            when X"A" => B := X"a2";
            when X"B" => B := X"49";
            when X"C" => B := X"6d";
            when X"D" => B := X"8b";
            when X"E" => B := X"d1";
            when X"F" => B := X"25";
            when others => B := "--------";
            end case;
        -- 
          when X"4"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"72";
            when X"1" => B := X"f8";
            when X"2" => B := X"f6";
            when X"3" => B := X"64";
            when X"4" => B := X"86";
            when X"5" => B := X"68";
            when X"6" => B := X"98";
            when X"7" => B := X"16";
            when X"8" => B := X"d4";
            when X"9" => B := X"a4";
            when X"A" => B := X"5c";
            when X"B" => B := X"cc";
            when X"C" => B := X"5d";
            when X"D" => B := X"65";
            when X"E" => B := X"b6";
            when X"F" => B := X"92";
            when others => B := "--------";
            end case;
        -- 
          when X"5"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"6c";
            when X"1" => B := X"70";
            when X"2" => B := X"48";
            when X"3" => B := X"50";
            when X"4" => B := X"fd";
            when X"5" => B := X"ed";
            when X"6" => B := X"b9";
            when X"7" => B := X"da";
            when X"8" => B := X"5e";
            when X"9" => B := X"15";
            when X"A" => B := X"46";
            when X"B" => B := X"57";
            when X"C" => B := X"a7";
            when X"D" => B := X"8d";
            when X"E" => B := X"9d";
            when X"F" => B := X"84";
            when others => B := "--------";
            end case;
        -- 
          when X"6"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"90";
            when X"1" => B := X"d8";
            when X"2" => B := X"ab";
            when X"3" => B := X"00";
            when X"4" => B := X"8c";
            when X"5" => B := X"bc";
            when X"6" => B := X"d3";
            when X"7" => B := X"0a";
            when X"8" => B := X"f7";
            when X"9" => B := X"e4";
            when X"A" => B := X"58";
            when X"B" => B := X"05";
            when X"C" => B := X"b8";
            when X"D" => B := X"b3";
            when X"E" => B := X"45";
            when X"F" => B := X"06";
            when others => B := "--------";
            end case;
        -- 
          when X"7"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"d0";
            when X"1" => B := X"2c";
            when X"2" => B := X"1e";
            when X"3" => B := X"8f";
            when X"4" => B := X"ca";
            when X"5" => B := X"3f";
            when X"6" => B := X"0f";
            when X"7" => B := X"02";
            when X"8" => B := X"c1";
            when X"9" => B := X"af";
            when X"A" => B := X"bd";
            when X"B" => B := X"03";
            when X"C" => B := X"01";
            when X"D" => B := X"13";
            when X"E" => B := X"8a";
            when X"F" => B := X"6b";
            when others => B := "--------";
            end case;
        -- 
          when X"8"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"3a";
            when X"1" => B := X"91";
            when X"2" => B := X"11";
            when X"3" => B := X"41";
            when X"4" => B := X"4f";
            when X"5" => B := X"67";
            when X"6" => B := X"dc";
            when X"7" => B := X"ea";
            when X"8" => B := X"97";
            when X"9" => B := X"f2";
            when X"A" => B := X"cf";
            when X"B" => B := X"ce";
            when X"C" => B := X"f0";
            when X"D" => B := X"b4";
            when X"E" => B := X"e6";
            when X"F" => B := X"73";
            when others => B := "--------";
            end case;
        -- 
          when X"9"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"96";
            when X"1" => B := X"ac";
            when X"2" => B := X"74";
            when X"3" => B := X"22";
            when X"4" => B := X"e7";
            when X"5" => B := X"ad";
            when X"6" => B := X"35";
            when X"7" => B := X"85";
            when X"8" => B := X"e2";
            when X"9" => B := X"f9";
            when X"A" => B := X"37";
            when X"B" => B := X"e8";
            when X"C" => B := X"1c";
            when X"D" => B := X"75";
            when X"E" => B := X"df";
            when X"F" => B := X"6e";
            when others => B := "--------";
            end case;
        -- 
          when X"A"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"47";
            when X"1" => B := X"f1";
            when X"2" => B := X"1a";
            when X"3" => B := X"71";
            when X"4" => B := X"1d";
            when X"5" => B := X"29";
            when X"6" => B := X"c5";
            when X"7" => B := X"89";
            when X"8" => B := X"6f";
            when X"9" => B := X"b7";
            when X"A" => B := X"62";
            when X"B" => B := X"0e";
            when X"C" => B := X"aa";
            when X"D" => B := X"18";
            when X"E" => B := X"be";
            when X"F" => B := X"1b";
            when others => B := "--------";
            end case;
        -- 
          when X"B"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"fc";
            when X"1" => B := X"56";
            when X"2" => B := X"3e";
            when X"3" => B := X"4b";
            when X"4" => B := X"c6";
            when X"5" => B := X"d2";
            when X"6" => B := X"79";
            when X"7" => B := X"20";
            when X"8" => B := X"9a";
            when X"9" => B := X"db";
            when X"A" => B := X"c0";
            when X"B" => B := X"fe";
            when X"C" => B := X"78";
            when X"D" => B := X"cd";
            when X"E" => B := X"5a";
            when X"F" => B := X"f4";
            when others => B := "--------";
            end case;
        -- 
          when X"C"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"1f";
            when X"1" => B := X"dd";
            when X"2" => B := X"a8";
            when X"3" => B := X"33";
            when X"4" => B := X"88";
            when X"5" => B := X"07";
            when X"6" => B := X"c7";
            when X"7" => B := X"31";
            when X"8" => B := X"b1";
            when X"9" => B := X"12";
            when X"A" => B := X"10";
            when X"B" => B := X"59";
            when X"C" => B := X"27";
            when X"D" => B := X"80";
            when X"E" => B := X"ec";
            when X"F" => B := X"5f";
            when others => B := "--------";
            end case;
        -- 
          when X"D"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"60";
            when X"1" => B := X"51";
            when X"2" => B := X"7f";
            when X"3" => B := X"a9";
            when X"4" => B := X"19";
            when X"5" => B := X"b5";
            when X"6" => B := X"4a";
            when X"7" => B := X"0d";
            when X"8" => B := X"2d";
            when X"9" => B := X"e5";
            when X"A" => B := X"7a";
            when X"B" => B := X"9f";
            when X"C" => B := X"93";
            when X"D" => B := X"c9";
            when X"E" => B := X"9c";
            when X"F" => B := X"ef";
            when others => B := "--------";
            end case;
        -- 
          when X"E"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"a0";
            when X"1" => B := X"e0";
            when X"2" => B := X"3b";
            when X"3" => B := X"4d";
            when X"4" => B := X"ae";
            when X"5" => B := X"2a";
            when X"6" => B := X"f5";
            when X"7" => B := X"b0";
            when X"8" => B := X"c8";
            when X"9" => B := X"eb";
            when X"A" => B := X"bb";
            when X"B" => B := X"3c";
            when X"C" => B := X"83";
            when X"D" => B := X"53";
            when X"E" => B := X"99";
            when X"F" => B := X"61";
            when others => B := "--------";
            end case;
        -- 
          when X"F"=>
            case LSB_Nibble is --determinte column
            when X"0" => B := X"17";
            when X"1" => B := X"2b";
            when X"2" => B := X"04";
            when X"3" => B := X"7e";
            when X"4" => B := X"ba";
            when X"5" => B := X"77";
            when X"6" => B := X"d6";
            when X"7" => B := X"26";
            when X"8" => B := X"e1";
            when X"9" => B := X"69";
            when X"A" => B := X"14";
            when X"B" => B := X"63";
            when X"C" => B := X"55";
            when X"D" => B := X"21";
            when X"E" => B := X"0c";
            when X"F" => B := X"7d";
            when others => B := "--------";
          end case;
        --   
          when others => B := "--------";
        end case;
        return B;
  end function SBox;
  begin
    process(data_in)
      begin
        data_out(7 downto 0)     <= SBox(data_in(7   downto 0) )   ;
        data_out(15 downto 8)    <= SBox(data_in(15  downto 8) )  ;
        data_out(23 downto 16)   <= SBox(data_in(23  downto 16))  ;
        data_out(31 downto 24)   <= SBox(data_in(31  downto 24))  ;
        data_out(39 downto 32)   <= SBox(data_in(39  downto 32))  ;
        data_out(47 downto 40)   <= SBox(data_in(47  downto 40))  ;
        data_out(55 downto 48)   <= SBox(data_in(55  downto 48))  ;
        data_out(63 downto 56)   <= SBox(data_in(63  downto 56))  ;
        data_out(71 downto 64)   <= SBox(data_in(71  downto 64))  ;
        data_out(79 downto 72)   <= SBox(data_in(79  downto 72))  ;
        data_out(87 downto 80)   <= SBox(data_in(87  downto 80))  ;
        data_out(95 downto 88)   <= SBox(data_in(95  downto 88))  ;
        data_out(103 downto 96)  <= SBox(data_in(103 downto 96)) ;
        data_out(111 downto 104) <= SBox(data_in(111 downto 104));
        data_out(119 downto 112) <= SBox(data_in(119 downto 112));
        data_out(127 downto 120) <= SBox(data_in(127 downto 120));
    end process;
end rtl;

LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

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

-- Created on Fri Dec 21 12:10:48 2018
LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

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