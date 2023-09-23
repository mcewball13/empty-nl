#!/bin/bash

file="$1"

if [ -z "$file" ]; then
    echo "Please provide a file to check."
    exit 1
fi

# Get the last byte of the file
last_byte=$(tail -c 1 "$file" | od -An -t x1 | tr -d ' ')

if [ "$last_byte" != "0a" ]; then
    echo "File does NOT end with a newline."
else
    echo "File ENDS with a newline."
fi
