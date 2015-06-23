#
# Copyright (c) 2015 Sergi Granell (xerpi)
# based on Cirne's vita-toolchain test Makefile
#

TARGET = vitahelloworld
OBJS   = main.o draw.o font_data.o

LIBS = -lc_stub -lSceKernel_stub -lSceDisplay_stub -lSceGxm_stub -lSceCtrl_stub

PREFIX  = $(DEVKITARM)/bin/arm-none-eabi
CC      = $(PREFIX)-gcc
READELF = $(PREFIX)-readelf
OBJDUMP = $(PREFIX)-objdump
CFLAGS  = -Wall -B$(PSP2SDK)
ASFLAGS = $(CFLAGS)

all: $(TARGET)_fixup.elf

%_fixup.elf: %.elf
	psp2-fixup $< $@

$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) -specs=psp2.specs -L$(PSP2SDK)/lib $^ $(LIBS) -o $@

clean:
	@rm -rf $(TARGET)_fixup.elf $(TARGET).elf $(OBJS)

copy: $(TARGET)_fixup.elf
	@cp $(TARGET)_fixup.elf ~/shared/vitasample.elf
