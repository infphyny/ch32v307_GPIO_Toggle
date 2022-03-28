TOOLCHAIN_PREFIX := riscv64-unknown-elf-
AS := $(TOOLCHAIN_PREFIX)as
CC := $(TOOLCHAIN_PREFIX)gcc
OBJCOPY := $(TOOLCHAIN_PREFIX)objcopy
OBJDUMP := $(TOOLCHAIN_PREFIX)objdump
ARCH := rv32imafc
ABI  := ilp32f
#ARCH := rv32ima#c#xw1p0#
#ABI  := ilp32#

PROJECT_NAME := GPIO_Toggle
OPT := -Os

OBJ=startup_ch32v30x_D8C.o $(patsubst %.c,%.o,$(wildcard *.c))

LDFLAGS += --print-memory-usage

#%.o:%.S
#	$(AS) -mabi=$(ABI)  -march=$(ARCH) -o $@ $<

all: $(PROJECT_NAME).elf $(PROJECT_NAME).bin $(PROJECT_NAME).lst

-include *.d

%.o:%.S
	$(CC) $(OPT) -mabi=$(ABI)   -march=$(ARCH) -nostartfiles -msmall-data-limit=8 -msave-restore -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -w -x assembler -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o $@  $<


%.o:%.c  Makefile
	$(CC) $(OPT) $(INCLUDE_DIRECTORIES) -std=gnu99  -mabi=$(ABI)  -march=$(ARCH) -nostartfiles  -msmall-data-limit=8 -msave-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -w -Xlinker --gc-sections   -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c  -o $@  $<

$(PROJECT_NAME).lst : $(PROJECT_NAME).elf
	@ $(OBJDUMP) --source --all-headers --demangle --line-numbers --wide  $< > $@

$(PROJECT_NAME).bin : $(PROJECT_NAME).elf
		@		$(OBJCOPY) -O binary $< $@
		@ 	$(OBJCOPY) -O ihex $< $(PROJECT_NAME).hex
		@ @

$(PROJECT_NAME).elf : $(OBJ) Link.ld
	$(CC) -std=gnu99 -mabi=$(ABI)  $(OPT) -march=$(ARCH) -nostartfiles -msmall-data-limit=8 -msave-restore -Os -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -w -Xlinker --gc-sections  -Wl,-Map,$(PROJECT_NAME).map,$(LDFLAGS) --specs=nano.specs --specs=nosys.specs  -T  Link.ld  -o $@  $(OBJ)





#secondary-outputs: $(PROJECT_NAME).bin




#secondary-outputs:



.PHONY: clean

clean:
	rm -f *.o *.elf *.bin *.map *.d *.hex
