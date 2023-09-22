#!/bin/bash
# v0.1
# Author: Michael McEwen


# Define the directory to start from
DIR="$1"

if [ -z "$DIR" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Initialize an array with the default extensions
declare -A extensions
for ext in c cpp js py java ts jsx tsx html md json sql; do
    extensions["$ext"]=1
done

# Process files recursively
find "$DIR" -type f | while read -r file; do
    ext="${file##*.}"  # Extract the file extension

    # If the extension is not in the list, ask the user
    if [[ -z "${extensions["$ext"]}" ]]; then
        read -p "Unrecognized extension .$ext. Do you want to process this kind of file? (y/n) " answer
        case $answer in
            [Yy]* ) 
                extensions["$ext"]=1
                ;;
            * )
                # Ignore this kind of file in the future
                extensions["$ext"]=0
                continue
                ;;
        esac
    fi

    # Check if the file ends with a newline
    if [ -z "$(tail -c 2 "$file" | head -c 1)" ]; then
        echo "Skipping $file - already has a newline at the end."
    else
        echo "Adding newline to $file."
        echo "" >> "$file"
    fi
done

echo "Done processing files!"
