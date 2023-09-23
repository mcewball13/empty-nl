#!/bin/bash
# v0.1
# Author: Michael McEwen


# Define the directory to start from
DIR="$1"

if [ -z "$DIR" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Initial extensions
extensions=" c cpp js py java ts jsx tsx html md json sql "

# Process files recursively, skipping hidden files and directories
find "$DIR" -type f ! -path '*/\.*' | while read -r file; do
    echo "Checking: $file"
    
    ext="${file##*.}"  # Extract the file extension

    # Process files without an extension separately
    if [[ "$file" == "$ext" ]]; then
        ext="NO_EXTENSION"
    fi

    # If the extension is not in the list, ask the user
    if [[ ! $extensions =~ " $ext " ]]; then
        read -p "Unrecognized extension .$ext. Do you want to process this kind of file? (y/n) " answer
        case $answer in
            [Yy]* ) 
                extensions="$extensions$ext "
                ;;
            * )
                # To avoid asking about this extension again, add it but prefix with '!'
                extensions="$extensions!$ext "
                continue
                ;;
        esac
    elif [[ $extensions =~ " !$ext " ]]; then
        # Skip extensions we've previously chosen to ignore
        continue
    fi

    # Check if the file ends with a newline
    last_char=$(tail -c 1 "$file")

if [ "$last_char" != $'\n' ]; then
    echo "Adding newline to $file."
    echo "" >> "$file"
else
    echo "Skipping $file - already has a newline at the end."
fi

done

echo "Done processing files!"
# Path: add_newline.sh
