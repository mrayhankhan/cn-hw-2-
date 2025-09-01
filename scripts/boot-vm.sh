#!/bin/bash

# Boot Ubuntu Virtual Machine

set -e

PROJECT_DIR="$(pwd)/project"
cd "$PROJECT_DIR"

VM_DISK="linux.qcow2"
VM_MEMORY="6G"

if [ ! -f "$VM_DISK" ]; then
    echo "✗ VM disk not found: $VM_DISK"
    echo "Please run ./scripts/create-vm.sh first"
    exit 1
fi

echo "=== Booting Ubuntu Virtual Machine ==="
echo "VM Disk: $VM_DISK"
echo "Memory: $VM_MEMORY"

# Check if custom kernel exists
CUSTOM_KERNEL="linux-6.16/arch/x86_64/boot/bzImage"
if [ -f "$CUSTOM_KERNEL" ]; then
    echo "Custom kernel found. Boot with custom kernel? (y/N)"
    read -p "Choice: " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo "Booting with custom kernel..."
        qemu-system-x86_64 \
            -enable-kvm \
            -kernel "$CUSTOM_KERNEL" \
            -append "root=/dev/sda2 console=ttyS0 nokaslr" \
            -m "$VM_MEMORY" \
            -hda "$VM_DISK"
        exit 0
    fi
fi

echo "Booting with default kernel..."
echo "Press Ctrl+Alt+G to release mouse/keyboard from VM"

qemu-system-x86_64 \
    -enable-kvm \
    -m "$VM_MEMORY" \
    "$VM_DISK"