TOOLCHAIN_PREFIX := riscv64-unknown-elf-
AS := $(TOOLCHAIN_PREFIX)as
CC := $(TOOLCHAIN_PREFIX)gcc
OBJCOPY := $(TOOLCHAIN_PREFIX)objcopy
OBJDUMP := $(TOOLCHAIN_PREFIX)objdump
#ARCH := rv32imafc
#ABI  := ilp32f
ARCH := rv32imac#xw1p0#
ABI  := ilp32#

PROJECT_NAME := GPIO_Toggle
OPT := -O3
OBJ := startup_ch32v30x_D8C.o system_ch32v30x.o ch32v30x_adc.o ch32v30x_bkp.o \
 ch32v30x_can.o ch32v30x_crc.o ch32v30x_dac.o ch32v30x_dbgmcu.o ch32v30x_dma.o \
 ch32v30x_dvp.o ch32v30x_eth.o ch32v30x_exti.o ch32v30x_flash.o ch32v30x_fsmc.o \
 ch32v30x_gpio.o ch32v30x_i2c.o ch32v30x_iwdg.o ch32v30x_opa.o ch32v30x_pwr.o \
 ch32v30x_rcc.o ch32v30x_rng.o ch32v30x_rtc.o ch32v30x_sdio.o ch32v30x_spi.o \
 ch32v30x_tim.o  ch32v30x_usart.o ch32v30x_wwdg.o  \
 core_riscv.o ch32v30x_misc.o debug.o ch32v30x_it.o syscalls.o main.o
LDFLAGS += --print-memory-usage

#%.o:%.S
#	$(AS) -mabi=$(ABI)  -march=$(ARCH) -o $@ $<

all: $(PROJECT_NAME).elf $(PROJECT_NAME).bin $(PROJECT_NAME).lst

%.o:%.S
	$(CC)  -mabi=$(ABI)  $(OPT) -march=$(ARCH) -nostartfiles -msmall-data-limit=8 -msave-restore -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -w -x assembler -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o $@  $<


%.o:%.c  Makefile
	$(CC)  $(INCLUDE_DIRECTORIES) -std=gnu99  -mabi=$(ABI)  $(OPT) -march=$(ARCH) -nostartfiles  -msmall-data-limit=8 -msave-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -w -Xlinker --gc-sections   -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c  -o $@  $<

$(PROJECT_NAME).lst : $(PROJECT_NAME).elf
	@ $(OBJDUMP) --source --all-headers --demangle --line-numbers --wide  $< > $@

$(PROJECT_NAME).bin : $(PROJECT_NAME).elf
		@		$(OBJCOPY) -O binary $< $@
		@ 	$(OBJCOPY) -O ihex $< $(PROJECT_NAME).hex
		@ @

$(PROJECT_NAME).elf : $(OBJ)
	$(CC) $(INCLUDES_DIRECTORIES)  -L /home/stche/tools/WCH/MounRiver_Studio_Community_Linux_x64_V100/MRS_Community/toolchain/RISC-V\ Embedded\ GCC/lib/gcc/lib/rv32imac/ilp32/ -std=gnu99 -mabi=$(ABI)  $(OPT) -march=$(ARCH) -nostartfiles -msmall-data-limit=8 -msave-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -w -Xlinker --gc-sections  -Wl,-Map,$(PROJECT_NAME).map,$(LDFLAGS) --specs=nano.specs --specs=nosys.specs  -T  Link.ld  -o $@  $^





#secondary-outputs: $(PROJECT_NAME).bin




#secondary-outputs:



.PHONY: clean

clean:
	rm -f *.o *.elf *.bin *.map *.d *.hex
