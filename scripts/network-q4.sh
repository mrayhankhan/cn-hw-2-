#!/bin/bash

# Network Analysis Homework - Question 4: iftop

echo "=== Q4: Measuring Traffic with iftop ==="

OUTPUT_DIR="network-analysis"
mkdir -p "$OUTPUT_DIR"

echo "Traffic Analysis with iftop:" | tee "$OUTPUT_DIR/q4-analysis.txt"
echo "=============================" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "" | tee -a "$OUTPUT_DIR/q4-analysis.txt"

# Check if running as root or with sudo
if [ "$EUID" -ne 0 ]; then
    echo "This script needs to run with sudo for iftop to work properly"
    echo "Usage: sudo ./scripts/network-q4.sh"
    exit 1
fi

# Get active interface
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)
echo "Monitoring interface: $INTERFACE" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "" | tee -a "$OUTPUT_DIR/q4-analysis.txt"

echo "Instructions for iftop analysis:" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "1. Open a web browser and start streaming/browsing" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "2. iftop will run for 30 seconds to capture traffic" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "3. Take a screenshot during the monitoring period" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "4. Analyze the top 3 connections by bandwidth" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "" | tee -a "$OUTPUT_DIR/q4-analysis.txt"

echo "Starting iftop monitoring..."
echo "Press Ctrl+C to stop monitoring or wait 30 seconds"
echo ""

# Run iftop with output capture
timeout 30s iftop -i "$INTERFACE" -t -s 30 > "$OUTPUT_DIR/q4-iftop-output.txt" 2>&1 &
IFTOP_PID=$!

# Also run a text-based version for analysis
sleep 5
timeout 20s iftop -i "$INTERFACE" -t -s 20 -n > "$OUTPUT_DIR/q4-iftop-text.txt" 2>&1 &

# Wait for completion
wait $IFTOP_PID

echo ""
echo "iftop monitoring completed"

# Analyze captured data
echo "Analysis of captured traffic:" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "=============================" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "" | tee -a "$OUTPUT_DIR/q4-analysis.txt"

if [ -f "$OUTPUT_DIR/q4-iftop-text.txt" ]; then
    echo "Top connections by data transfer:" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
    # Extract connection information
    grep -E "=>" "$OUTPUT_DIR/q4-iftop-text.txt" | head -3 | while read line; do
        echo "- $line" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
    done
fi

echo "" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "Common application types that generate traffic:" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "1. Web browsing (HTTP/HTTPS) - Port 80/443" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "2. Video streaming (YouTube, Netflix) - High bandwidth" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "3. File downloads/uploads - Sustained high traffic" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "4. Software updates - Background traffic" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "5. Cloud synchronization (Dropbox, Google Drive)" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "6. Video calls (Zoom, Teams) - Bidirectional traffic" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "7. Gaming - Low latency, moderate bandwidth" | tee -a "$OUTPUT_DIR/q4-analysis.txt"

# Get current network statistics
echo "" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
echo "Current network interface statistics:" | tee -a "$OUTPUT_DIR/q4-analysis.txt"
cat /proc/net/dev | grep "$INTERFACE" | tee -a "$OUTPUT_DIR/q4-analysis.txt"

echo ""
echo "Output files created:"
echo "- $OUTPUT_DIR/q4-iftop-output.txt"
echo "- $OUTPUT_DIR/q4-iftop-text.txt"
echo "- $OUTPUT_DIR/q4-analysis.txt"
echo ""
echo "Remember to:"
echo "1. Take a screenshot of iftop while it was running"
echo "2. Identify the top 3 connections by bandwidth"
echo "3. Note the source/destination IPs and bandwidth usage"
echo "4. Analyze what applications might be generating the traffic"