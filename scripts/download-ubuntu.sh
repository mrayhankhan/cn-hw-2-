#!/bin/bash

# Download Ubuntu Desktop ISO

set -e

PROJECT_DIR="$(pwd)/project"
cd "$PROJECT_DIR"

echo "=== Downloading Ubuntu Desktop ISO ==="

# Ubuntu 24.04 LTS Desktop ISO
UBUNTU_VERSION="24.04.1"
ISO_NAME="ubuntu-${UBUNTU_VERSION}-desktop-amd64.iso"
DOWNLOAD_URL="https://releases.ubuntu.com/${UBUNTU_VERSION}/${ISO_NAME}"

if [ -f "$ISO_NAME" ]; then
    echo "Ubuntu ISO already exists: $ISO_NAME"
    echo "Size: $(du -h $ISO_NAME | cut -f1)"
else
    echo "Downloading Ubuntu $UBUNTU_VERSION Desktop..."
    echo "URL: $DOWNLOAD_URL"
    echo "This may take a while depending on your internet connection..."
    
    wget -c "$DOWNLOAD_URL" -O "$ISO_NAME"
    
    if [ $? -eq 0 ]; then
        echo "✓ Download completed successfully"
        echo "Downloaded: $ISO_NAME"
        echo "Size: $(du -h $ISO_NAME | cut -f1)"
    else
        echo "✗ Download failed"
        exit 1
    fi
fi

echo ""
echo "Ubuntu ISO ready for VM creation"
echo "Location: $PROJECT_DIR/$ISO_NAME"