#!/bin/bash

# This script displays IP addresses of excessive failed login attempts in a GNU/Linux system.

LOG_FILE="${1}"
ATTEMPT_THRESHOLD='10'

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

# Display the CSV header, and failed attempts exceeding threshold
echo 'Count,IP,Location'
grep 'Failed' "${LOG_FILE}" | awk '{print $(NF - 3)}' | sort -n | uniq -c | sort -nr |
while read LINE
do
    COUNT=$(echo "${LINE}" | awk '{print $1}')
    IP=$(echo "${LINE}" | awk '{print $2}')
    if [[ "${COUNT}" -gt "${ATTEMPT_THRESHOLD}" ]]
    then
        COUNTRY=$(geoiplookup "${IP}" | awk -F ', ' '{print $NF}')
        echo "${COUNT},${IP},${COUNTRY}"
    fi
done 
