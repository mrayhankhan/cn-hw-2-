# CN Homework 2: Custom Linux Kernel Compilation and Network Analysis

This project contains instructions and scripts for:
1. Compiling a custom Linux kernel (version 6.16)
2. Creating and booting Ubuntu VM with custom kernel
3. Network tools analysis homework

## Quick Start
```bash
# Make scripts executable and run
chmod +x run.sh
./run.sh
```

## Project Structure
```
cn-hw-2-/
├── scripts/           # Automation scripts
├── docs/             # Documentation and guides
├── project/          # Working directory (created by scripts)
│   ├── kernel/       # Kernel source and build files
│   ├── vm/          # VM related files
│   └── network-analysis/ # Network homework results
└── run.sh           # Master execution script
```

## Prerequisites
- Ubuntu 24.04.2 LTS host machine
- Minimum 20GB free disk space
- 8GB+ RAM recommended
- Internet connection

## Components

### 1. Custom Kernel Compilation
- **Linux 6.16** with modified e1000 driver
- **Modified e1000 driver** logs source/destination IP addresses
- **Ubuntu VM** running the custom kernel

### 2. Network Analysis Homework
Automated scripts for all 4 questions:
- **Q1**: ifconfig analysis (5 marks)
- **Q2**: traceroute/mtr analysis (5 marks)  
- **Q3**: DNS analysis with nslookup/dig (5 marks)
- **Q4**: Traffic analysis with iftop (5 marks)

## Available Scripts

### Setup and Environment
- `scripts/setup.sh` - Install dependencies and configure environment
- `scripts/download-ubuntu.sh` - Download Ubuntu ISO
- `scripts/download-kernel.sh` - Download and extract kernel source

### Kernel Compilation
- `scripts/compile-kernel.sh` - Compile custom kernel
- `scripts/modify-driver.sh` - Modify e1000 driver with IP logging

### Virtual Machine
- `scripts/create-vm.sh` - Create and install Ubuntu VM
- `scripts/boot-vm.sh` - Boot VM (with/without custom kernel)

### Network Analysis
- `scripts/network-q1.sh` - Q1: ifconfig analysis
- `scripts/network-q2.sh` - Q2: traceroute/mtr analysis
- `scripts/network-q3.sh` - Q3: DNS analysis
- `scripts/network-q4.sh` - Q4: iftop traffic analysis
- `scripts/run-network-homework.sh` - Run all network questions

## Documentation
- `docs/kernel-guide.md` - Detailed kernel compilation guide
- `docs/network-homework-guide.md` - Network analysis homework guide

## Usage Examples

### Complete Workflow
```bash
# 1. Initial setup
./run.sh
# Choose option 9 for full automated setup

# 2. Create VM and install Ubuntu
./scripts/create-vm.sh

# 3. Compile kernel
./scripts/compile-kernel.sh

# 4. Modify driver
./scripts/modify-driver.sh

# 5. Test with VM
./scripts/boot-vm.sh

# 6. Network homework
./scripts/run-network-homework.sh
sudo ./scripts/network-q4.sh
```

### Network Analysis Only
```bash
# Run all network analysis questions
./scripts/run-network-homework.sh

# Or run individual questions
./scripts/network-q1.sh
./scripts/network-q2.sh
./scripts/network-q3.sh
sudo ./scripts/network-q4.sh
```

## Expected Results

### Kernel Compilation
- Successfully compiled Linux 6.16 kernel
- Modified e1000 driver with IP logging
- Ubuntu VM boots with custom kernel
- Network logs show: "src IP: x.x.x.x, dst IP: y.y.y.y"

### Network Analysis
- Complete analysis of network interfaces
- Route tracing to google.co.in
- DNS resolution comparison
- Traffic monitoring and analysis
- All required screenshots and data

## Output Files
- **Kernel**: `project/linux-6.16/arch/x86_64/boot/bzImage`
- **Modules**: `project/lib.tar.bz2`
- **Network Analysis**: `network-analysis/` directory
- **VM Disk**: `project/linux.qcow2`

## Troubleshooting
- See individual guides in `docs/` directory
- Check script output for specific error messages
- Ensure all prerequisites are met
- Verify sufficient disk space and memory