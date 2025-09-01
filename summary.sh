#!/bin/bash

# Summary and verification script

echo "=== CN Homework 2 Project Summary ==="
echo ""

PROJECT_ROOT="/workspaces/cn-hw-2-"
cd "$PROJECT_ROOT"

echo "📁 Project Structure:"
echo "===================="
tree -L 3 . 2>/dev/null || find . -type d -not -path '*/.*' | head -20

echo ""
echo "🔧 Available Scripts:"
echo "===================="
echo "Setup and Environment:"
echo "  - scripts/setup.sh              # Install dependencies"
echo "  - scripts/download-ubuntu.sh    # Download Ubuntu ISO" 
echo "  - scripts/download-kernel.sh    # Download kernel source"
echo ""
echo "Kernel Compilation:"
echo "  - scripts/compile-kernel.sh     # Compile custom kernel"
echo "  - scripts/modify-driver.sh      # Modify e1000 driver"
echo ""
echo "Virtual Machine:"
echo "  - scripts/create-vm.sh          # Create Ubuntu VM"
echo "  - scripts/boot-vm.sh            # Boot VM"
echo ""
echo "Network Analysis:"
echo "  - scripts/network-q1.sh         # Q1: ifconfig"
echo "  - scripts/network-q2.sh         # Q2: traceroute/mtr" 
echo "  - scripts/network-q3.sh         # Q3: nslookup/dig"
echo "  - scripts/network-q4.sh         # Q4: iftop (needs sudo)"
echo "  - scripts/run-network-homework.sh # Run all network questions"
echo ""
echo "Master Script:"
echo "  - run.sh                        # Interactive menu"

echo ""
echo "📚 Documentation:"
echo "=================="
echo "  - docs/kernel-guide.md          # Kernel compilation guide"
echo "  - docs/network-homework-guide.md # Network analysis guide"
echo "  - README.md                     # Project overview"

echo ""
echo "🚀 Quick Start Commands:"
echo "======================="
echo "  chmod +x run.sh && ./run.sh    # Interactive menu"
echo "  ./scripts/setup.sh              # Setup environment"
echo "  ./scripts/run-network-homework.sh # Network analysis"

echo ""
echo "✅ System Check:"
echo "================"

# Check if running on Ubuntu
if grep -q "Ubuntu" /etc/os-release 2>/dev/null; then
    echo "✓ Running on Ubuntu"
else
    echo "⚠ Not running on Ubuntu - may need adjustments"
fi

# Check available space
AVAILABLE_SPACE=$(df . | tail -1 | awk '{print $4}')
SPACE_GB=$((AVAILABLE_SPACE / 1024 / 1024))
if [ $SPACE_GB -gt 20 ]; then
    echo "✓ Sufficient disk space ($SPACE_GB GB available)"
else
    echo "⚠ Low disk space ($SPACE_GB GB available, 20+ GB recommended)"
fi

# Check RAM
TOTAL_RAM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
RAM_GB=$((TOTAL_RAM / 1024 / 1024))
if [ $RAM_GB -gt 7 ]; then
    echo "✓ Sufficient RAM ($RAM_GB GB total)"
else
    echo "⚠ Low RAM ($RAM_GB GB total, 8+ GB recommended)"
fi

# Check if scripts are executable
if [ -x "run.sh" ]; then
    echo "✓ Scripts are executable"
else
    echo "⚠ Run: chmod +x run.sh scripts/*.sh"
fi

echo ""
echo "🎯 Next Steps:"
echo "=============="
echo "1. Make scripts executable: chmod +x run.sh scripts/*.sh"
echo "2. Run setup: ./run.sh (option 9 for automated setup)"
echo "3. For kernel compilation: Follow docs/kernel-guide.md"
echo "4. For network analysis: Run ./scripts/run-network-homework.sh"
echo ""
echo "Happy coding! 🚀"