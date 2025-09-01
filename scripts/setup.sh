#!/bin/bash

# CN Homework 2 - Setup Script
# This script sets up the environment for kernel compilation and VM creation

set -e

echo "=== CN Homework 2 Setup Script ==="
echo "Setting up environment for custom kernel compilation and network analysis"

# Create project structure
echo "Creating project directories..."
mkdir -p project/{scripts,kernel,vm,network-analysis,docs}

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install QEMU and virtualization tools
echo "Installing QEMU and virtualization tools..."
sudo apt install -y qemu-kvm qemu-system-x86_64 qemu-utils
sudo setcap 'cap_net_raw+ep' /usr/bin/qemu-system-x86_64

# Install kernel compilation dependencies
echo "Installing kernel compilation dependencies..."
sudo apt install -y build-essential flex bison libelf-dev libssl-dev libdw-dev gawk

# Install network analysis tools
echo "Installing network analysis tools..."
sudo apt install -y net-tools traceroute mtr-tiny dnsutils iftop whois

# Install SSH server
echo "Installing and configuring SSH server..."
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

# Check if virtualization is supported
echo "Checking virtualization support..."
if [ -r /proc/cpuinfo ] && grep -q "vmx\|svm" /proc/cpuinfo; then
    echo "✓ Virtualization support detected"
else
    echo "⚠ Warning: Virtualization support not detected"
fi

# Get host IP address
echo "Host machine information:"
echo "IP Address: $(hostname -I | awk '{print $1}')"
echo "Hostname: $(hostname)"

echo ""
echo "=== Setup Complete ==="
echo "Next steps:"
echo "1. Download Ubuntu ISO: ./scripts/download-ubuntu.sh"
echo "2. Download kernel source: ./scripts/download-kernel.sh"
echo "3. Follow the kernel compilation guide"

echo ""
echo "Project directory created at: $(pwd)/project"