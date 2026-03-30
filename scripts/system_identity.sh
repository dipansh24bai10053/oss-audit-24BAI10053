#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Dipansh Bareja
# Course: Open Source Software (OSS) - VIT
# Description: Gathers and displays system information
#              This helps understand the Linux environment where
#              Firefox and other FOSS tools run
# ============================================================

# Colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo ""
    echo -e "${BLUE}======================================${NC}"
    echo -e "${GREEN}  $1${NC}"
    echo -e "${BLUE}======================================${NC}"
}

# Function to print key-value pairs nicely
print_info() {
    printf "${YELLOW}%-20s${NC}: %s\n" "$1" "$2"
}

# Main script starts here
clear
echo ""
echo -e "${GREEN}*********************************************${NC}"
echo -e "${GREEN}*       SYSTEM IDENTITY REPORT              *${NC}"
echo -e "${GREEN}*       Firefox OSS Audit Project           *${NC}"
echo -e "${GREEN}*********************************************${NC}"

# Operating System Information
print_header "OPERATING SYSTEM INFO"

# Get OS name - works on most Linux distros
if [ -f /etc/os-release ]; then
    OS_NAME=$(grep "^PRETTY_NAME" /etc/os-release | cut -d'"' -f2)
else
    OS_NAME=$(uname -o)
fi
print_info "OS Name" "$OS_NAME"

# Kernel version
KERNEL_VER=$(uname -r)
print_info "Kernel Version" "$KERNEL_VER"

# Architecture
ARCH=$(uname -m)
print_info "Architecture" "$ARCH"

# Current shell
print_info "Shell" "$SHELL"

# Hostname
print_info "Hostname" "$(hostname)"

# System Uptime and Time
print_header "TIME AND UPTIME"

# Current date and time
print_info "Current Date" "$(date '+%d-%m-%Y')"
print_info "Current Time" "$(date '+%H:%M:%S')"
print_info "Timezone" "$(date '+%Z')"

# Uptime - formatted nicely
if command -v uptime &> /dev/null; then
    UPTIME_INFO=$(uptime -p 2>/dev/null || uptime)
    print_info "System Uptime" "$UPTIME_INFO"
fi

# User Information
print_header "USER INFORMATION"

print_info "Current User" "$(whoami)"
print_info "User ID" "$(id -u)"
print_info "Group ID" "$(id -g)"
print_info "Home Directory" "$HOME"

# Network Information
print_header "NETWORK INFORMATION"

# Get primary IP address
if command -v ip &> /dev/null; then
    IP_ADDR=$(ip route get 1 2>/dev/null | awk '{print $7; exit}')
    if [ -z "$IP_ADDR" ]; then
        IP_ADDR=$(hostname -I 2>/dev/null | awk '{print $1}')
    fi
else
    IP_ADDR=$(hostname -I 2>/dev/null | awk '{print $1}')
fi
print_info "IP Address" "${IP_ADDR:-Not available}"

# Get MAC address of primary interface
if command -v ip &> /dev/null; then
    MAC_ADDR=$(ip link show 2>/dev/null | awk '/ether/{print $2; exit}')
fi
print_info "MAC Address" "${MAC_ADDR:-Not available}"

# DNS servers
if [ -f /etc/resolv.conf ]; then
    DNS_SERVER=$(grep "^nameserver" /etc/resolv.conf | head -1 | awk '{print $2}')
    print_info "DNS Server" "${DNS_SERVER:-Not configured}"
fi

# Disk Usage Summary
print_header "DISK USAGE SUMMARY"

# Show disk usage of root partition
df -h / 2>/dev/null | tail -1 | awk '{
    printf "Root Partition   : %s used of %s (%s)\n", $3, $2, $5
}'

# Total disk space across all partitions
TOTAL_DISK=$(df -h --total 2>/dev/null | tail -1 | awk '{print $2}')
USED_DISK=$(df -h --total 2>/dev/null | tail -1 | awk '{print $3}')
print_info "Total Disk Space" "${TOTAL_DISK:-N/A}"
print_info "Used Space" "${USED_DISK:-N/A}"

# Memory Information
print_header "MEMORY INFORMATION"

if command -v free &> /dev/null; then
    free -h | awk '/^Mem:/ {
        printf "Total Memory     : %s\n", $2
        printf "Used Memory      : %s\n", $3
        printf "Free Memory      : %s\n", $4
    }'
fi

# Operating System License Information
print_header "OPERATING SYSTEM LICENSE"

echo -e "${CYAN}Open Source License Information:${NC}"
echo ""
echo -e "${YELLOW}The Linux kernel is licensed under the:${NC}"
echo -e "${GREEN}GNU General Public License v2 (GPLv2)${NC}"
echo ""
echo "The GPLv2 ensures that the Linux kernel source code remains free"
echo "and open for anyone to use, modify, and distribute."

# Footer
echo ""
echo -e "${BLUE}----------------------------------------------${NC}"
echo -e "${GREEN}Report generated on: $(date)${NC}"
echo -e "${BLUE}----------------------------------------------${NC}"
echo ""
