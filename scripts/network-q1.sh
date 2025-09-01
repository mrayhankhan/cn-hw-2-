#!/bin/bash

# Network Analysis Homework - Question 1: ifconfig

echo "=== Q1: Exploring Network Interfaces with ifconfig ==="

OUTPUT_DIR="network-analysis"
mkdir -p "$OUTPUT_DIR"

echo "Running ifconfig command..."
ifconfig > "$OUTPUT_DIR/q1-ifconfig-output.txt"

echo "Network Interface Analysis:" | tee "$OUTPUT_DIR/q1-analysis.txt"
echo "===========================" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
echo "" | tee -a "$OUTPUT_DIR/q1-analysis.txt"

# Parse ifconfig output
echo "Available Network Interfaces:" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
ifconfig | grep "^[a-zA-Z]" | awk '{print "- " $1}' | tee -a "$OUTPUT_DIR/q1-analysis.txt"

echo "" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
echo "Active Interface Details:" | tee -a "$OUTPUT_DIR/q1-analysis.txt"

# Find active interface (usually the one with an IP that's not 127.0.0.1)
ACTIVE_INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)

if [ -n "$ACTIVE_INTERFACE" ]; then
    echo "Interface: $ACTIVE_INTERFACE" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
    
    # Get IPv4 address
    IPV4=$(ifconfig "$ACTIVE_INTERFACE" | grep "inet " | awk '{print $2}')
    echo "IPv4 Address: $IPV4" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
    
    # Get IPv6 address
    IPV6=$(ifconfig "$ACTIVE_INTERFACE" | grep "inet6" | grep -v "::1" | awk '{print $2}' | head -1)
    if [ -n "$IPV6" ]; then
        echo "IPv6 Address: $IPV6" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
    else
        echo "IPv6 Address: Not available" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
    fi
    
    # Get MAC address
    MAC=$(ifconfig "$ACTIVE_INTERFACE" | grep "ether" | awk '{print $2}')
    echo "MAC Address: $MAC" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
    
    # Get RX/TX statistics
    RX_PACKETS=$(ifconfig "$ACTIVE_INTERFACE" | grep "RX packets" | awk '{print $3}')
    RX_ERRORS=$(ifconfig "$ACTIVE_INTERFACE" | grep "RX packets" | awk '{print $5}')
    TX_PACKETS=$(ifconfig "$ACTIVE_INTERFACE" | grep "TX packets" | awk '{print $3}')
    TX_ERRORS=$(ifconfig "$ACTIVE_INTERFACE" | grep "TX packets" | awk '{print $5}')
    
    echo "RX Packets: $RX_PACKETS" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
    echo "RX Errors: $RX_ERRORS" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
    echo "TX Packets: $TX_PACKETS" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
    echo "TX Errors: $TX_ERRORS" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
else
    echo "Could not determine active interface" | tee -a "$OUTPUT_DIR/q1-analysis.txt"
fi

echo ""
echo "Output saved to $OUTPUT_DIR/q1-ifconfig-output.txt"
echo "Analysis saved to $OUTPUT_DIR/q1-analysis.txt"
echo ""
echo "Take a screenshot of the ifconfig output for your report!"