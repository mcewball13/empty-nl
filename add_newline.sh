#!/bin/bash
# v0.6
# Author: Michael McEwen

# Define the directory to start from
DIR="$1"

if [ -z "$DIR" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Extensions to be processed by default
extensions=" c cpp js py java ts jsx tsx html md json sql sh NO_EXTENSION "

# Process files recursively, skipping hidden files and directories
find "$DIR" -type f ! -path '*/\.*' | while read -r file; do
    echo "Checking: $file"
    
    basefile=$(basename "$file")
if [[ "$basefile" == *.* ]]; then
    ext="${file##*.}"  # Extract the file extension
    echo "File has an extension: .$ext"
else
    echo "File has no extension."
    ext="NO_EXTENSION"
fi


    # If it's an unrecognized extension and not a ".sh" file, ask the user
    if [[ ! $extensions =~ " $ext " ]] && [[ $ext != "sh" ]]; then
        read -p "Unrecognized extension .$ext. Do you want to process this kind of file? (y/n) " answer
        case $answer in
            [Yy]* ) 
                ;;
            * )
                # Just continue the loop, skipping this file
                echo "Skipping file due to unrecognized extension: $file"
                continue
                ;;
        esac
    fi

    # Check if the file ends with a newline
    echo "Reading last byte of $file..."
    last_byte=$(tail -c 1 "$file" | od -An -t x1 | tr -d ' ')
    echo "Obtained value for last byte: $last_byte"
    echo "Last byte of $file is: $last_byte"
    if [ "$last_byte" != "0a" ]; then
        echo "Adding newline to $file."
        echo "" >> "$file"
    else
        echo "Skipping $file - already has a newline at the end."
    fi
done

echo "Done processing files!"
