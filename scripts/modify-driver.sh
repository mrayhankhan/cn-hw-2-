#!/bin/bash

# Modify e1000 driver to add IP logging

set -e

PROJECT_DIR="$(pwd)/project"
KERNEL_DIR="$PROJECT_DIR/linux-6.16"
DRIVER_FILE="$KERNEL_DIR/drivers/net/ethernet/intel/e1000/e1000_main.c"

if [ ! -f "$DRIVER_FILE" ]; then
    echo "✗ Driver file not found: $DRIVER_FILE"
    echo "Please ensure kernel source is downloaded and extracted"
    exit 1
fi

echo "=== Modifying e1000 Driver ==="
echo "Adding IP logging to e1000_xmit_frame function"

# Create backup
cp "$DRIVER_FILE" "$DRIVER_FILE.backup"

# Find the e1000_xmit_frame function and add IP logging
python3 << EOF
import re

driver_file = "$DRIVER_FILE"

with open(driver_file, 'r') as f:
    content = f.read()

# Find the e1000_xmit_frame function
pattern = r'(static netdev_tx_t e1000_xmit_frame\([^{]*\{)'
replacement = r'''\1
	struct iphdr *iph = ip_hdr(skb);

	if (iph) {
		__be32 saddr = iph->saddr;
		__be32 daddr = iph->daddr;
		printk("src IP: %pI4, dst IP: %pI4\\n", &saddr, &daddr);
	}'''

modified_content = re.sub(pattern, replacement, content, flags=re.MULTILINE | re.DOTALL)

if modified_content != content:
    with open(driver_file, 'w') as f:
        f.write(modified_content)
    print("✓ Driver modified successfully")
else:
    print("✗ Failed to find e1000_xmit_frame function")
    exit(1)
EOF

if [ $? -eq 0 ]; then
    echo "✓ e1000 driver modified successfully"
    echo "Backup saved as: $DRIVER_FILE.backup"
    
    # Compile just the e1000 module
    echo "Compiling e1000 module..."
    cd "$KERNEL_DIR"
    make M=drivers/net/ethernet/intel/e1000
    
    if [ $? -eq 0 ]; then
        echo "✓ e1000 module compiled successfully"
        echo "Module location: $KERNEL_DIR/drivers/net/ethernet/intel/e1000/e1000.ko"
    else
        echo "✗ e1000 module compilation failed"
        exit 1
    fi
else
    echo "✗ Failed to modify driver"
    exit 1
fi