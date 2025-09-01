#!/bin/bash

# Master execution script for CN Homework 2

echo "========================================"
echo "CN Homework 2: Custom Kernel & Network Analysis"
echo "========================================"
echo ""

# Make all scripts executable
chmod +x scripts/*.sh

echo "Available operations:"
echo "1. Setup environment"
echo "2. Download Ubuntu ISO"
echo "3. Download kernel source"
echo "4. Create virtual machine"
echo "5. Compile kernel"
echo "6. Modify e1000 driver"
echo "7. Boot VM with custom kernel"
echo "8. Run network analysis homework"
echo "9. Full automated setup (1-3)"
echo "0. Exit"
echo ""

while true; do
    read -p "Enter your choice (0-9): " choice
    
    case $choice in
        1)
            echo "Setting up environment..."
            ./scripts/setup.sh
            ;;
        2)
            echo "Downloading Ubuntu ISO..."
            ./scripts/download-ubuntu.sh
            ;;
        3)
            echo "Downloading kernel source..."
            ./scripts/download-kernel.sh
            ;;
        4)
            echo "Creating virtual machine..."
            ./scripts/create-vm.sh
            ;;
        5)
            echo "Compiling kernel..."
            ./scripts/compile-kernel.sh
            ;;
        6)
            echo "Modifying e1000 driver..."
            ./scripts/modify-driver.sh
            ;;
        7)
            echo "Booting VM..."
            ./scripts/boot-vm.sh
            ;;
        8)
            echo "Running network analysis homework..."
            ./scripts/run-network-homework.sh
            ;;
        9)
            echo "Running full automated setup..."
            ./scripts/setup.sh
            ./scripts/download-ubuntu.sh
            ./scripts/download-kernel.sh
            echo "Automated setup complete. Continue with manual steps."
            ;;
        0)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please enter 0-9."
            ;;
    esac
    
    echo ""
    echo "Operation completed. Choose next action:"
done