transcript on
vmap altera C:/Users/Mykho/Documents/repos/AES-Engine-Digital/MixColumnsTestBench/vhdl_libs/altera
vmap lpm C:/Users/Mykho/Documents/repos/AES-Engine-Digital/MixColumnsTestBench/vhdl_libs/lpm
vmap sgate C:/Users/Mykho/Documents/repos/AES-Engine-Digital/MixColumnsTestBench/vhdl_libs/sgate
vmap altera_mf C:/Users/Mykho/Documents/repos/AES-Engine-Digital/MixColumnsTestBench/vhdl_libs/altera_mf
vmap altera_lnsim C:/Users/Mykho/Documents/repos/AES-Engine-Digital/MixColumnsTestBench/vhdl_libs/altera_lnsim
vmap cyclonev C:/Users/Mykho/Documents/repos/AES-Engine-Digital/MixColumnsTestBench/vhdl_libs/cyclonev
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Mykho/Documents/repos/AES-Engine-Digital/MixColumns/MixColumns.vhd}

