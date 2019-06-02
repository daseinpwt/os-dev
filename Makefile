EXAMPLES_OUTPUT = $(patsubst src/examples/%.asm,boot_img/examples/%.bin,$(wildcard src/examples/*.asm))

.PHONY: examples boot_vm run-vm new-vm clean

boot_img/boot.bin: src/boot/boot.asm
	nasm $< -O0 -f bin -o $@

boot_img/examples/%.bin: src/examples/%.asm
	nasm $< -O0 -f bin -o $@

examples: $(EXAMPLES_OUTPUT)

boot-vm:
	qemu-system-i386 -boot a -fda $(IMAGE) -hda disk_img/vm-$(ID).raw

run-vm:
	qemu-system-i386 -hda disk_img/vm-$(ID).raw

new-vm:
	@if [ -f "disk_img/vm-$(ID).raw" ]; then \
		echo "vm file exists."; \
		exit 1; \
	else \
		qemu-img create -f raw disk_img/vm-$(ID).raw $(SIZE); \
	fi

clean:
	rm -f boot_img/boot.bin
	rm -f boot_img/examples/*