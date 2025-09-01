# Network Tools and Analysis Homework Guide

## Overview
This guide helps you complete the network tools and analysis homework with automated scripts and detailed instructions.

## Questions Covered
1. **Q1**: Exploring Network Interfaces with ifconfig (5 marks)
2. **Q2**: Tracing Routes with traceroute and mtr (5 marks) 
3. **Q3**: DNS Analysis with nslookup and dig (5 marks)
4. **Q4**: Measuring Traffic with iftop (5 marks)

## Quick Start

### Run All Questions (Automated)
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Run automated analysis
./scripts/run-network-homework.sh

# Run Q4 manually (requires sudo)
sudo ./scripts/network-q4.sh
```

### Individual Questions
```bash
# Question 1: ifconfig
./scripts/network-q1.sh

# Question 2: traceroute and mtr
./scripts/network-q2.sh

# Question 3: nslookup and dig
./scripts/network-q3.sh

# Question 4: iftop (requires sudo)
sudo ./scripts/network-q4.sh
```

## Detailed Instructions

### Q1: Network Interfaces (ifconfig)
**Automated Output:**
- `q1-ifconfig-output.txt` - Full ifconfig output
- `q1-analysis.txt` - Parsed interface details

**Required for Report:**
- Screenshot of ifconfig output
- List of all network interfaces
- Active interface details (IP, MAC, RX/TX stats)

### Q2: Route Tracing (traceroute/mtr)
**Automated Output:**
- `q2-traceroute-output.txt` - traceroute to google.co.in
- `q2-mtr-output.txt` - mtr report to google.co.in
- `q2-analysis.txt` - Hop count analysis and explanations
- `q2-nonlocal-ips.txt` - Non-local IP addresses found

**Required for Report:**
- Screenshots of both traceroute and mtr outputs
- Number of hops observed
- Explanation of "* * *" entries
- Geolocation of your IP (visit whatismyip.com)
- Geolocation of non-local IPs (use check-host.net)

**Manual Tasks:**
1. Visit https://www.whatismyip.com to get your IP geolocation
2. Use https://check-host.net to lookup geolocation of non-local IPs
3. Run `whois <ip>` for netname/descr of non-local IPs

### Q3: DNS Analysis (nslookup/dig)
**Automated Output:**
- `q3-nslookup-output.txt` - nslookup google.com
- `q3-dig-output.txt` - dig google.com
- `q3-ns-output.txt` - Authoritative nameservers
- `q3-auth-query.txt` - Direct query to authoritative NS
- `q3-analysis.txt` - Comparison and analysis

**Required for Report:**
- Screenshots of nslookup and dig outputs
- Comparison of IP addresses returned
- Screenshot of authoritative nameserver query
- Browser test results using IP address

**Manual Tasks:**
1. Test the first IP address in your browser
2. Note if it opens Google's homepage
3. Document any redirects or security warnings

### Q4: Traffic Analysis (iftop)
**Automated Output:**
- `q4-iftop-output.txt` - iftop monitoring data
- `q4-iftop-text.txt` - Text-based traffic analysis
- `q4-analysis.txt` - Traffic pattern analysis

**Required for Report:**
- Screenshot of iftop running with active traffic
- Top 3 connections by bandwidth
- Source/destination IPs and usage
- Analysis of application types

**Manual Tasks:**
1. Start browsing/streaming before running iftop
2. Take screenshot during monitoring
3. Identify traffic patterns and applications

## Output Files Location
All output files are saved in: `network-analysis/`

## Report Compilation

### Required Screenshots
1. **Q1**: ifconfig command output
2. **Q2**: traceroute and mtr outputs (2 screenshots)
3. **Q3**: nslookup, dig, and authoritative NS query (3 screenshots)
4. **Q4**: iftop running with traffic

### Required Manual Research
1. **Q2**: Your IP geolocation from whatismyip.com
2. **Q2**: Non-local IP geolocations from check-host.net
3. **Q3**: Browser test with Google's IP address
4. **Q4**: Traffic pattern analysis

### Analysis Points to Include
- Network interface configuration
- Route hop analysis and explanations
- DNS resolution comparison
- Traffic patterns and applications

## Troubleshooting

### Permission Issues
```bash
# If iftop fails
sudo ./scripts/network-q4.sh

# If network tools are missing
sudo apt install net-tools traceroute mtr-tiny dnsutils iftop
```

### No Non-local IPs Found
- This is possible in some network configurations
- Document this in your report
- Explain the network setup (NAT, corporate network, etc.)

### DNS Resolution Issues
- Try alternative DNS servers
- Check network connectivity
- Document any issues in the report

## Final Submission
1. Compile all screenshots
2. Include analysis from output files
3. Add manual research results
4. Submit complete report to Google Classroom
5. Ensure all group members submit