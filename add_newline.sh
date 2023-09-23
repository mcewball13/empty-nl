#!/bin/bash
# v1.2.1
# Author: Michael McEwen

# Define the directory to start from
DIR="$1"
NEWLINES_ADDED=0  # Counter for newlines added

if [ -z "$DIR" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Extensions to be processed by default
extensions=" c cpp js py java ts jsx tsx html md json sql sh "

declare -A user_choices

# Process files recursively, skipping hidden files and directories
while read -r file <&3; do
    echo "Checking: $file"
    
    basefile=$(basename "$file")
    if [[ "$basefile" == *.* ]]; then
        ext="${file##*.}"  # Extract the file extension
        echo "File has an extension: .$ext"
    else
        echo "File has no extension."
        ext="NO_EXTENSION"
    fi

    # If it's an unrecognized extension, ask the user
    if [[ ! $extensions =~ " $ext " ]]; then
        if [[ -z ${user_choices[$ext]} ]]; then
            echo -e "\033[33mUnrecognized extension .$ext. Do you want to process this kind of file? (y/n) \033[0m\c"
            read -r answer
            user_choices[$ext]=$answer
        else
            answer=${user_choices[$ext]}
        fi

        if [[ ! $answer =~ ^[Yy]$ ]]; then
            # Just continue the loop, skipping this file
            echo "Skipping file due to unrecognized extension: $file"
            continue
        fi
    fi

    # Check if the file ends with a newline
    echo "Reading last byte of $file..."
    last_byte=$(tail -c 1 "$file" | od -An -t x1 | tr -d ' ')
    echo "Obtained value for last byte: $last_byte"
    echo "Last byte of $file is: $last_byte"
    if [ "$last_byte" != "0a" ]; then
        echo -e "\033[32mAdding newline to $file.\033[0m"  # Green text for added newline
        echo "" >> "$file"
        NEWLINES_ADDED=$((NEWLINES_ADDED+1))  # Increment the counter
    else
        echo "Skipping $file - already has a newline at the end."
    fi

done 3< <(find "$DIR" -type d -name 'node_modules' -prune -o -type f ! -path '*/\.*' -print)

echo "Done processing files!"
echo "$NEWLINES_ADDED newlines were added."