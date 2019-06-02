OUTPUTS = $(patsubst src/%.asm,boot_img/%.bin,$(wildcard src/*.asm))

.PHONY: boot_dev boot_vm run-vm new-vm clean

all: $(OUTPUTS)

boot_img/%.bin: src/%.asm
	nasm $< -O0 -f bin -o $@

boot-vm:
	qemu-system-i386 -nographic -boot a -fda $(IMAGE) -hda disk_img/vm-$(ID).raw

run-vm:
	qemu-system-i386 -nographic -hda disk_img/vm-$(ID).raw

new-vm:
	@if [ -f "disk_img/vm-$(ID).raw" ]; then \
		echo "vm file exists."; \
		exit 1; \
	else \
		qemu-img create -f raw disk_img/vm-$(ID).raw $(SIZE); \
	fi

clean:
	rm -f boot_img/*