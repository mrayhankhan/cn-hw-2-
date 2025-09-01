#!/bin/bash

# Run all network analysis homework questions

echo "=== CN Homework 2: Network Tools and Analysis ==="
echo "Running all questions automatically..."
echo ""

OUTPUT_DIR="network-analysis"
mkdir -p "$OUTPUT_DIR"

# Question 1: ifconfig
echo "Running Question 1: ifconfig analysis..."
./scripts/network-q1.sh
echo "✓ Q1 completed"
echo ""

# Question 2: traceroute and mtr
echo "Running Question 2: traceroute and mtr analysis..."
./scripts/network-q2.sh
echo "✓ Q2 completed"
echo ""

# Question 3: nslookup and dig
echo "Running Question 3: DNS analysis..."
./scripts/network-q3.sh
echo "✓ Q3 completed"
echo ""

# Question 4: iftop (requires sudo)
echo "Question 4 requires sudo privileges for iftop..."
echo "Run manually: sudo ./scripts/network-q4.sh"
echo ""

# Generate summary report
echo "=== Network Analysis Summary Report ===" > "$OUTPUT_DIR/homework-report.md"
echo "Generated on: $(date)" >> "$OUTPUT_DIR/homework-report.md"
echo "" >> "$OUTPUT_DIR/homework-report.md"

echo "## Q1: Network Interfaces (ifconfig)" >> "$OUTPUT_DIR/homework-report.md"
echo "- Output file: q1-ifconfig-output.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Analysis: q1-analysis.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Screenshot required: ifconfig command output" >> "$OUTPUT_DIR/homework-report.md"
echo "" >> "$OUTPUT_DIR/homework-report.md"

echo "## Q2: Route Tracing (traceroute/mtr)" >> "$OUTPUT_DIR/homework-report.md"
echo "- Output files: q2-traceroute-output.txt, q2-mtr-output.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Analysis: q2-analysis.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Non-local IPs: q2-nonlocal-ips.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Screenshots required: traceroute and mtr outputs" >> "$OUTPUT_DIR/homework-report.md"
echo "- Manual tasks: Visit whatismyip.com and check-host.net" >> "$OUTPUT_DIR/homework-report.md"
echo "" >> "$OUTPUT_DIR/homework-report.md"

echo "## Q3: DNS Analysis (nslookup/dig)" >> "$OUTPUT_DIR/homework-report.md"
echo "- Output files: q3-nslookup-output.txt, q3-dig-output.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Analysis: q3-analysis.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Authoritative NS query: q3-auth-query.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Screenshots required: nslookup and dig outputs" >> "$OUTPUT_DIR/homework-report.md"
echo "- Manual task: Test IP address in browser" >> "$OUTPUT_DIR/homework-report.md"
echo "" >> "$OUTPUT_DIR/homework-report.md"

echo "## Q4: Traffic Analysis (iftop)" >> "$OUTPUT_DIR/homework-report.md"
echo "- Run manually with: sudo ./scripts/network-q4.sh" >> "$OUTPUT_DIR/homework-report.md"
echo "- Output files: q4-iftop-output.txt, q4-analysis.txt" >> "$OUTPUT_DIR/homework-report.md"
echo "- Screenshot required: iftop running with traffic" >> "$OUTPUT_DIR/homework-report.md"
echo "" >> "$OUTPUT_DIR/homework-report.md"

echo "=== All Questions Completed (except Q4) ==="
echo ""
echo "Generated files in $OUTPUT_DIR/:"
ls -la "$OUTPUT_DIR/"
echo ""
echo "Summary report: $OUTPUT_DIR/homework-report.md"
echo ""
echo "Next steps:"
echo "1. Run Q4 manually: sudo ./scripts/network-q4.sh"
echo "2. Take required screenshots"
echo "3. Complete manual tasks (IP lookups, browser test)"
echo "4. Compile your final report for submission"