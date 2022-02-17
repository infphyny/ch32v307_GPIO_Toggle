TOOLCHAIN_PREFIX := riscv64-unknown-elf-
AS := $(TOOLCHAIN_PREFIX)as
CC := $(TOOLCHAIN_PREFIX)gcc
OBJCOPY := $(TOOLCHAIN_PREFIX)objcopy
ARCH := rv32imafc
ABI  := ilp32f

PROJECT_NAME := GPIO_Toggle
OPT := -Os
OBJ := startup_ch32v30x_D8C.o system_ch32v30x.o ch32v30x_gpio.o ch32v30x_usart.o ch32v30x_rcc.o ch32v30x_misc.o debug.o ch32v30x_it.o main.o
LDFLAGS += --print-memory-usage

%.o:%.S
	$(AS) -mabi=$(ABI)  -march=$(ARCH) -o $@ $<

%.o:%.c  Makefile
	$(CC)  $(INCLUDE_DIRECTORIES) -lgcc -mabi=$(ABI) -nostartfiles $(OPT) -march=$(ARCH) -T Link.ld  -c  -o $@  $<


$(PROJECT_NAME).bin : $(PROJECT_NAME).elf
	$(OBJCOPY) -O binary $< $@

$(PROJECT_NAME).elf : $(OBJ)
	$(CC) $(INCLUDES_DIRECTORIES) -lgcc -mabi=ilp32f -nostartfiles $(OPT) -march=$(ARCH) -T  Link.ld  -o $@  $^ -Wl,-Map,$(PROJECT_NAME).map,$(LDFLAGS)




.PHONY: clean

clean:
	rm -f *.o *.elf *.bin *.map
