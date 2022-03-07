

# GPIO_Toggle example for CH32V307V-EVT-R1

This example is taken from https://github.com/openwch/ch32v307 repository.

The goal of this project is to compile binary file for CH32V307V-EVT-R1 eval board without using the MounRiver IDE.

* Wiring

Plug a male to female wire from PA0 to LED1.


## Step to build the binary file

* Setup udev rules

Create a file named 98-ch549.rules in directory /etc/udev/rules.d/

Inside the file write:
```
ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="8010", MODE="0666"
```
Save the file then execute:

```
 udevadm control --reload-rules
```
* Download MounRiver MRS toolchain

In the current state, closed source MounRiver openocd version is needed to
upload the binary file to the board. So download MRS_Toolchain_Linux_x64_V1.30.tar.xz and decompress in a directory.

Note: They are supposed to release the source code for their wch flash driver.




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


* Compile the binary file
In src folder
```
make
```
to compile GPIO_Toggle.bin file


* Upload binary file

Execute in MRS_Toolchain_Linux_x64_V1.30/OpenOCD/bin  
```
./openocd -f wch-riscv.cfg

```

For convenience copy GPIO_Toggle.bin in MRS_Toolchain_Linux_x64_V1.30/OpenOCD/bin.

In the same directory, open another terminal and execute

```
telnet localhost 4444

```
Inside telnet session at the prompt:

type
```
halt;
```
after type
```
flash write_image erase GPIO_Toggle.bin 0x08000000
```
Toggle S3 switch on-off-on to execute the binary.



## Remark

* ARCH in the makefile is set to rv32imafc. ABI is set to ilp32f. May need modification. After analysing the 8 uarts demo application, CH32V307 add a custom instruction sets: xw and arch is rv32imacxw. I didn't found any documentation yet for this instructions. Instructions are defined in the file riscv-op. in binutils.

* Compile optimization is set to -Os.

<!--

* There are two start files [startup_ch32v30x_D8.S](startup_ch32v30x_D8.S) and [startup_ch32v30x_D8C.S](startup_ch32v30x_D8C.S) . This project use startup_ch32v30x_D8C.S . If example don't work, modify Makefile to try with startup_ch32v30x_D8.S

-->

<!--
* The [riscv ld script](Link.ld) set the flash size to 288K and ram size to 32k. According to datasheet V307 mcu have 256K flash and 64k ram. May need to modify Link.ld accordingly.
-->
