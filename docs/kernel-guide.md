# Linux Kernel Compilation Guide

## Overview
This guide walks through compiling a custom Linux kernel 6.16 with a modified e1000 network driver that logs IP addresses.

## Prerequisites
- Ubuntu 24.04.2 LTS
- 20GB+ free disk space
- 8GB+ RAM
- Internet connection

## Step-by-Step Instructions

### 1. Initial Setup
```bash
# Run the setup script
chmod +x scripts/*.sh
./scripts/setup.sh
```

### 2. Download Required Files
```bash
# Download Ubuntu ISO
./scripts/download-ubuntu.sh

# Download kernel source
./scripts/download-kernel.sh
```

### 3. Create Virtual Machine
```bash
# Create and install Ubuntu VM
./scripts/create-vm.sh

# After installation, boot the VM
./scripts/boot-vm.sh
```

### 4. Compile Custom Kernel
```bash
# Compile the kernel (takes 30-60 minutes)
./scripts/compile-kernel.sh
```

### 5. Modify e1000 Driver
```bash
# Add IP logging to e1000 driver
./scripts/modify-driver.sh
```

### 6. Test Custom Kernel

#### Boot VM with Custom Kernel
```bash
./scripts/boot-vm.sh
# Choose 'y' when prompted for custom kernel
```

#### Copy Modules to VM
In the VM, copy the modules from host:
```bash
# Find host IP
ip route | grep default

# Copy modules (replace HOST_IP with actual IP)
scp username@HOST_IP:/path/to/project/lib.tar.bz2 .

# Extract and install modules
tar -xjf lib.tar.bz2
sudo cp -r lib/modules/6.16.0 /lib/modules
```

#### Copy Modified Driver
```bash
# Copy modified e1000 driver
scp username@HOST_IP:/path/to/project/linux-6.16/drivers/net/ethernet/intel/e1000/e1000.ko .

# Unload original driver
sudo modprobe -r e1000

# Load modified driver
sudo insmod e1000.ko
```

#### Test Network and View Logs
```bash
# Test connectivity
ping -c 5 www.google.com

# View kernel messages
sudo dmesg | tail -20

# Save output
sudo dmesg > out.txt
scp out.txt username@HOST_IP:
```

## Expected Results
- Successful kernel compilation
- VM boots with custom kernel
- Network connectivity works
- Kernel logs show IP addresses: "src IP: x.x.x.x, dst IP: y.y.y.y"

## Troubleshooting

### VM Won't Boot
- Check if virtualization is enabled in BIOS
- Ensure sufficient RAM allocated
- Try without custom kernel first

### Kernel Compilation Fails
- Check dependencies are installed
- Ensure sufficient disk space
- Review compilation errors

### Network Issues
- Run: `sudo setcap 'cap_net_raw+ep' /usr/bin/qemu-system-x86_64`
- Check host firewall settings
- Verify SSH server is running

### Driver Issues
- Verify backup was created
- Check module dependencies
- Ensure kernel modules path is correct