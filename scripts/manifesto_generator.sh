#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: Dipansh Bareja
# Course: Open Source Software (OSS) - VIT
# Description: An interactive script that generates a
#              personalized Open Source Manifesto based on
#              user inputs about their views on FOSS
# ============================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'

# Output file
OUTPUT_FILE="my_oss_manifesto.txt"

# Function for animated typing effect
type_text() {
    local text="$1"
    local delay="${2:-0.03}"

    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep "$delay"
    done
    echo ""
}

# Function to display banner
show_banner() {
    clear
    echo ""
    echo -e "${MAGENTA}    ___                      ____                         ${NC}"
    echo -e "${MAGENTA}   / _ \\ _ __   ___ _ __    / ___|  ___  _   _ _ __ ___ ___ ${NC}"
    echo -e "${MAGENTA}  | | | | '_ \\ / _ \\ '_ \\   \\___ \\ / _ \\| | | | '__/ __/ _ \\${NC}"
    echo -e "${MAGENTA}  | |_| | |_) |  __/ | | |   ___) | (_) | |_| | | | (_|  __/${NC}"
    echo -e "${MAGENTA}   \\___/| .__/ \\___|_| |_|  |____/ \\___/ \\__,_|_|  \\___\\___|${NC}"
    echo -e "${MAGENTA}        |_|                                                 ${NC}"
    echo -e "${CYAN}            M A N I F E S T O   G E N E R A T O R           ${NC}"
    echo ""
    echo -e "${BLUE}============================================================${NC}"
    echo ""
}

# Main script starts here
show_banner

echo -e "${GREEN}Welcome to the Open Source Manifesto Generator!${NC}"
echo ""
echo "This tool will help you create a personalized manifesto"
echo "expressing your beliefs about open source software."
echo ""
echo -e "${YELLOW}Answer the following questions to generate your manifesto.${NC}"
echo ""

# Collect user inputs
echo -e "${CYAN}----------------------------------------${NC}"

# Question 1: Name
echo -e "${WHITE}Question 1 of 6${NC}"
read -p "What is your name? " USER_NAME

if [ -z "$USER_NAME" ]; then
    USER_NAME="Anonymous Developer"
fi

echo ""

# Question 2: Favorite FOSS project
echo -e "${WHITE}Question 2 of 6${NC}"
echo "What is your favorite open source project?"
echo "(Examples: Firefox, Linux, Python, Git, VLC, LibreOffice)"
read -p "> " FOSS_PROJECT

if [ -z "$FOSS_PROJECT" ]; then
    FOSS_PROJECT="Firefox"
fi

echo ""

# Question 3: Why FOSS matters
echo -e "${WHITE}Question 3 of 6${NC}"
echo "Why do you think open source software matters?"
echo "Select a number:"
echo "  1) Freedom and transparency"
echo "  2) Community collaboration"
echo "  3) Learning and education"
echo "  4) Cost-effectiveness"
echo "  5) Security and privacy"
read -p "Your choice (1-5): " FOSS_REASON

case $FOSS_REASON in
    1) REASON_TEXT="because it provides freedom and transparency, allowing anyone to inspect, modify, and share the code" ;;
    2) REASON_TEXT="because it enables global community collaboration, bringing together minds from across the world" ;;
    3) REASON_TEXT="because it offers incredible learning opportunities for students and developers alike" ;;
    4) REASON_TEXT="because it makes powerful software accessible to everyone regardless of financial constraints" ;;
    5) REASON_TEXT="because transparency in code leads to better security and respect for user privacy" ;;
    *) REASON_TEXT="because it represents a movement that values sharing knowledge and building together" ;;
esac

echo ""

# Question 4: Role in FOSS
echo -e "${WHITE}Question 4 of 6${NC}"
echo "How would you like to contribute to open source?"
echo "  1) Writing code"
echo "  2) Documentation"
echo "  3) Bug reporting and testing"
echo "  4) Community support"
echo "  5) Spreading awareness"
read -p "Your choice (1-5): " CONTRIBUTION

case $CONTRIBUTION in
    1) CONTRIBUTION_TEXT="contributing code and features" ;;
    2) CONTRIBUTION_TEXT="writing documentation to help others" ;;
    3) CONTRIBUTION_TEXT="testing and reporting bugs" ;;
    4) CONTRIBUTION_TEXT="helping others in community forums" ;;
    5) CONTRIBUTION_TEXT="spreading awareness about FOSS" ;;
    *) CONTRIBUTION_TEXT="being an active community member" ;;
esac

echo ""

# Question 5: FOSS principle
echo -e "${WHITE}Question 5 of 6${NC}"
echo "Which open source principle resonates most with you?"
echo "  1) The freedom to run the program for any purpose"
echo "  2) The freedom to study and modify the source code"
echo "  3) The freedom to redistribute copies"
echo "  4) The freedom to distribute modified versions"
read -p "Your choice (1-4): " PRINCIPLE

case $PRINCIPLE in
    1) PRINCIPLE_TEXT="the freedom to run software for any purpose, without restrictions" ;;
    2) PRINCIPLE_TEXT="the freedom to study and modify source code, empowering true ownership" ;;
    3) PRINCIPLE_TEXT="the freedom to share software with others, spreading knowledge freely" ;;
    4) PRINCIPLE_TEXT="the freedom to improve software and share those improvements publicly" ;;
    *) PRINCIPLE_TEXT="the four essential freedoms that define free software" ;;
esac

echo ""

# Question 6: Personal commitment
echo -e "${WHITE}Question 6 of 6${NC}"
echo "Write a short personal statement about your commitment to FOSS:"
echo "(Press Enter for a default statement)"
read -p "> " PERSONAL_STATEMENT

if [ -z "$PERSONAL_STATEMENT" ]; then
    PERSONAL_STATEMENT="I commit to supporting, using, and promoting open source software in my daily work and studies."
fi

echo ""
echo -e "${CYAN}----------------------------------------${NC}"
echo ""
echo -e "${YELLOW}Generating your manifesto...${NC}"
sleep 1

# Generate the manifesto
MANIFESTO=$(cat << EOF
================================================================================
                        MY OPEN SOURCE MANIFESTO
================================================================================

Author: $USER_NAME
Date: $(date '+%B %d, %Y')
Favorite FOSS Project: $FOSS_PROJECT

--------------------------------------------------------------------------------
                              DECLARATION
--------------------------------------------------------------------------------

I, $USER_NAME, believe in the power of open source software.

Open source matters to me $REASON_TEXT.

My favorite open source project is $FOSS_PROJECT, which exemplifies the
spirit of collaborative development and community-driven innovation.

--------------------------------------------------------------------------------
                              MY PRINCIPLES
--------------------------------------------------------------------------------

Among all the freedoms that open source provides, I value most
$PRINCIPLE_TEXT.

I believe that software should be:
  * Transparent - Anyone can read and understand the code
  * Accessible - Available to everyone regardless of background
  * Collaborative - Built by communities, not just corporations
  * Respectful - Of user privacy and freedom

--------------------------------------------------------------------------------
                              MY COMMITMENT
--------------------------------------------------------------------------------

I pledge to contribute to the open source community by $CONTRIBUTION_TEXT.

$PERSONAL_STATEMENT

I recognize that every contribution, no matter how small, helps build
a better digital future for everyone.

--------------------------------------------------------------------------------
                              IN CLOSING
--------------------------------------------------------------------------------

"Free software is a matter of liberty, not price. To understand the concept,
you should think of 'free' as in 'free speech,' not as in 'free beer.'"
                                                    - Richard Stallman

Open source is not just a development methodology; it is a philosophy that
promotes sharing, collaboration, and the common good.

================================================================================
             Generated by Open Source Manifesto Generator v1.0
                         Firefox OSS Audit Project
================================================================================
EOF
)

# Display the manifesto
echo ""
echo -e "${GREEN}$MANIFESTO${NC}"

# Save to file
echo "$MANIFESTO" > "$OUTPUT_FILE"

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${GREEN}Manifesto saved to: $OUTPUT_FILE${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# Ask if user wants to view it again
read -p "Would you like to open the file in a text editor? (y/n): " VIEW_CHOICE

if [ "$VIEW_CHOICE" = "y" ] || [ "$VIEW_CHOICE" = "Y" ]; then
    if command -v nano &> /dev/null; then
        nano "$OUTPUT_FILE"
    elif command -v vim &> /dev/null; then
        vim "$OUTPUT_FILE"
    elif command -v vi &> /dev/null; then
        vi "$OUTPUT_FILE"
    else
        echo "No text editor found. File saved at: $OUTPUT_FILE"
    fi
fi

# Footer
echo ""
echo -e "${BLUE}Thank you for creating your Open Source Manifesto!${NC}"
echo -e "${YELLOW}Share it with others and spread the FOSS spirit.${NC}"
echo ""
