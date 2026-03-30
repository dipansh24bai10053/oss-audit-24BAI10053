#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Dipansh Bareja
# Course: Open Source Software (OSS) - VIT
# Description: Inspects installed packages on the system and
#              checks for FOSS software including Firefox
#              Works on Debian/Ubuntu based systems
# ============================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_header() {
    echo ""
    echo -e "${CYAN}========================================${NC}"
    echo -e "${GREEN}  $1${NC}"
    echo -e "${CYAN}========================================${NC}"
}

print_status() {
    if [ "$2" = "found" ]; then
        echo -e "${GREEN}[+]${NC} $1"
    elif [ "$2" = "missing" ]; then
        echo -e "${RED}[-]${NC} $1"
    else
        echo -e "${YELLOW}[*]${NC} $1"
    fi
}

# Function to describe a package using case statement
describe_package() {
    local pkg=$1
    case "$pkg" in
        vim)
            echo "Vim: Highly configurable text editor for efficient code editing"
            ;;
        git)
            echo "Git: Distributed version control system for tracking code changes"
            ;;
        python3)
            echo "Python3: Versatile programming language for diverse applications"
            ;;
        gcc)
            echo "GCC: GNU Compiler Collection for compiling C/C++ programs"
            ;;
        make)
            echo "Make: Build automation tool for managing project compilation"
            ;;
        curl)
            echo "curl: Command-line tool for transferring data with URLs"
            ;;
        wget)
            echo "wget: Tool for downloading files from the web"
            ;;
        nano)
            echo "nano: Simple text editor for quick file editing"
            ;;
        openssh)
            echo "OpenSSH: Secure Shell for remote system access and management"
            ;;
        apache2)
            echo "Apache2: Web server serving web content over HTTP/HTTPS"
            ;;
        nginx)
            echo "Nginx: High-performance web server and reverse proxy"
            ;;
        mysql)
            echo "MySQL: Relational database management system"
            ;;
        postgresql)
            echo "PostgreSQL: Advanced relational database with SQL capabilities"
            ;;
        nodejs)
            echo "Node.js: JavaScript runtime for server-side development"
            ;;
        firefox)
            echo "Firefox: A nonprofit fighting for an open web"
            ;;
        *)
            echo "$pkg: FOSS software package"
            ;;
    esac
}

# Main script
clear
echo ""
echo -e "${GREEN}*********************************************${NC}"
echo -e "${GREEN}*        FOSS PACKAGE INSPECTOR             *${NC}"
echo -e "${GREEN}*        Firefox OSS Audit Project          *${NC}"
echo -e "${GREEN}*********************************************${NC}"

# Detect package manager
print_header "Detecting Package Manager"

PKG_MANAGER=""
PKG_LIST_CMD=""
PKG_COUNT_CMD=""

if command -v apt &> /dev/null; then
    PKG_MANAGER="apt (Debian/Ubuntu)"
    PKG_LIST_CMD="dpkg --get-selections"
    PKG_COUNT_CMD="dpkg --get-selections | wc -l"
    print_status "Package Manager: $PKG_MANAGER" "found"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf (Fedora/RHEL)"
    PKG_LIST_CMD="dnf list installed"
    PKG_COUNT_CMD="dnf list installed | wc -l"
    print_status "Package Manager: $PKG_MANAGER" "found"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman (Arch Linux)"
    PKG_LIST_CMD="pacman -Q"
    PKG_COUNT_CMD="pacman -Q | wc -l"
    print_status "Package Manager: $PKG_MANAGER" "found"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum (CentOS/RHEL)"
    PKG_LIST_CMD="yum list installed"
    PKG_COUNT_CMD="yum list installed | wc -l"
    print_status "Package Manager: $PKG_MANAGER" "found"
else
    print_status "No supported package manager found" "missing"
    echo "This script supports: apt, dnf, pacman, yum"
    exit 1
fi

# Package Statistics
print_header "Package Statistics"

TOTAL_PACKAGES=$(eval $PKG_COUNT_CMD 2>/dev/null)
echo -e "${YELLOW}Total installed packages:${NC} $TOTAL_PACKAGES"

# Check for Firefox specifically
print_header "Firefox Installation Check"

# Try different ways to detect Firefox
FIREFOX_FOUND=0
FIREFOX_VERSION=""

# Method 1: Check using which command
if command -v firefox &> /dev/null; then
    FIREFOX_FOUND=1
    FIREFOX_PATH=$(which firefox)
    print_status "Firefox binary found at: $FIREFOX_PATH" "found"
fi

# Method 2: Check package manager
if command -v dpkg &> /dev/null; then
    if dpkg -l | grep -qi "firefox"; then
        FIREFOX_FOUND=1
        FIREFOX_VERSION=$(dpkg -l | grep -i firefox | head -1 | awk '{print $3}')
    fi
elif command -v rpm &> /dev/null; then
    if rpm -qa | grep -qi "firefox"; then
        FIREFOX_FOUND=1
        FIREFOX_VERSION=$(rpm -qa | grep -i firefox | head -1)
    fi
fi

# Method 3: Check common install locations
if [ -f /usr/bin/firefox ] || [ -f /usr/lib/firefox/firefox ] || [ -f /snap/bin/firefox ]; then
    FIREFOX_FOUND=1
fi

if [ $FIREFOX_FOUND -eq 1 ]; then
    print_status "Firefox is INSTALLED on this system" "found"

    # Try to get version
    if command -v firefox &> /dev/null; then
        FIREFOX_VERSION=$(firefox --version 2>/dev/null | head -1)
    fi

    if [ -n "$FIREFOX_VERSION" ]; then
        echo -e "${YELLOW}Version:${NC} $FIREFOX_VERSION"
    fi

    # Display Firefox info
    echo ""
    echo -e "${CYAN}--- Firefox Information ---${NC}"
    echo -e "${YELLOW}License:${NC} Mozilla Public License 2.0 (MPL-2.0)"
    echo -e "${YELLOW}Developer:${NC} Mozilla Foundation"
    echo -e "${YELLOW}Type:${NC} Web Browser"
    echo -e "${YELLOW}First Release:${NC} November 2004"
    echo -e "${YELLOW}Repository:${NC} https://hg.mozilla.org/mozilla-central"
else
    print_status "Firefox is NOT installed on this system" "missing"
    echo ""
    echo "To install Firefox on Debian/Ubuntu:"
    echo "  sudo apt update && sudo apt install firefox"
fi

# List other common FOSS packages
print_header "Other FOSS Software Check"

# Array of common FOSS packages to check
declare -a FOSS_PACKAGES=("vim" "git" "python3" "gcc" "make" "curl" "wget" "nano" "openssh" "apache2" "nginx" "mysql" "postgresql" "nodejs")

FOSS_COUNT=0
echo "Checking for common FOSS packages..."
echo ""

for pkg in "${FOSS_PACKAGES[@]}"; do
    if command -v $pkg &> /dev/null; then
        VERSION=$($pkg --version 2>/dev/null | head -1 | cut -d' ' -f1-3)
        print_status "$pkg - Installed" "found"
        echo "  └─ $(describe_package "$pkg")"
        ((FOSS_COUNT++))
    fi
done

echo ""
echo -e "${YELLOW}Found ${GREEN}$FOSS_COUNT${YELLOW} out of ${#FOSS_PACKAGES[@]} common FOSS packages${NC}"

# FOSS Percentage estimate
print_header "FOSS Analysis"

echo "On a typical Linux system, majority of packages are FOSS."
echo ""
echo -e "${CYAN}Common FOSS Licenses found in Linux packages:${NC}"
echo "  - GPL (GNU General Public License)"
echo "  - MIT License"
echo "  - Apache License 2.0"
echo "  - BSD License"
echo "  - MPL (Mozilla Public License)"
echo "  - LGPL (Lesser GPL)"
echo ""

# Estimate FOSS percentage (on Linux, almost everything is FOSS)
FOSS_PERCENT=95
echo -e "${GREEN}Estimated FOSS packages: ~${FOSS_PERCENT}%${NC}"
echo "(Linux distributions are built primarily on open source software)"

# Output file option
print_header "Export Package List"

read -p "Do you want to export the full package list to a file? (y/n): " EXPORT_CHOICE

if [ "$EXPORT_CHOICE" = "y" ] || [ "$EXPORT_CHOICE" = "Y" ]; then
    OUTPUT_FILE="package_list_$(date +%Y%m%d_%H%M%S).txt"
    eval $PKG_LIST_CMD > "$OUTPUT_FILE" 2>/dev/null
    print_status "Package list exported to: $OUTPUT_FILE" "found"
else
    echo "Skipping export."
fi

# Footer
echo ""
echo -e "${BLUE}----------------------------------------------${NC}"
echo -e "${GREEN}Inspection completed on: $(date)${NC}"
echo -e "${BLUE}----------------------------------------------${NC}"
echo ""
