#!/bin/bash

# WARNING
#
# This script is not meant to be run directly.
#
# Source this file in other scripts to utilize these variables.


# Get the width and height of the current virtual terminal window.
TERMINAL_ROWS=$(stty size | cut --delimiter=' ' --fields=1)
TERMINAL_COLS=$(stty size | cut --delimiter=' ' --fields=2)
VTVIEW_WIDTH_DEFAULT=${TERMINAL_COLS}
COLUMN_WIDTH_DEFAULT=32
INDENT_WIDTH_DEFAULT=2

# Initialize the terminal colors.
PASS='2' # Green   : Pass, OK
FAIL='1' # Red     : Fail, Error
WARN='5' # Magenta : Warning
VERB='3' # Brown   : Verbose
HIGH='6' # Cyan    : Highlight
NOOP='4' # Blue    : No operation

# Use tput to insert ANSI control codes.
if [ "$(command -v tput)" ]; then
    PASS=$(tput setaf ${PASS}) # Pass, OK
    FAIL=$(tput setaf ${FAIL}) # Fail, Error
    WARN=$(tput setaf ${WARN}) # Warning
    VERB=$(tput setaf ${VERB}) # Verbose
    HIGH=$(tput setaf ${HIGH}) # Highlight
    NOOP=$(tput setaf ${NOOP}) # No operation
    BOLD=$(tput bold)          # Bold text
    RSET=$(tput sgr0)          # Reset terminal colors
    CLRS=$(tput clear)         # Clear the screen

# Fall back to hard-coded ANSI escape codes.
else
    PASS=$(echo -e "\e[3${PASS}m") # Pass, OK
    FAIL=$(echo -e "\e[3${FAIL}m") # Fail, Error
    WARN=$(echo -e "\e[3${WARN}m") # Warning
    VERB=$(echo -e "\e[3${VERB}m") # Verbose
    HIGH=$(echo -e "\e[3${HIGH}m") # Highlight
    NOOP=$(echo -e "\e[3${NOOP}m") # No operation
    BOLD=$(echo -e "\e[1m")        # Bold text
    RSET=$(echo -e "\e[0m")        # Reset terminal colors
    CLRS=$(echo -e "\e[2J")        # Clear the screen

fi

# Set the ASCII line string for the console output.
LINE_ASCII_CONSOLE=$(printf '_%.0s' $(seq $VTVIEW_WIDTH_DEFAULT))
