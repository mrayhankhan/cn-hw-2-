#!/bin/bash

# Network Analysis Homework - Question 3: nslookup and dig

echo "=== Q3: DNS Analysis with nslookup and dig ==="

OUTPUT_DIR="network-analysis"
mkdir -p "$OUTPUT_DIR"

TARGET="google.com"

echo "Running nslookup for $TARGET..."
nslookup "$TARGET" > "$OUTPUT_DIR/q3-nslookup-output.txt" 2>&1

echo "Running dig for $TARGET..."
dig "$TARGET" > "$OUTPUT_DIR/q3-dig-output.txt" 2>&1

echo "DNS Analysis:" | tee "$OUTPUT_DIR/q3-analysis.txt"
echo "=============" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
echo "" | tee -a "$OUTPUT_DIR/q3-analysis.txt"

# Extract IP addresses from nslookup
echo "IP addresses from nslookup:" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
grep -A 10 "Non-authoritative answer" "$OUTPUT_DIR/q3-nslookup-output.txt" | \
grep "Address:" | awk '{print $2}' | tee -a "$OUTPUT_DIR/q3-analysis.txt"

echo "" | tee -a "$OUTPUT_DIR/q3-analysis.txt"

# Extract IP addresses from dig
echo "IP addresses from dig:" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
grep -A 5 "ANSWER SECTION" "$OUTPUT_DIR/q3-dig-output.txt" | \
grep -E "IN\s+A\s+" | awk '{print $5}' | tee -a "$OUTPUT_DIR/q3-analysis.txt"

# Get authoritative nameservers
echo "" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
echo "Finding authoritative nameservers..." | tee -a "$OUTPUT_DIR/q3-analysis.txt"
nslookup -type=NS "$TARGET" > "$OUTPUT_DIR/q3-ns-output.txt" 2>&1

echo "Authoritative nameservers for $TARGET:" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
grep "nameserver" "$OUTPUT_DIR/q3-ns-output.txt" | awk '{print $4}' | tee -a "$OUTPUT_DIR/q3-analysis.txt"

# Get IP of first authoritative nameserver
NS_NAME=$(grep "nameserver" "$OUTPUT_DIR/q3-ns-output.txt" | head -1 | awk '{print $4}')
if [ -n "$NS_NAME" ]; then
    echo "" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    echo "Getting IP of nameserver: $NS_NAME" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    NS_IP=$(nslookup "$NS_NAME" | grep "Address:" | tail -1 | awk '{print $2}')
    echo "Nameserver IP: $NS_IP" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    
    # Query the authoritative nameserver directly
    echo "" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    echo "Querying authoritative nameserver directly..." | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    nslookup "$TARGET" "$NS_IP" > "$OUTPUT_DIR/q3-auth-query.txt" 2>&1
    
    echo "Response from authoritative nameserver:" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    grep "Address:" "$OUTPUT_DIR/q3-auth-query.txt" | tail -n +2 | awk '{print $2}' | tee -a "$OUTPUT_DIR/q3-analysis.txt"
fi

# Compare results
echo "" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
echo "Comparison Analysis:" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
echo "===================" | tee -a "$OUTPUT_DIR/q3-analysis.txt"

NSLOOKUP_IPS=$(grep -A 10 "Non-authoritative answer" "$OUTPUT_DIR/q3-nslookup-output.txt" | grep "Address:" | wc -l)
DIG_IPS=$(grep -A 5 "ANSWER SECTION" "$OUTPUT_DIR/q3-dig-output.txt" | grep -E "IN\s+A\s+" | wc -l)

echo "Number of IPs from nslookup: $NSLOOKUP_IPS" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
echo "Number of IPs from dig: $DIG_IPS" | tee -a "$OUTPUT_DIR/q3-analysis.txt"

# Get first IP for browser test
FIRST_IP=$(grep -A 10 "Non-authoritative answer" "$OUTPUT_DIR/q3-nslookup-output.txt" | grep "Address:" | head -1 | awk '{print $2}')
if [ -n "$FIRST_IP" ]; then
    echo "" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    echo "First IP address: $FIRST_IP" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    echo "Test this IP in browser: http://$FIRST_IP" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
    echo "Note: Google may redirect to HTTPS and show security warnings" | tee -a "$OUTPUT_DIR/q3-analysis.txt"
fi

echo ""
echo "Output files created:"
echo "- $OUTPUT_DIR/q3-nslookup-output.txt"
echo "- $OUTPUT_DIR/q3-dig-output.txt"
echo "- $OUTPUT_DIR/q3-ns-output.txt"
echo "- $OUTPUT_DIR/q3-auth-query.txt"
echo "- $OUTPUT_DIR/q3-analysis.txt"
echo ""
echo "Take screenshots of nslookup and dig outputs for your report!"
if [ -n "$FIRST_IP" ]; then
    echo "Test the IP $FIRST_IP in your browser and note the results"
fi