library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AES_AXI_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI_AES
		C_S00_AXI_AES_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_AES_ADDR_WIDTH	: integer	:= 6;

		-- Parameters of Axi Master Bus Interface M00_AXI_DATA0
		C_M00_AXI_DATA0_START_DATA_VALUE	: std_logic_vector	:= x"AA000000";
		C_M00_AXI_DATA0_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M00_AXI_DATA0_ADDR_WIDTH	: integer	:= 32;
		C_M00_AXI_DATA0_DATA_WIDTH	: integer	:= 32;
		C_M00_AXI_DATA0_TRANSACTIONS_NUM	: integer	:= 4;

		-- Parameters of Axi Master Bus Interface M01_AXI_DATA1
		C_M01_AXI_DATA1_START_DATA_VALUE	: std_logic_vector	:= x"AA000000";
		C_M01_AXI_DATA1_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M01_AXI_DATA1_ADDR_WIDTH	: integer	:= 32;
		C_M01_AXI_DATA1_DATA_WIDTH	: integer	:= 32;
		C_M01_AXI_DATA1_TRANSACTIONS_NUM	: integer	:= 4;

		-- Parameters of Axi Master Bus Interface M02_AXI_READY
		C_M02_AXI_READY_START_DATA_VALUE	: std_logic_vector	:= x"AA000000";
		C_M02_AXI_READY_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M02_AXI_READY_ADDR_WIDTH	: integer	:= 32;
		C_M02_AXI_READY_DATA_WIDTH	: integer	:= 32;
		C_M02_AXI_READY_TRANSACTIONS_NUM	: integer	:= 4
	);  
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI_AES
		s00_axi_aes_aclk	: in std_logic;
		s00_axi_aes_aresetn	: in std_logic;
		s00_axi_aes_awaddr	: in std_logic_vector(C_S00_AXI_AES_ADDR_WIDTH-1 downto 0);
		s00_axi_aes_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_aes_awvalid	: in std_logic;
		s00_axi_aes_awready	: out std_logic;
		s00_axi_aes_wdata	: in std_logic_vector(C_S00_AXI_AES_DATA_WIDTH-1 downto 0);
		s00_axi_aes_wstrb	: in std_logic_vector((C_S00_AXI_AES_DATA_WIDTH/8)-1 downto 0);
		s00_axi_aes_wvalid	: in std_logic;
		s00_axi_aes_wready	: out std_logic;
		s00_axi_aes_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_aes_bvalid	: out std_logic;
		s00_axi_aes_bready	: in std_logic;
		s00_axi_aes_araddr	: in std_logic_vector(C_S00_AXI_AES_ADDR_WIDTH-1 downto 0);
		s00_axi_aes_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_aes_arvalid	: in std_logic;
		s00_axi_aes_arready	: out std_logic;
		s00_axi_aes_rdata	: out std_logic_vector(C_S00_AXI_AES_DATA_WIDTH-1 downto 0);
		s00_axi_aes_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_aes_rvalid	: out std_logic;
		s00_axi_aes_rready	: in std_logic;

		-- Ports of Axi Master Bus Interface M00_AXI_DATA0
		m00_axi_data0_init_axi_txn	: in std_logic;
		m00_axi_data0_error	: out std_logic;
		m00_axi_data0_txn_done	: out std_logic;
		m00_axi_data0_aclk	: in std_logic;
		m00_axi_data0_aresetn	: in std_logic;
		m00_axi_data0_awaddr	: out std_logic_vector(C_M00_AXI_DATA0_ADDR_WIDTH-1 downto 0);
		m00_axi_data0_awprot	: out std_logic_vector(2 downto 0);
		m00_axi_data0_awvalid	: out std_logic;
		m00_axi_data0_awready	: in std_logic;
		m00_axi_data0_wdata	: out std_logic_vector(C_M00_AXI_DATA0_DATA_WIDTH-1 downto 0);
		m00_axi_data0_wstrb	: out std_logic_vector(C_M00_AXI_DATA0_DATA_WIDTH/8-1 downto 0);
		m00_axi_data0_wvalid	: out std_logic;
		m00_axi_data0_wready	: in std_logic;
		m00_axi_data0_bresp	: in std_logic_vector(1 downto 0);
		m00_axi_data0_bvalid	: in std_logic;
		m00_axi_data0_bready	: out std_logic;
		m00_axi_data0_araddr	: out std_logic_vector(C_M00_AXI_DATA0_ADDR_WIDTH-1 downto 0);
		m00_axi_data0_arprot	: out std_logic_vector(2 downto 0);
		m00_axi_data0_arvalid	: out std_logic;
		m00_axi_data0_arready	: in std_logic;
		m00_axi_data0_rdata	: in std_logic_vector(C_M00_AXI_DATA0_DATA_WIDTH-1 downto 0);
		m00_axi_data0_rresp	: in std_logic_vector(1 downto 0);
		m00_axi_data0_rvalid	: in std_logic;
		m00_axi_data0_rready	: out std_logic;

		-- Ports of Axi Master Bus Interface M01_AXI_DATA1
		m01_axi_data1_init_axi_txn	: in std_logic;
		m01_axi_data1_error	: out std_logic;
		m01_axi_data1_txn_done	: out std_logic;
		m01_axi_data1_aclk	: in std_logic;
		m01_axi_data1_aresetn	: in std_logic;
		m01_axi_data1_awaddr	: out std_logic_vector(C_M01_AXI_DATA1_ADDR_WIDTH-1 downto 0);
		m01_axi_data1_awprot	: out std_logic_vector(2 downto 0);
		m01_axi_data1_awvalid	: out std_logic;
		m01_axi_data1_awready	: in std_logic;
		m01_axi_data1_wdata	: out std_logic_vector(C_M01_AXI_DATA1_DATA_WIDTH-1 downto 0);
		m01_axi_data1_wstrb	: out std_logic_vector(C_M01_AXI_DATA1_DATA_WIDTH/8-1 downto 0);
		m01_axi_data1_wvalid	: out std_logic;
		m01_axi_data1_wready	: in std_logic;
		m01_axi_data1_bresp	: in std_logic_vector(1 downto 0);
		m01_axi_data1_bvalid	: in std_logic;
		m01_axi_data1_bready	: out std_logic;
		m01_axi_data1_araddr	: out std_logic_vector(C_M01_AXI_DATA1_ADDR_WIDTH-1 downto 0);
		m01_axi_data1_arprot	: out std_logic_vector(2 downto 0);
		m01_axi_data1_arvalid	: out std_logic;
		m01_axi_data1_arready	: in std_logic;
		m01_axi_data1_rdata	: in std_logic_vector(C_M01_AXI_DATA1_DATA_WIDTH-1 downto 0);
		m01_axi_data1_rresp	: in std_logic_vector(1 downto 0);
		m01_axi_data1_rvalid	: in std_logic;
		m01_axi_data1_rready	: out std_logic;

		-- Ports of Axi Master Bus Interface M02_AXI_READY
		m02_axi_ready_init_axi_txn	: in std_logic;
		m02_axi_ready_error	: out std_logic;
		m02_axi_ready_txn_done	: out std_logic;
		m02_axi_ready_aclk	: in std_logic;
		m02_axi_ready_aresetn	: in std_logic;
		m02_axi_ready_awaddr	: out std_logic_vector(C_M02_AXI_READY_ADDR_WIDTH-1 downto 0);
		m02_axi_ready_awprot	: out std_logic_vector(2 downto 0);
		m02_axi_ready_awvalid	: out std_logic;
		m02_axi_ready_awready	: in std_logic;
		m02_axi_ready_wdata	: out std_logic_vector(C_M02_AXI_READY_DATA_WIDTH-1 downto 0);
		m02_axi_ready_wstrb	: out std_logic_vector(C_M02_AXI_READY_DATA_WIDTH/8-1 downto 0);
		m02_axi_ready_wvalid	: out std_logic;
		m02_axi_ready_wready	: in std_logic;
		m02_axi_ready_bresp	: in std_logic_vector(1 downto 0);
		m02_axi_ready_bvalid	: in std_logic;
		m02_axi_ready_bready	: out std_logic;
		m02_axi_ready_araddr	: out std_logic_vector(C_M02_AXI_READY_ADDR_WIDTH-1 downto 0);
		m02_axi_ready_arprot	: out std_logic_vector(2 downto 0);
		m02_axi_ready_arvalid	: out std_logic;
		m02_axi_ready_arready	: in std_logic;
		m02_axi_ready_rdata	: in std_logic_vector(C_M02_AXI_READY_DATA_WIDTH-1 downto 0);
		m02_axi_ready_rresp	: in std_logic_vector(1 downto 0);
		m02_axi_ready_rvalid	: in std_logic;
		m02_axi_ready_rready	: out std_logic
	);
end AES_AXI_v1_0;

architecture arch_imp of AES_AXI_v1_0 is

	-- component declaration
	component AES_AXI_v1_0_S00_AXI_AES is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 6
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component AES_AXI_v1_0_S00_AXI_AES;

	component AES_AXI_v1_0_M00_AXI_DATA0 is
		generic (
		C_M_START_DATA_VALUE	: std_logic_vector	:= x"AA000000";
		C_M_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M_AXI_ADDR_WIDTH	: integer	:= 32;
		C_M_AXI_DATA_WIDTH	: integer	:= 32;
		C_M_TRANSACTIONS_NUM	: integer	:= 4
		);
		port (
		INIT_AXI_TXN	: in std_logic;
		ERROR	: out std_logic;
		TXN_DONE	: out std_logic;
		M_AXI_ACLK	: in std_logic;
		M_AXI_ARESETN	: in std_logic;
		M_AXI_AWADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_AWPROT	: out std_logic_vector(2 downto 0);
		M_AXI_AWVALID	: out std_logic;
		M_AXI_AWREADY	: in std_logic;
		M_AXI_WDATA	: out std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_WSTRB	: out std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
		M_AXI_WVALID	: out std_logic;
		M_AXI_WREADY	: in std_logic;
		M_AXI_BRESP	: in std_logic_vector(1 downto 0);
		M_AXI_BVALID	: in std_logic;
		M_AXI_BREADY	: out std_logic;
		M_AXI_ARADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_ARPROT	: out std_logic_vector(2 downto 0);
		M_AXI_ARVALID	: out std_logic;
		M_AXI_ARREADY	: in std_logic;
		M_AXI_RDATA	: in std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_RRESP	: in std_logic_vector(1 downto 0);
		M_AXI_RVALID	: in std_logic;
		M_AXI_RREADY	: out std_logic
		);
	end component AES_AXI_v1_0_M00_AXI_DATA0;

	component AES_AXI_v1_0_M01_AXI_DATA1 is
		generic (
		C_M_START_DATA_VALUE	: std_logic_vector	:= x"AA000000";
		C_M_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M_AXI_ADDR_WIDTH	: integer	:= 32;
		C_M_AXI_DATA_WIDTH	: integer	:= 32;
		C_M_TRANSACTIONS_NUM	: integer	:= 4
		);
		port (
		INIT_AXI_TXN	: in std_logic;
		ERROR	: out std_logic;
		TXN_DONE	: out std_logic;
		M_AXI_ACLK	: in std_logic;
		M_AXI_ARESETN	: in std_logic;
		M_AXI_AWADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_AWPROT	: out std_logic_vector(2 downto 0);
		M_AXI_AWVALID	: out std_logic;
		M_AXI_AWREADY	: in std_logic;
		M_AXI_WDATA	: out std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_WSTRB	: out std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
		M_AXI_WVALID	: out std_logic;
		M_AXI_WREADY	: in std_logic;
		M_AXI_BRESP	: in std_logic_vector(1 downto 0);
		M_AXI_BVALID	: in std_logic;
		M_AXI_BREADY	: out std_logic;
		M_AXI_ARADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_ARPROT	: out std_logic_vector(2 downto 0);
		M_AXI_ARVALID	: out std_logic;
		M_AXI_ARREADY	: in std_logic;
		M_AXI_RDATA	: in std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_RRESP	: in std_logic_vector(1 downto 0);
		M_AXI_RVALID	: in std_logic;
		M_AXI_RREADY	: out std_logic
		);
	end component AES_AXI_v1_0_M01_AXI_DATA1;

	component AES_AXI_v1_0_M02_AXI_READY is
		generic (
		C_M_START_DATA_VALUE	: std_logic_vector	:= x"AA000000";
		C_M_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M_AXI_ADDR_WIDTH	: integer	:= 32;
		C_M_AXI_DATA_WIDTH	: integer	:= 32;
		C_M_TRANSACTIONS_NUM	: integer	:= 4
		);
		port (
		INIT_AXI_TXN	: in std_logic;
		ERROR	: out std_logic;
		TXN_DONE	: out std_logic;
		M_AXI_ACLK	: in std_logic;
		M_AXI_ARESETN	: in std_logic;
		M_AXI_AWADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_AWPROT	: out std_logic_vector(2 downto 0);
		M_AXI_AWVALID	: out std_logic;
		M_AXI_AWREADY	: in std_logic;
		M_AXI_WDATA	: out std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_WSTRB	: out std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
		M_AXI_WVALID	: out std_logic;
		M_AXI_WREADY	: in std_logic;
		M_AXI_BRESP	: in std_logic_vector(1 downto 0);
		M_AXI_BVALID	: in std_logic;
		M_AXI_BREADY	: out std_logic;
		M_AXI_ARADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_ARPROT	: out std_logic_vector(2 downto 0);
		M_AXI_ARVALID	: out std_logic;
		M_AXI_ARREADY	: in std_logic;
		M_AXI_RDATA	: in std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_RRESP	: in std_logic_vector(1 downto 0);
		M_AXI_RVALID	: in std_logic;
		M_AXI_RREADY	: out std_logic
		);
	end component AES_AXI_v1_0_M02_AXI_READY;

begin

-- Instantiation of Axi Bus Interface S00_AXI_AES
AES_AXI_v1_0_S00_AXI_AES_inst : AES_AXI_v1_0_S00_AXI_AES
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_AES_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_AES_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> s00_axi_aes_aclk,
		S_AXI_ARESETN	=> s00_axi_aes_aresetn,
		S_AXI_AWADDR	=> s00_axi_aes_awaddr,
		S_AXI_AWPROT	=> s00_axi_aes_awprot,
		S_AXI_AWVALID	=> s00_axi_aes_awvalid,
		S_AXI_AWREADY	=> s00_axi_aes_awready,
		S_AXI_WDATA	=> s00_axi_aes_wdata,
		S_AXI_WSTRB	=> s00_axi_aes_wstrb,
		S_AXI_WVALID	=> s00_axi_aes_wvalid,
		S_AXI_WREADY	=> s00_axi_aes_wready,
		S_AXI_BRESP	=> s00_axi_aes_bresp,
		S_AXI_BVALID	=> s00_axi_aes_bvalid,
		S_AXI_BREADY	=> s00_axi_aes_bready,
		S_AXI_ARADDR	=> s00_axi_aes_araddr,
		S_AXI_ARPROT	=> s00_axi_aes_arprot,
		S_AXI_ARVALID	=> s00_axi_aes_arvalid,
		S_AXI_ARREADY	=> s00_axi_aes_arready,
		S_AXI_RDATA	=> s00_axi_aes_rdata,
		S_AXI_RRESP	=> s00_axi_aes_rresp,
		S_AXI_RVALID	=> s00_axi_aes_rvalid,
		S_AXI_RREADY	=> s00_axi_aes_rready
	);

-- Instantiation of Axi Bus Interface M00_AXI_DATA0
AES_AXI_v1_0_M00_AXI_DATA0_inst : AES_AXI_v1_0_M00_AXI_DATA0
	generic map (
		C_M_START_DATA_VALUE	=> C_M00_AXI_DATA0_START_DATA_VALUE,
		C_M_TARGET_SLAVE_BASE_ADDR	=> C_M00_AXI_DATA0_TARGET_SLAVE_BASE_ADDR,
		C_M_AXI_ADDR_WIDTH	=> C_M00_AXI_DATA0_ADDR_WIDTH,
		C_M_AXI_DATA_WIDTH	=> C_M00_AXI_DATA0_DATA_WIDTH,
		C_M_TRANSACTIONS_NUM	=> C_M00_AXI_DATA0_TRANSACTIONS_NUM
	)
	port map (
		INIT_AXI_TXN	=> m00_axi_data0_init_axi_txn,
		ERROR	=> m00_axi_data0_error,
		TXN_DONE	=> m00_axi_data0_txn_done,
		M_AXI_ACLK	=> m00_axi_data0_aclk,
		M_AXI_ARESETN	=> m00_axi_data0_aresetn,
		M_AXI_AWADDR	=> m00_axi_data0_awaddr,
		M_AXI_AWPROT	=> m00_axi_data0_awprot,
		M_AXI_AWVALID	=> m00_axi_data0_awvalid,
		M_AXI_AWREADY	=> m00_axi_data0_awready,
		M_AXI_WDATA	=> m00_axi_data0_wdata,
		M_AXI_WSTRB	=> m00_axi_data0_wstrb,
		M_AXI_WVALID	=> m00_axi_data0_wvalid,
		M_AXI_WREADY	=> m00_axi_data0_wready,
		M_AXI_BRESP	=> m00_axi_data0_bresp,
		M_AXI_BVALID	=> m00_axi_data0_bvalid,
		M_AXI_BREADY	=> m00_axi_data0_bready,
		M_AXI_ARADDR	=> m00_axi_data0_araddr,
		M_AXI_ARPROT	=> m00_axi_data0_arprot,
		M_AXI_ARVALID	=> m00_axi_data0_arvalid,
		M_AXI_ARREADY	=> m00_axi_data0_arready,
		M_AXI_RDATA	=> m00_axi_data0_rdata,
		M_AXI_RRESP	=> m00_axi_data0_rresp,
		M_AXI_RVALID	=> m00_axi_data0_rvalid,
		M_AXI_RREADY	=> m00_axi_data0_rready
	);

-- Instantiation of Axi Bus Interface M01_AXI_DATA1
AES_AXI_v1_0_M01_AXI_DATA1_inst : AES_AXI_v1_0_M01_AXI_DATA1
	generic map (
		C_M_START_DATA_VALUE	=> C_M01_AXI_DATA1_START_DATA_VALUE,
		C_M_TARGET_SLAVE_BASE_ADDR	=> C_M01_AXI_DATA1_TARGET_SLAVE_BASE_ADDR,
		C_M_AXI_ADDR_WIDTH	=> C_M01_AXI_DATA1_ADDR_WIDTH,
		C_M_AXI_DATA_WIDTH	=> C_M01_AXI_DATA1_DATA_WIDTH,
		C_M_TRANSACTIONS_NUM	=> C_M01_AXI_DATA1_TRANSACTIONS_NUM
	)
	port map (
		INIT_AXI_TXN	=> m01_axi_data1_init_axi_txn,
		ERROR	=> m01_axi_data1_error,
		TXN_DONE	=> m01_axi_data1_txn_done,
		M_AXI_ACLK	=> m01_axi_data1_aclk,
		M_AXI_ARESETN	=> m01_axi_data1_aresetn,
		M_AXI_AWADDR	=> m01_axi_data1_awaddr,
		M_AXI_AWPROT	=> m01_axi_data1_awprot,
		M_AXI_AWVALID	=> m01_axi_data1_awvalid,
		M_AXI_AWREADY	=> m01_axi_data1_awready,
		M_AXI_WDATA	=> m01_axi_data1_wdata,
		M_AXI_WSTRB	=> m01_axi_data1_wstrb,
		M_AXI_WVALID	=> m01_axi_data1_wvalid,
		M_AXI_WREADY	=> m01_axi_data1_wready,
		M_AXI_BRESP	=> m01_axi_data1_bresp,
		M_AXI_BVALID	=> m01_axi_data1_bvalid,
		M_AXI_BREADY	=> m01_axi_data1_bready,
		M_AXI_ARADDR	=> m01_axi_data1_araddr,
		M_AXI_ARPROT	=> m01_axi_data1_arprot,
		M_AXI_ARVALID	=> m01_axi_data1_arvalid,
		M_AXI_ARREADY	=> m01_axi_data1_arready,
		M_AXI_RDATA	=> m01_axi_data1_rdata,
		M_AXI_RRESP	=> m01_axi_data1_rresp,
		M_AXI_RVALID	=> m01_axi_data1_rvalid,
		M_AXI_RREADY	=> m01_axi_data1_rready
	);

-- Instantiation of Axi Bus Interface M02_AXI_READY
AES_AXI_v1_0_M02_AXI_READY_inst : AES_AXI_v1_0_M02_AXI_READY
	generic map (
		C_M_START_DATA_VALUE	=> C_M02_AXI_READY_START_DATA_VALUE,
		C_M_TARGET_SLAVE_BASE_ADDR	=> C_M02_AXI_READY_TARGET_SLAVE_BASE_ADDR,
		C_M_AXI_ADDR_WIDTH	=> C_M02_AXI_READY_ADDR_WIDTH,
		C_M_AXI_DATA_WIDTH	=> C_M02_AXI_READY_DATA_WIDTH,
		C_M_TRANSACTIONS_NUM	=> C_M02_AXI_READY_TRANSACTIONS_NUM
	)
	port map (
		INIT_AXI_TXN	=> m02_axi_ready_init_axi_txn,
		ERROR	=> m02_axi_ready_error,
		TXN_DONE	=> m02_axi_ready_txn_done,
		M_AXI_ACLK	=> m02_axi_ready_aclk,
		M_AXI_ARESETN	=> m02_axi_ready_aresetn,
		M_AXI_AWADDR	=> m02_axi_ready_awaddr,
		M_AXI_AWPROT	=> m02_axi_ready_awprot,
		M_AXI_AWVALID	=> m02_axi_ready_awvalid,
		M_AXI_AWREADY	=> m02_axi_ready_awready,
		M_AXI_WDATA	=> m02_axi_ready_wdata,
		M_AXI_WSTRB	=> m02_axi_ready_wstrb,
		M_AXI_WVALID	=> m02_axi_ready_wvalid,
		M_AXI_WREADY	=> m02_axi_ready_wready,
		M_AXI_BRESP	=> m02_axi_ready_bresp,
		M_AXI_BVALID	=> m02_axi_ready_bvalid,
		M_AXI_BREADY	=> m02_axi_ready_bready,
		M_AXI_ARADDR	=> m02_axi_ready_araddr,
		M_AXI_ARPROT	=> m02_axi_ready_arprot,
		M_AXI_ARVALID	=> m02_axi_ready_arvalid,
		M_AXI_ARREADY	=> m02_axi_ready_arready,
		M_AXI_RDATA	=> m02_axi_ready_rdata,
		M_AXI_RRESP	=> m02_axi_ready_rresp,
		M_AXI_RVALID	=> m02_axi_ready_rvalid,
		M_AXI_RREADY	=> m02_axi_ready_rready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
