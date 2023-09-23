# Add Newline Script

This script ensures that files end with a newline character. It recursively checks all files in a directory, and if a file does not end with a newline, it adds one. This is especially useful for developers, as many coding standards and tools prefer or require files to end with a newline.

## Features

- Supports various file extensions by default.
- Prompts user for unrecognized file extensions.
- Skips hidden files and directories.
- Recursive: Processes files in the specified directory and its subdirectories.
- Provides visual feedback during processing.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Installation

### Step-by-step Instructions

1. **Clone the Repository**  
   Use the following command to clone the repository:

   ```bash
   git clone https://github.com/mcewball13/empty-nl
   ```

   Alternatively, download and extract the ZIP file from the GitHub repository.

2. **Navigate to the Directory**

   ```bash
   cd <path-to-your-directory>/empty-nl
   ```

3. **Make the Script Executable**  

   ```bash
   chmod +x add_newline.sh
   ```

4. **(Optional) Add to System Path**  

   a. Move the script to a directory in your PATH, like `/usr/local/bin/`:

   ```bash
   mv add_newline.sh /usr/local/bin/
   ```

   OR

   b. Add the script's directory to your PATH:

   ```bash
   echo 'export PATH="$PATH:/path-to-your-directory/your-repo-name"' >> ~/.bashrc
   source ~/.bashrc
   ```

   (replace `.bashrc` with whatever file your shell uses for configuration)

5. **Complete!**  
   The script is now ready for use.

## Usage

To use the script, navigate to the terminal and type:

```bash
add_newline.sh <directory>
```

Replace `<directory>` with the path to the directory you want to process.

## Contributing

Feel free to fork the repository and submit pull requests for any improvements or features you'd like to add. Please ensure that your code is clean and well-commented.

## License

This script is released under the MIT License. See the `LICENSE` file for more details.
