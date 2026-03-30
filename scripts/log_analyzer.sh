f#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Dipansh Bareja
# Course: Open Source Software (OSS) - VIT
# Description: Analyzes system log files and categorizes
#              messages by severity (errors, warnings, info)
#              Useful for system monitoring and debugging
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
    echo -e "${CYAN}========================================${NC}"
    echo -e "${GREEN}  $1${NC}"
    echo -e "${CYAN}========================================${NC}"
}

# Variables to store counts
ERROR_COUNT=0
WARNING_COUNT=0
INFO_COUNT=0
CRITICAL_COUNT=0

# Function to find available log file
find_log_file() {
    # Try different log file locations based on distro
    if [ -f /var/log/syslog ]; then
        echo "/var/log/syslog"
    elif [ -f /var/log/messages ]; then
        echo "/var/log/messages"
    elif [ -f /var/log/journal ]; then
        echo "/var/log/journal"
    else
        echo ""
    fi
}

# Function to analyze a log file using while-read loop
analyze_log() {
    local LOG_FILE=$1
    local LOG_NAME=$(basename "$LOG_FILE")

    echo ""
    echo -e "${YELLOW}Analyzing: $LOG_FILE${NC}"
    echo ""

    if [ ! -r "$LOG_FILE" ]; then
        echo -e "${RED}Cannot read $LOG_FILE (try running with sudo)${NC}"
        return 1
    fi

    # Initialize counters
    local ERRORS=0
    local WARNINGS=0
    local INFO=0
    local CRITICAL=0
    local FAILED=0
    local TOTAL_LINES=0

    # Count different severity levels using while-read loop
    while IFS= read -r line; do
        ((TOTAL_LINES++))

        # Case statement to categorize log entries
        case "${line,,}" in
            *error*)
                ((ERRORS++))
                ;;
            *critical*|*crit*|*fatal*|*panic*)
                ((CRITICAL++))
                ;;
            *warning*|*warn*)
                ((WARNINGS++))
                ;;
            *info*)
                ((INFO++))
                ;;
            *failed*|*failure*)
                ((FAILED++))
                ;;
        esac
    done < "$LOG_FILE"

    # Display statistics
    echo -e "${MAGENTA}--- Statistics for $LOG_NAME ---${NC}"
    echo ""
    printf "%-20s : %s\n" "Total Lines" "$TOTAL_LINES"
    printf "%-20s : ${RED}%s${NC}\n" "Errors" "${ERRORS:-0}"
    printf "%-20s : ${YELLOW}%s${NC}\n" "Warnings" "${WARNINGS:-0}"
    printf "%-20s : ${GREEN}%s${NC}\n" "Info" "${INFO:-0}"
    printf "%-20s : ${RED}%s${NC}\n" "Critical/Fatal" "${CRITICAL:-0}"
    printf "%-20s : ${YELLOW}%s${NC}\n" "Failed Events" "${FAILED:-0}"

    # Update global counts
    ERROR_COUNT=$((ERROR_COUNT + ERRORS))
    WARNING_COUNT=$((WARNING_COUNT + WARNINGS))
    INFO_COUNT=$((INFO_COUNT + INFO))
    CRITICAL_COUNT=$((CRITICAL_COUNT + CRITICAL))
}

# Function to show recent errors
show_recent_errors() {
    local LOG_FILE=$1

    print_header "Recent Errors (Last 10)"

    if [ -r "$LOG_FILE" ]; then
        RECENT_ERRORS=$(grep -i "error" "$LOG_FILE" 2>/dev/null | tail -10)

        if [ -n "$RECENT_ERRORS" ]; then
            echo "$RECENT_ERRORS" | while IFS= read -r line; do
                echo -e "${RED}>>>${NC} $line"
            done
        else
            echo -e "${GREEN}No errors found in log file${NC}"
        fi
    else
        echo "Log file not readable"
    fi
}

# Function to show recent warnings
show_recent_warnings() {
    local LOG_FILE=$1

    print_header "Recent Warnings (Last 10)"

    if [ -r "$LOG_FILE" ]; then
        RECENT_WARNINGS=$(grep -iE "warning|warn" "$LOG_FILE" 2>/dev/null | tail -10)

        if [ -n "$RECENT_WARNINGS" ]; then
            echo "$RECENT_WARNINGS" | while IFS= read -r line; do
                echo -e "${YELLOW}>>>${NC} $line"
            done
        else
            echo -e "${GREEN}No warnings found in log file${NC}"
        fi
    else
        echo "Log file not readable"
    fi
}

# Function to analyze auth log for security
analyze_auth_log() {
    print_header "Authentication Log Analysis"

    AUTH_LOG=""
    if [ -f /var/log/auth.log ]; then
        AUTH_LOG="/var/log/auth.log"
    elif [ -f /var/log/secure ]; then
        AUTH_LOG="/var/log/secure"
    fi

    if [ -n "$AUTH_LOG" ] && [ -r "$AUTH_LOG" ]; then
        echo -e "${YELLOW}Analyzing: $AUTH_LOG${NC}"
        echo ""

        # Count successful logins
        SUCCESS_LOGIN=$(grep -ci "session opened\|accepted" "$AUTH_LOG" 2>/dev/null)
        # Count failed logins
        FAILED_LOGIN=$(grep -ci "authentication failure\|failed password" "$AUTH_LOG" 2>/dev/null)
        # Count sudo usage
        SUDO_USE=$(grep -ci "sudo:" "$AUTH_LOG" 2>/dev/null)

        printf "%-25s : ${GREEN}%s${NC}\n" "Successful Sessions" "${SUCCESS_LOGIN:-0}"
        printf "%-25s : ${RED}%s${NC}\n" "Failed Authentications" "${FAILED_LOGIN:-0}"
        printf "%-25s : ${YELLOW}%s${NC}\n" "Sudo Commands" "${SUDO_USE:-0}"

        # Security warning for many failed logins
        if [ "${FAILED_LOGIN:-0}" -gt 50 ]; then
            echo ""
            echo -e "${RED}[SECURITY WARNING] High number of failed login attempts detected!${NC}"
            echo "This could indicate a brute-force attack attempt."
        fi
    else
        echo "Auth log not accessible (try running with sudo)"
    fi
}

# Function to check journalctl if available
check_journalctl() {
    print_header "Systemd Journal (journalctl)"

    if command -v journalctl &> /dev/null; then
        echo -e "${YELLOW}Boot error summary (this boot):${NC}"
        echo ""

        # Get priority levels: 0=emerg, 1=alert, 2=crit, 3=err
        journalctl -b -p 3 --no-pager 2>/dev/null | tail -15

        echo ""
        echo -e "${CYAN}Priority counts for current boot:${NC}"

        JOURNAL_ERRORS=$(journalctl -b -p err --no-pager 2>/dev/null | wc -l)
        JOURNAL_WARNINGS=$(journalctl -b -p warning --no-pager 2>/dev/null | wc -l)

        printf "%-15s : ${RED}%s${NC}\n" "Errors" "$JOURNAL_ERRORS"
        printf "%-15s : ${YELLOW}%s${NC}\n" "Warnings" "$JOURNAL_WARNINGS"
    else
        echo "journalctl not available on this system"
    fi
}

# Function to generate summary
generate_summary() {
    print_header "Analysis Summary"

    echo -e "${MAGENTA}Overall Log Health Assessment:${NC}"
    echo ""

    # Simple health score based on error counts
    if [ "$CRITICAL_COUNT" -gt 0 ] || [ "$ERROR_COUNT" -gt 100 ]; then
        echo -e "${RED}Status: NEEDS ATTENTION${NC}"
        echo "Multiple critical errors or high error count detected."
    elif [ "$ERROR_COUNT" -gt 50 ]; then
        echo -e "${YELLOW}Status: MODERATE${NC}"
        echo "Some errors present, may require investigation."
    else
        echo -e "${GREEN}Status: HEALTHY${NC}"
        echo "System logs appear normal."
    fi

    echo ""
    echo -e "${CYAN}Totals across analyzed logs:${NC}"
    printf "%-15s : ${RED}%s${NC}\n" "Errors" "$ERROR_COUNT"
    printf "%-15s : ${YELLOW}%s${NC}\n" "Warnings" "$WARNING_COUNT"
    printf "%-15s : ${GREEN}%s${NC}\n" "Info" "$INFO_COUNT"
    printf "%-15s : ${RED}%s${NC}\n" "Critical" "$CRITICAL_COUNT"
}

# Main execution
clear
echo ""
echo -e "${GREEN}*********************************************${NC}"
echo -e "${GREEN}*         LOG FILE ANALYZER                *${NC}"
echo -e "${GREEN}*         Firefox OSS Audit Project        *${NC}"
echo -e "${GREEN}*********************************************${NC}"
echo ""
echo "This tool analyzes system logs to identify errors,"
echo "warnings, and security-related events."
echo ""
echo -e "${YELLOW}Note: Some logs require root/sudo access${NC}"

# Check if log file was provided as command-line argument
if [ -z "$1" ]; then
    echo ""
    echo -e "${RED}Error: Log file not provided${NC}"
    echo "Usage: $0 <log_file>"
    echo ""
    echo "Example: $0 /var/log/syslog"
    echo "         $0 /var/log/messages"
    exit 1
fi

MAIN_LOG="$1"

# Find and analyze main system log
print_header "System Log Analysis"

if [ -n "$MAIN_LOG" ]; then
    analyze_log "$MAIN_LOG"
    show_recent_errors "$MAIN_LOG"
    show_recent_warnings "$MAIN_LOG"
else
    echo "Log file not found: $MAIN_LOG"
fi

# Check journalctl
check_journalctl

# Check authentication logs
analyze_auth_log

# Generate summary
generate_summary

# Option to save report
print_header "Export Options"

read -p "Save this analysis to a file? (y/n): " SAVE_CHOICE

if [ "$SAVE_CHOICE" = "y" ] || [ "$SAVE_CHOICE" = "Y" ]; then
    REPORT_FILE="log_analysis_$(date +%Y%m%d_%H%M%S).txt"

    {
        echo "Log Analysis Report"
        echo "Generated: $(date)"
        echo "========================"
        echo ""
        echo "Error Count: $ERROR_COUNT"
        echo "Warning Count: $WARNING_COUNT"
        echo "Info Count: $INFO_COUNT"
        echo "Critical Count: $CRITICAL_COUNT"
        echo ""
        echo "Analysis completed successfully."
    } > "$REPORT_FILE"

    echo -e "${GREEN}Report saved to: $REPORT_FILE${NC}"
fi

# Footer
echo ""
echo -e "${BLUE}----------------------------------------------${NC}"
echo -e "${GREEN}Analysis completed on: $(date)${NC}"
echo -e "${BLUE}----------------------------------------------${NC}"
echo ""
