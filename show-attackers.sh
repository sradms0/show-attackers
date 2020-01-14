#!/bin/bash

# This script displays IP addresses of excessive failed login attempts in a GNU/Linux system.

LOG_FILE="${1}"

# Make sure a file was supplied as an argument.
if [[ "${#}" -ne 1 ]]
then
    echo "Usage: ${0} FILE" >&2
    echo 'Display failed login attempts by IP address.'
    exit 1
fi

if [[ ! -e "${LOG_FILE}" ]]
then
    echo "${LOG_FILE} not found" >&2
    exit 1
fi

# Display the CSV header.

# Loop through the list of failed attempts and corresponding IP addresses.

# If the number of failed attempts is greater than the limit, display
