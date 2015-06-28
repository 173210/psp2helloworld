#
# Copyright (c) 2015 Sergi Granell (xerpi)
# based on Cirne's vita-toolchain test Makefile
#

TARGET = psp2helloworld
OBJS   = main.o draw.o font_data.o

LIBS = -lSceKernel_stub -lSceDisplay_stub -lSceGxm_stub	\
	-lSceCtrl_stub -lSceTouch_stub

CC      = arm-none-eabi-gcc
READELF = arm-none-eabi-readelf
OBJDUMP = arm-none-eabi-objdump
CFLAGS  = -Wall -specs=psp2.specs
ASFLAGS = $(CFLAGS)

all: $(TARGET)_fixup.elf

%_fixup.elf: %.elf
	psp2-fixup -q -S $< $@

$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) $^ $(LIBS) -o $@

clean:
	@rm -rf $(TARGET)_fixup.elf $(TARGET).elf $(OBJS)

copy: $(TARGET)_fixup.elf
	@cp $(TARGET)_fixup.elf ~/shared/vitasample.elf
	@echo "Copied!"
