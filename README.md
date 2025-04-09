# Symlink Utility

A robust Bash utility that manages executable files by creating symbolic links in `/usr/local/bin`, making them accessible system-wide via the command line. This tool is designed for system administrators who need to maintain collections of scripts and executables across multiple project directories.

## Primary Use Case: The `.symlink` File System

The most important usage of `symlink` is to manage script availability through `.symlink` configuration files. System administrators create `.symlink` files in project directories, listing executable files that should be available system-wide. The `symlink` utility then processes these files to create the appropriate symlinks.

A common administrative task would be:

```bash
sudo symlink -SPd /ai/scripts
```

This command:
- Scans through the `/ai/scripts` directory tree recursively looking for `.symlink` files
- Creates symlinks in `/usr/local/bin` for each executable listed in those files
- Skips confirmation prompts when replacing existing symlinks (-P option)
- Cleans up any broken symlinks in `/usr/local/bin` (-d option)

## Features

- Scan directories recursively for `.symlink` configuration files
- Batch-create symlinks for executables listed in `.symlink` files
- Create symlinks for individual executable files
- Automatically handle permission elevation with sudo
- Manage existing symlinks with optional user prompts
- Check for critical system files to prevent accidental overwriting
- Clean up broken symlinks in target directory
- Verbose or quiet output options
- Dry-run mode to preview changes without making them
- Debug mode for troubleshooting with detailed logs

## The `.symlink` File Format

Create a `.symlink` file in any project directory containing a list of executable files:

```
# This is a comment
# Each line lists a script file that should be available system-wide
script1
tools/script2
bin/tool3
```

Key points:
- Each file path should be relative to the `.symlink` file's location
- Empty lines and lines starting with `#` are ignored
- Files must be executable
- Absolute paths can be used but are generally discouraged

## Installation

1. Clone this repository or download the script
2. Make the script executable:
   ```bash
   chmod +x ./symlink
   ```
3. Optionally, make the script itself available system-wide:
   ```bash
   sudo ./symlink ./symlink
   ```

## Usage Examples

### Process `.symlink` Files (Primary Usage)

Scan a directory and all subdirectories for `.symlink` files and process them:

```bash
# Most common usage pattern for system administrators
sudo symlink -SPd /ai/scripts

# Scan current directory without prompt and clean broken links
sudo symlink -SPd

# Scan a specific project directory with prompts
sudo symlink -S /path/to/project
```

### List `.symlink` Files

View the contents of all `.symlink` files without creating symlinks:

```bash
symlink -l /path/to/projects
```

### Individual File Symlinking

Create a symlink for a specific executable file (less common usage):

```bash
sudo symlink /path/to/my/script
```

Create symlinks for multiple files:

```bash
sudo symlink /path/to/script1 /path/to/script2
```

## Options

- `-S, --scan-symlink`: Scan for `.symlink` files and process them (primary mode)
- `-P, --no-prompt`: Skip confirmation when removing existing symlinks
- `-d, --delete-broken-symlinks`: Clean up broken symlinks in `/usr/local/bin`
- `-l, --list`: List contents of all `.symlink` files without creating symlinks
- `-n, --dry-run`: Show what would happen without making changes
- `-v, --verbose`: Show detailed output (default)
- `-q, --quiet`: Suppress informational messages
- `-V, --version`: Show version information
- `-h, --help`: Show help message
- `--debug`: Enable debug mode with detailed logging

## Requirements

- Bash 4.0+
- Root privileges (will auto-elevate with sudo if needed)
- Write access to `/usr/local/bin`

## Exit Codes

The script uses standardized exit codes to communicate the result of operations:

- `0`: Success
- `1`: General error
- `2`: Permission denied
- `3`: File not found
- `22`: Invalid option
- `50`: No symlink files found

## Debug Mode

For troubleshooting, enable debug mode with the `--debug` flag or by setting the `SYMLINK_DEBUG` environment variable:

```bash
# Using flag
symlink --debug -SPd /path/to/scripts

# Using environment variable
SYMLINK_DEBUG=1 symlink -SPd /path/to/scripts
```

Debug logs are written to a temporary file: `/tmp/symlink-trace-<username>-<pid>.log`

## License

[GPL-3.0](LICENSE) - GNU General Public License v3.0