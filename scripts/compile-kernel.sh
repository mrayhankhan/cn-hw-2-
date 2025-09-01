#!/bin/bash

# Compile Linux Kernel 6.16

set -e

PROJECT_DIR="$(pwd)/project"
cd "$PROJECT_DIR"

KERNEL_DIR="linux-6.16"

if [ ! -d "$KERNEL_DIR" ]; then
    echo "✗ Kernel source not found: $KERNEL_DIR"
    echo "Please run ./scripts/download-kernel.sh first"
    exit 1
fi

echo "=== Compiling Linux Kernel 6.16 ==="
cd "$KERNEL_DIR"

# Copy current kernel config
echo "Copying current kernel configuration..."
cp /boot/config-$(uname -r) .config

# Create local module config
echo "Creating local module configuration..."
echo "Press Enter for all options when prompted"
make localmodconfig

# Disable problematic security keys
echo "Disabling system trusted keys..."
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
scripts/config --module E1000

echo ""
echo "Starting kernel compilation..."
echo "This will take 30-60 minutes depending on your system"
echo "Using $(nproc) CPU cores"

# Compile kernel
make -j $(nproc)

if [ $? -eq 0 ]; then
    echo "✓ Kernel compilation successful"
else
    echo "✗ Kernel compilation failed"
    exit 1
fi

# Install modules
echo "Installing kernel modules..."
cd ..
make -C "$KERNEL_DIR" modules_install INSTALL_MOD_PATH=$(pwd)

# Create modules tarball
echo "Creating modules tarball..."
tar -cjf lib.tar.bz2 lib

echo ""
echo "=== Kernel Compilation Complete ==="
echo "Kernel image: $PROJECT_DIR/$KERNEL_DIR/arch/x86_64/boot/bzImage"
echo "Modules: $PROJECT_DIR/lib.tar.bz2"
echo ""
echo "Next steps:"
echo "1. Boot VM with: ./scripts/boot-vm.sh"
echo "2. Copy modules to VM"
echo "3. Test custom kernel"