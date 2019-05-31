OUTPUTS = $(patsubst src/%.asm,images/%.bin,$(wildcard src/*.asm))

.PHONY: run clean

all: $(OUTPUTS)

images/%.bin: src/%.asm
	nasm $< -O0 -f bin -o $@

run:
	qemu-system-i386 -nographic -drive format=raw,file=$(IMAGE)

clean:
	rm -f images/*
