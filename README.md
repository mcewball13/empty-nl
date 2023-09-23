# New Line Checker

**Version**: v0.5.1beta  
**Author**: Michael McEwen

## Description

New Line Checker is a handy script designed to verify if your files end with a newline, ensuring adherence to a common coding standard. It can automatically add newlines to those that don't have them, and remove any trailing whitespace or empty lines at the end of files. The script will log its actions, providing an efficient way to track which files were modified.

## Features

- Supports various file extensions like `.c`, `.cpp`, `.js`, `.py`, `.java`, and many more.

- Ability to ask the user for guidance on unlisted file extensions or files with no extensions.

- Skips processing hidden files and directories (e.g., `.git`).

- Excludes processing the `node_modules` directory.

- Creates a detailed log with a timestamp at `~/newline_whitespace_log.txt`.

## Installation

### Prerequisites

Ensure you have `Python 3` installed on your machine.

### Steps

1. Clone the repository or download the script `newline_checker.py`.

    ```bash
    git clone [REPOSITORY_URL]
    ```

2. Navigate to the directory containing the script.

3. You're ready to go!

## Usage

To check a specific directory and process its files, navigate to the directory containing the `newline_checker.py` script and run:

```bash
python3 newline_checker.py [DIRECTORY_PATH]
```

Replace `[DIRECTORY_PATH]` with the path to the directory you wish to check.

For example, to check the current directory:

```bash
python3 newline_checker.py .
```

## Supported Platforms

- Windows
- macOS
- Linux

## License

This project is licensed under the MIT License. See the `LICENSE` file in the repository for the full license text.
