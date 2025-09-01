#!/bin/bash

# Network Analysis Homework - Question 2: traceroute and mtr

echo "=== Q2: Tracing Routes with traceroute and mtr ==="

OUTPUT_DIR="network-analysis"
mkdir -p "$OUTPUT_DIR"

TARGET="google.co.in"

echo "Running traceroute to $TARGET..."
traceroute "$TARGET" > "$OUTPUT_DIR/q2-traceroute-output.txt" 2>&1

echo "Running mtr to $TARGET..."
mtr --report --report-cycles=10 "$TARGET" > "$OUTPUT_DIR/q2-mtr-output.txt" 2>&1

echo "Route Analysis:" | tee "$OUTPUT_DIR/q2-analysis.txt"
echo "===============" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
echo "" | tee -a "$OUTPUT_DIR/q2-analysis.txt"

# Count hops in traceroute
TRACEROUTE_HOPS=$(grep -E "^ *[0-9]+" "$OUTPUT_DIR/q2-traceroute-output.txt" | wc -l)
echo "Traceroute hops: $TRACEROUTE_HOPS" | tee -a "$OUTPUT_DIR/q2-analysis.txt"

# Count hops in mtr
MTR_HOPS=$(grep -E "^ *[0-9]+\." "$OUTPUT_DIR/q2-mtr-output.txt" | wc -l)
echo "MTR hops: $MTR_HOPS" | tee -a "$OUTPUT_DIR/q2-analysis.txt"

# Check for * * * in traceroute
ASTERISK_HOPS=$(grep -c "\* \* \*" "$OUTPUT_DIR/q2-traceroute-output.txt" || true)
echo "Hops with '* * *': $ASTERISK_HOPS" | tee -a "$OUTPUT_DIR/q2-analysis.txt"

echo "" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
echo "Possible reasons for '* * *' in traceroute:" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
echo "1. Firewall blocking ICMP packets" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
echo "2. Router configured not to respond to traceroute probes" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
echo "3. Rate limiting on ICMP responses" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
echo "4. Network congestion causing packet loss" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
echo "5. Different routing paths for probe packets" | tee -a "$OUTPUT_DIR/q2-analysis.txt"

echo "" | tee -a "$OUTPUT_DIR/q2-analysis.txt"

# Get public IP and location
echo "Getting public IP and geolocation..." | tee -a "$OUTPUT_DIR/q2-analysis.txt"
PUBLIC_IP=$(curl -s https://api.ipify.org)
echo "Public IP: $PUBLIC_IP" | tee -a "$OUTPUT_DIR/q2-analysis.txt"

# Extract non-local IPs from traceroute
echo "" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
echo "Non-local IP addresses found:" | tee -a "$OUTPUT_DIR/q2-analysis.txt"

grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" "$OUTPUT_DIR/q2-traceroute-output.txt" | \
grep -v -E "^10\.|^172\.(1[6-9]|2[0-9]|3[01])\.|^192\.168\.|^127\." | \
sort -u > "$OUTPUT_DIR/q2-nonlocal-ips.txt"

if [ -s "$OUTPUT_DIR/q2-nonlocal-ips.txt" ]; then
    cat "$OUTPUT_DIR/q2-nonlocal-ips.txt" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
    
    # For each non-local IP, get whois info
    echo "" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
    echo "WHOIS information for non-local IPs:" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
    echo "====================================" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
    
    while read -r ip; do
        echo "" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
        echo "IP: $ip" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
        whois "$ip" | grep -E "^(netname|descr|NetName|OrgName):" | head -3 | tee -a "$OUTPUT_DIR/q2-analysis.txt"
    done < "$OUTPUT_DIR/q2-nonlocal-ips.txt"
else
    echo "No non-local IP addresses found in traceroute output" | tee -a "$OUTPUT_DIR/q2-analysis.txt"
fi

echo ""
echo "Output files created:"
echo "- $OUTPUT_DIR/q2-traceroute-output.txt"
echo "- $OUTPUT_DIR/q2-mtr-output.txt"
echo "- $OUTPUT_DIR/q2-analysis.txt"
echo "- $OUTPUT_DIR/q2-nonlocal-ips.txt"
echo ""
echo "Visit https://www.whatismyip.com to get your geolocation"
echo "Visit https://check-host.net for IP geolocation lookup"
echo "Take screenshots of both command outputs for your report!"