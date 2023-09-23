import os
import sys

def get_last_byte(file_path):
    with open(file_path, 'rb') as f:
        f.seek(-1, os.SEEK_END)  # Go to the last byte.
        return f.read(1)

def remove_trailing_whitespace_and_check(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()

    # If no lines or last line is not whitespace, return False
    if not lines or lines[-1].strip() != '':
        return False

    # Remove trailing empty lines or lines with only whitespace
    while lines and lines[-1].strip() == '':
        lines.pop()

    with open(file_path, 'w') as f:
        f.writelines(lines)
    
    return True


def main(directory):
    NEWLINES_ADDED = 0  # Counter for newlines added

    extensions = ["c", "cpp", "js", "py", "java", "ts", "jsx", "tsx", "html", "md", "json", "sql", "sh"]
    user_choices = {}

    for root, dirs, files in os.walk(directory):
        # Skip directories starting with '.' including '.git' and 'node_modules'
        if any(dir.startswith('.') for dir in dirs):
            dirs[:] = [dir for dir in dirs if not dir.startswith('.')]
        
        # This will ensure we don't process hidden directories or their contents
        if '/.' in root:
            continue

        for file in files:
            # Skip hidden files
            if file.startswith('.'):
                continue

            file_path = os.path.join(root, file)
            print(f"Checking: {file_path}")
            
            ext = file.split('.')[-1] if '.' in file else "NO_EXTENSION"
            print(f"File has an extension: .{ext}" if ext != "NO_EXTENSION" else "File has no extension.")
            
            process_file = False  # Flag to determine whether to process the file

            if ext == "NO_EXTENSION":
                # Always ask for files with no extension
                answer = input(f"\033[33mFile has no extension. Do you want to process this file? (y/n) \033[0m")
                process_file = answer.lower() == "y"
            elif ext in extensions:
                process_file = True
            elif ext not in extensions:
                if ext not in user_choices:
                    answer = input(f"\033[33mUnrecognized extension .{ext}. Do you want to process this kind of file? (y/n) \033[0m")
                    user_choices[ext] = answer
                else:
                    answer = user_choices[ext]

                process_file = answer.lower() == "y"


            if not process_file:
                print(f"Skipping file: {file_path}")
                continue

            last_byte = get_last_byte(file_path)
            print(f"Last byte of {file_path} is: {last_byte.hex()}")

           # If trailing whitespace was removed, inform the user and continue
            if remove_trailing_whitespace_and_check(file_path):
                print(f"\033[31mWhitespace removed from the end of {file_path}.\033[0m")  # Red text for removed whitespace
                continue

            # If no newline at the end, add one
            if get_last_byte(file_path).hex() != "0a":
                print(f"\033[32mAdding newline to {file_path}.\033[0m")  # Green text for added newline
                try:
                    with open(file_path, 'a') as f:
                        f.write('\n')
                    NEWLINES_ADDED += 1
                except PermissionError:
                    print(f"\033[31mPermission denied for {file_path}. Skipping...\033[0m")
            else:
                print(f"Skipping {file_path} - already has a newline at the end.")




    print("Done processing files!")
    print(f"{NEWLINES_ADDED} newlines were added.")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 newline_checker.py <directory>")
        sys.exit(1)

    main(sys.argv[1])
