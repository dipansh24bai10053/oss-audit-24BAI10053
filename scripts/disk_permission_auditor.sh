#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Dipansh Bareja
# Course: Open Source Software (OSS) - VIT
# Description: Audits disk usage and checks for files with
#              potentially risky permissions (world-writable,
#              SUID/SGID bits, etc.)
# ============================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

print_header() {
    echo ""
    echo -e "${MAGENTA}========================================${NC}"
    echo -e "${GREEN}  $1${NC}"
    echo -e "${MAGENTA}========================================${NC}"
}

print_warning() {
    echo -e "${RED}[WARNING]${NC} $1"
}

print_info() {
    echo -e "${CYAN}[INFO]${NC} $1"
}

print_ok() {
    echo -e "${GREEN}[OK]${NC} $1"
}

# Functions for disk analysis
check_disk_usage() {
    print_header "Disk Usage Analysis"

    echo -e "${YELLOW}Filesystem usage breakdown:${NC}"
    echo ""

    # Show disk usage with human readable sizes
    df -h --output=source,fstype,size,used,avail,pcent,target 2>/dev/null | head -20

    echo ""

    # Check for partitions with high usage
    echo -e "${YELLOW}Checking for partitions with high usage (>80%):${NC}"
    echo ""

    HIGH_USAGE=$(df -h | awk 'NR>1 {gsub(/%/,"",$5); if($5+0 > 80) print $0}')

    if [ -n "$HIGH_USAGE" ]; then
        echo "$HIGH_USAGE" | while read line; do
            print_warning "$line"
        done
    else
        print_ok "No partitions are above 80% usage"
    fi
}

check_large_directories() {
    print_header "Largest Directories"

    echo -e "${YELLOW}Top 10 largest directories in /home (if accessible):${NC}"
    echo ""

    if [ -d "$HOME" ]; then
        du -ah "$HOME" 2>/dev/null | sort -rh | head -10
    else
        echo "Home directory not accessible"
    fi

    echo ""
    echo -e "${YELLOW}Top 10 largest directories in /var (may need sudo):${NC}"
    echo ""

    du -ah /var 2>/dev/null | sort -rh | head -10 || echo "Cannot access /var (try running with sudo)"
}

check_world_writable() {
    print_header "World-Writable Files Check"

    echo -e "${YELLOW}Searching for world-writable files in common directories...${NC}"
    echo "(This checks /tmp, /var/tmp, and current user's home)"
    echo ""

    # Check /tmp
    WW_TMP=$(find /tmp -type f -perm -0002 2>/dev/null | head -20)
    if [ -n "$WW_TMP" ]; then
        echo -e "${RED}World-writable files in /tmp:${NC}"
        echo "$WW_TMP"
    else
        print_ok "No world-writable files found in /tmp"
    fi

    echo ""

    # Check home directory
    WW_HOME=$(find "$HOME" -type f -perm -0002 2>/dev/null | head -10)
    if [ -n "$WW_HOME" ]; then
        print_warning "World-writable files found in home directory:"
        echo "$WW_HOME"
    else
        print_ok "No world-writable files in home directory"
    fi
}

check_suid_sgid() {
    print_header "SUID/SGID Files Check"

    echo -e "${YELLOW}SUID (Set User ID) and SGID (Set Group ID) files can be${NC}"
    echo -e "${YELLOW}security risks if misconfigured. Checking common locations...${NC}"
    echo ""

    # Check for SUID files in /usr/bin
    echo -e "${CYAN}SUID files in /usr/bin:${NC}"
    SUID_FILES=$(find /usr/bin -type f -perm -4000 2>/dev/null | head -15)

    if [ -n "$SUID_FILES" ]; then
        echo "$SUID_FILES" | while read file; do
            ls -l "$file" 2>/dev/null
        done
    else
        echo "No SUID files found (or no access)"
    fi

    echo ""

    # Check for SGID files
    echo -e "${CYAN}SGID files in /usr/bin:${NC}"
    SGID_FILES=$(find /usr/bin -type f -perm -2000 2>/dev/null | head -15)

    if [ -n "$SGID_FILES" ]; then
        echo "$SGID_FILES" | while read file; do
            ls -l "$file" 2>/dev/null
        done
    else
        echo "No SGID files found (or no access)"
    fi
}

check_file_permissions() {
    print_header "Critical File Permissions"

    echo -e "${YELLOW}Checking permissions of important system files:${NC}"
    echo ""

    # Array of critical files to check
    declare -a CRITICAL_FILES=(
        "/etc/passwd"
        "/etc/shadow"
        "/etc/group"
        "/etc/sudoers"
        "/etc/ssh/sshd_config"
    )

    for file in "${CRITICAL_FILES[@]}"; do
        if [ -f "$file" ]; then
            PERMS=$(stat -c "%a %U:%G" "$file" 2>/dev/null)
            printf "%-25s : %s\n" "$file" "$PERMS"
        else
            printf "%-25s : ${RED}Not found${NC}\n" "$file"
        fi
    done

    echo ""

    # Check /etc/passwd specifically - should be readable but not writable
    if [ -f /etc/passwd ]; then
        PASSWD_PERMS=$(stat -c "%a" /etc/passwd)
        if [ "$PASSWD_PERMS" = "644" ]; then
            print_ok "/etc/passwd has correct permissions (644)"
        else
            print_warning "/etc/passwd has non-standard permissions: $PASSWD_PERMS"
        fi
    fi

    # Check /etc/shadow - should only be readable by root
    if [ -f /etc/shadow ]; then
        if [ -r /etc/shadow ]; then
            print_warning "Current user can read /etc/shadow (running as root?)"
        else
            print_ok "/etc/shadow is properly protected"
        fi
    fi
}

generate_security_summary() {
    print_header "Security Summary"

    echo -e "${CYAN}Recommendations for maintaining secure file permissions:${NC}"
    echo ""
    echo "1. Avoid world-writable files (chmod o-w)"
    echo "2. Limit SUID/SGID files to only necessary binaries"
    echo "3. Keep /etc/shadow readable only by root (000 or 640)"
    echo "4. Regularly audit file permissions with scripts like this"
    echo "5. Use the principle of least privilege"
    echo ""
    echo -e "${YELLOW}For Firefox specifically:${NC}"
    echo "- Firefox profile folder should be user-readable only"
    echo "- Check: ls -la ~/.mozilla/firefox/"
    echo "- Extensions and plugins should come from trusted sources"
}

# Main execution
clear
echo ""
echo -e "${GREEN}*********************************************${NC}"
echo -e "${GREEN}*     DISK AND PERMISSION AUDITOR          *${NC}"
echo -e "${GREEN}*     Firefox OSS Audit Project            *${NC}"
echo -e "${GREEN}*********************************************${NC}"

# Run all checks
check_disk_usage
check_large_directories
check_world_writable
check_suid_sgid
check_file_permissions
generate_security_summary

# Footer
echo ""
echo -e "${BLUE}----------------------------------------------${NC}"
echo -e "${GREEN}Audit completed on: $(date)${NC}"
echo -e "${BLUE}----------------------------------------------${NC}"
echo ""
