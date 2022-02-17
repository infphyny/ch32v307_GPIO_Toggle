# GPIO_Toggle example for CH32V307V-EVT-R1

This example is taken from https://github.com/openwch/ch32v307 repository.

The goal of this project is to compile binary file for CH32V307V-EVT-R1 eval board without using the MounRiver IDE.

## Step to build the binary file

* RiscV toolchain [from source](https://github.com/riscv/riscv-gnu-toolchain) 

To compile toolchain from source:
```
 git clone https://github.com/riscv/riscv-gnu-toolchain.git
 cd  riscv-gnu-toolchain
 ./configure --prefix=/opt/riscv --enable-multilib
 sudo make -j N
```
  where N is the number of processors.

At the end of .bashrc file add

```
export PATH=/opt/riscv/bin:$PATH
```

In src folder
```
make 
```
to compile GPIO_Toggle.bin file.


## Remark

* ARCH in the makefile is set to rv32imafc. ABI is set to ilp32f.  May need modification

* Compile optimization is set to -Os.

* There are two start files [startup_ch32v30x_D8.S](startup_ch32v30x_D8.S) and [startup_ch32v30x_D8C.S](startup_ch32v30x_D8C.S) . This project use startup_ch32v30x_D8C.S . If example don't work, modify Makefile to try with startup_ch32v30x_D8.S

* The [riscv ld script](Link.ld) set the flash size to 288K and ram size to 32k. According to datasheet V307 mcu have 256K flash and 64k ram. May need to modify Link.ld accordingly. 

## TODO
 
Step to load binary file to the development board.





