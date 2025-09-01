#!/bin/bash

# Download Linux Kernel 6.16

set -e

PROJECT_DIR="$(pwd)/project"
cd "$PROJECT_DIR"

echo "=== Downloading Linux Kernel 6.16 ==="

KERNEL_VERSION="6.16"
KERNEL_TAR="linux-${KERNEL_VERSION}.tar.xz"
DOWNLOAD_URL="https://cdn.kernel.org/pub/linux/kernel/v6.x/${KERNEL_TAR}"

if [ -d "linux-${KERNEL_VERSION}" ]; then
    echo "Kernel source already exists: linux-${KERNEL_VERSION}"
else
    if [ -f "$KERNEL_TAR" ]; then
        echo "Kernel tarball already exists: $KERNEL_TAR"
    else
        echo "Downloading Linux Kernel $KERNEL_VERSION..."
        echo "URL: $DOWNLOAD_URL"
        echo "This may take a while..."
        
        wget -c "$DOWNLOAD_URL" -O "$KERNEL_TAR"
        
        if [ $? -ne 0 ]; then
            echo "✗ Download failed"
            exit 1
        fi
    fi
    
    echo "Extracting kernel source..."
    tar -xf "$KERNEL_TAR"
    
    if [ $? -eq 0 ]; then
        echo "✓ Kernel source extracted successfully"
        echo "Location: $PROJECT_DIR/linux-${KERNEL_VERSION}"
    else
        echo "✗ Extraction failed"
        exit 1
    fi
fi

echo ""
echo "Kernel source ready for compilation"
echo "Directory: $PROJECT_DIR/linux-${KERNEL_VERSION}"