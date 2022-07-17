# output
OUT=output.bin
OBJ=debugfont string joy z80 vdp dma state_dummy state_title state_game state_gameover statelist statemanager main exception init header 
INC=

MAP=output.map
AFLAGS=-ldots -spaces -warncomm -Isrc
LDFLAGS= -Bstatic

# tooling
ASM68=bin/vasmm68k_mot
LD=bin/vlink
EMU=tools/blastem/blastem

OBJLIST = $(foreach o,$(OBJ),./obj/$(o).o68)
.PHONY: $(OUT)
all: $(OUT)

run: $(OUT)
	$(EMU) $(OUT)
debug: $(OUT)
	$(EMU) -d $(OUT)

./obj/%.o68: ./src/%.s68
	$(ASM68) $(AFLAGS) -L $(<:src/%.s68=list/%.lst) -Fvobj $< -o $@

$(OUT): $(OBJLIST)
	$(LD) -T linker.ld $(LDFLAGS) -b rawbin1 -M$(MAP) -o $@ $^

clean:
	rm $(OUT)
	rm $(OBJLIST)
	rm $(MAP)
