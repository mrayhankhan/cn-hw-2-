#!/bin/bash

# Create and configure Ubuntu Virtual Machine

set -e

PROJECT_DIR="$(pwd)/project"
cd "$PROJECT_DIR"

echo "=== Creating Ubuntu Virtual Machine ==="

# Check if Ubuntu ISO exists
ISO_FILE=$(ls ubuntu-*.iso 2>/dev/null | head -1)
if [ -z "$ISO_FILE" ]; then
    echo "✗ Ubuntu ISO not found. Please run ./scripts/download-ubuntu.sh first"
    exit 1
fi

echo "Using ISO: $ISO_FILE"

# Create VM disk image
VM_DISK="linux.qcow2"
VM_SIZE="20G"
VM_MEMORY="6G"

if [ -f "$VM_DISK" ]; then
    echo "VM disk already exists: $VM_DISK"
    read -p "Do you want to recreate it? (y/N): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        rm "$VM_DISK"
    else
        echo "Using existing VM disk"
        echo "To boot VM: ./scripts/boot-vm.sh"
        exit 0
    fi
fi

echo "Creating VM disk image ($VM_SIZE)..."
qemu-img create -f qcow2 "$VM_DISK" "$VM_SIZE"

echo ""
echo "=== Starting VM Installation ==="
echo "VM will boot from ISO for Ubuntu installation"
echo "After installation:"
echo "1. Follow Ubuntu setup wizard"
echo "2. Create a user account"
echo "3. Shut down the VM when installation is complete"
echo "4. Use ./scripts/boot-vm.sh to boot the installed system"

echo ""
echo "Starting VM installation..."
echo "Press Ctrl+Alt+G to release mouse/keyboard from VM"

qemu-system-x86_64 \
    -enable-kvm \
    -m "$VM_MEMORY" \
    -cdrom "$ISO_FILE" \
    -boot d \
    "$VM_DISK"

echo ""
echo "Installation completed. Use ./scripts/boot-vm.sh to boot the VM"