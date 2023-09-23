import os
import sys

def get_last_byte(file_path):
    with open(file_path, 'rb') as f:
        f.seek(-1, os.SEEK_END)  # Go to the last byte.
        return f.read(1)

def main(directory):
    NEWLINES_ADDED = 0  # Counter for newlines added

    extensions = ["c", "cpp", "js", "py", "java", "ts", "jsx", "tsx", "html", "md", "json", "sql", "sh"]
    user_choices = {}

    for root, dirs, files in os.walk(directory):
        # Skip 'node_modules' and '.git' directories
        if 'node_modules' in dirs:
            dirs.remove('node_modules')
        if '.git' in dirs:
            dirs.remove('.git')

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

            if last_byte.hex() != "0a":
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
