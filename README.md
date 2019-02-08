# AES Engine in VHDL

This repository is a VHDL implementation of the AES specification.

## Getting Started

There are three main parts in this repository

* VHDL code
* FPGA implementations
* DotNet applications to generate testbenches for indiviaul VHDl modules

### VHDL

Tools needed

* Modelsim

The AES_Engine folder is the main implementation of the AES Engine, other folders are pieces of the whole system.

Each folder contains three files

* Implementation
* VHDL Testbench
* .do file for Modelsim simulations

In order to test in Modelsim

```
Open Modelsim
Open > /AES_Engine/sim/testbench.mpf
Compile > Compile All
Right click Library > work > aesenginetb > simulate
Load > /AES_Engine/AESEngineTb.do
```

There are other testbenches for individual modules. In order to load those, simulate the module ending with "tb" and load the corresponding .do file.

### DotNet applications

Tools needed

* Visual Studio (2017 was used)

These ASP.Net applications generate parts of the VHDL testbenches. Run these and depending on the implementation, generate different testvectors in different ways.

### FPGA implementations

There are two implementations, DE1-SoC Cyclone V development board and the Zybo Zynq-7000 board. The different boards require different tools but ultimately work the same way.
Note that this part is not complete, feel free to try to make this work. Issues with Vivado is that the synthesised design did not fit on the Zybo Zynq-7000. Issues with DE1-SoC Cyclone V is that the connection between the HPS and AES_Engine IP has not been made successfully

```
Program the FPGA
Start a C application that writes and reads to the AES_Engine IP.
```

### Zybo Zynq 7ooo

Tools needed

* Vivado (2016.4 was used) for customising the bitstreams used
* Any preferred serial monitor
* SD card with desired xillinux version

To start the demo

```
Boot
Locate the .bit file
Load in into the fpga
$cat system.bit > /dev/xdevcfg
Start the C application
```

### DE1-SoC Cyclone V

Tools needed

* Quartus (Lite 17.1)
* USB Blaster drivers
* SD card with desired Linux kernel

If programming the FPGA is needed
```
Tools > Programmer
Set the programmer correctly and click upload
```
