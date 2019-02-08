
module unsaved (
	clk_clk,
	reset_reset_n,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	LedControl_0_avalon_slave_read,
	LedControl_0_avalon_slave_write,
	LedControl_0_avalon_slave_writedata,
	LedControl_0_avalon_slave_readdata,
	LedControl_0_reset_sink_reset);	

	input		clk_clk;
	input		reset_reset_n;
	output	[12:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[7:0]	memory_mem_dq;
	inout		memory_mem_dqs;
	inout		memory_mem_dqs_n;
	output		memory_mem_odt;
	output		memory_mem_dm;
	input		memory_oct_rzqin;
	output		LedControl_0_avalon_slave_read;
	output		LedControl_0_avalon_slave_write;
	output	[7:0]	LedControl_0_avalon_slave_writedata;
	input	[7:0]	LedControl_0_avalon_slave_readdata;
	output		LedControl_0_reset_sink_reset;
endmodule
