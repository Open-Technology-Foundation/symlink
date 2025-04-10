# Symlink Utility

![Version](https://img.shields.io/badge/Version-1.3.5-blue.svg)
![License](https://img.shields.io/badge/License-GPL--3.0-green.svg)

A robust Bash utility that manages executable files by creating symbolic links in `/usr/local/bin`, making them accessible system-wide via the command line. This tool is designed for system administrators who need to maintain collections of scripts and executables across multiple project directories.

## Version 1.3.5 Highlights

- **Fixed Hanging Issues**: Eliminated hanging issues in broken symlink cleanup and file scanning
- **Improved Non-Interactive Mode**: Auto-detects non-interactive use and adjusts behavior appropriately
- **Enhanced Critical File Safety**: Added special handling for critical system files in all modes
- **Better Error Handling**: More reliable detection and recovery from errors
- **Enhanced Debug Mode**: Comprehensive logging with detailed troubleshooting information
- **Batch Processing**: Efficient handling of multiple .symlink files with progress tracking
- **Improved Documentation**: Expanded help output and clearer option descriptions
- **Better Permission Handling**: Improved sudo elevation with proper environment preservation

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

- **Recursive Scanning**: Find `.symlink` configuration files throughout directory trees
- **Batch Processing**: Create multiple symlinks efficiently with batched operations
- **Individual File Support**: Create symlinks for specific executable files
- **Automatic Permissions**: Handle permission elevation with sudo transparently
- **Interactive Control**: Manage existing symlinks with optional user prompts
- **Safety Measures**: Prevent accidental overwriting of critical system files
- **Maintenance Tools**: Clean up broken symlinks in target directories
- **Flexible Output**: Choose between verbose, quiet, or debug output modes
- **Dry-Run Mode**: Preview operations without making actual changes
- **Advanced Debugging**: Comprehensive logging with detailed diagnostic information
- **Batched Operations**: Efficiently process large numbers of symlink files
- **Progress Tracking**: Keep track of operation progress with detailed status updates

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

1. Clone this repository or download the script:
   ```bash
   git clone https://github.com/user/symlink.git
   cd symlink
   ```

2. Make the script executable:
   ```bash
   chmod +x ./symlink
   ```

3. Optionally, make the script itself available system-wide:
   ```bash
   sudo ./symlink ./symlink
   ```

4. Verify installation:
   ```bash
   symlink --version
   ```

### Quick Install
For a quick one-line installation:
```bash
curl -Lo /tmp/symlink https://raw.githubusercontent.com/user/symlink/main/symlink && chmod +x /tmp/symlink && sudo /tmp/symlink /tmp/symlink && symlink --version
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

## Command-Line Options

| Option | Long Form | Description |
|--------|-----------|-------------|
| `-S` | `--scan-symlink` | Scan for `.symlink` files and process them (primary mode) |
| `-P` | `--no-prompt` | Skip confirmation when removing existing symlinks |
| `-d` | `--delete-broken-symlinks` | Clean up broken symlinks in `/usr/local/bin` |
| `-l` | `--list` | List contents of all `.symlink` files without creating symlinks |
| `-n` | `--dry-run` | Show what would happen without making changes |
| `-v` | `--verbose` | Show detailed output (default) |
| `-q` | `--quiet` | Suppress informational messages |
| `-V` | `--version` | Show version information |
| `-h` | `--help` | Show help message |
| | `--debug` | Enable debug mode with detailed logging |

**Tip:** Options can be combined, such as `-SPd` for a no-prompt scan with broken link cleanup.

## Requirements

- **Bash 4.0+**: Uses modern Bash features like arrays and parameter expansion
- **Root Privileges**: Required for writing to system directories (auto-elevates with sudo)
- **Write Access**: Needs permission to create files in `/usr/local/bin`
- **Find Utility**: For recursive scanning of directories
- **Readlink**: For resolving symbolic links and absolute paths

## Exit Codes

The script uses standardized exit codes to communicate the result of operations:

- `0`: Success
- `1`: General error
- `2`: Permission denied
- `3`: File not found
- `22`: Invalid option
- `50`: No symlink files found

## Environment Variables

### Debug Mode

For troubleshooting, enable debug mode with the `--debug` flag or by setting the `SYMLINK_DEBUG` environment variable:

```bash
# Using flag
symlink --debug -SPd /path/to/scripts

# Using environment variable
SYMLINK_DEBUG=1 symlink -SPd /path/to/scripts
```

Debug logs are written to a temporary file: `/tmp/symlink-trace-<username>-<pid>.log`

### Critical Files Override

By default, critical system files (like `bash`, `sh`, etc.) are protected even in non-interactive mode. To override this behavior in automated scripts, set the `SYMLINK_FORCE_CRITICAL` environment variable:

```bash
# Force replacement of critical system files in non-interactive mode
SYMLINK_FORCE_CRITICAL=1 symlink -SP /path/to/script
```

**Caution:** Use this option with extreme care - replacing critical system files can break your system.

The debug log contains comprehensive information including:
- Command-line arguments
- Sudo privilege detection and handling
- Step-by-step operation traces
- File path resolution details
- Symlink creation process
- Batch processing information
- Exit status and error conditions

To view the log in real-time while the script is running:
```bash
tail -f /tmp/symlink-trace-*.log
```

## License

[GPL-3.0](LICENSE) - GNU General Public License v3.0

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Changelog

### Version 1.3.5
- Fixed critical hanging issue in broken symlink cleanup
- Replaced 'find' command with pure Bash approach for symlink detection
- Added auto-detection of non-interactive usage (via [[ -t 0 ]])
- Improved handling of critical system files with additional safety measures
- Enhanced error handling for both interactive and non-interactive modes
- Added SYMLINK_FORCE_CRITICAL environment variable for advanced usage
- Made prompting behavior consistent across all operation modes
- Improved reliability of symlink detection by directly checking file properties

### Version 1.3.4
- Removed unsafe error handling practices that could mask failures
- Completely rewrote core functions to avoid disabling error trapping
- Improved reliability by handling command failures properly
- Enhanced error reporting for better troubleshooting
- Fixed potential issues with error propagation

### Version 1.3.3
- Completely rewrote directory scanning logic to prevent hanging
- Changed from unlimited recursion to depth-limited approaches
- Added safety checks when operating in or near target directory
- Implemented direct file checks instead of find in risky locations
- Added additional timeouts for find operations

### Version 1.3.2
- Fixed critical recursion issues that caused infinite hanging
- Improved find command usage to prevent recursion into target directories
- Limited search depth for broken symlinks to prevent traversal issues
- Added better handling of directory path relationships to prevent loops
- Enhanced directory path detection to handle special cases

### Version 1.3.1
- Added timeouts to prevent infinite hanging on path resolution
- Improved error handling for path resolution edge cases
- Enhanced handling of inaccessible directories

### Version 1.3.0
- Added detailed debug mode with comprehensive logging
- Improved error handling and recovery
- Implemented batch processing for multiple .symlink files
- Enhanced documentation and help output
- Fixed sudo elevation issues
- Added progress tracking for operations

### Version 1.2.0
- Added support for dry-run mode
- Improved handling of critical system files
- Enhanced error reporting

### Version 1.1.0 
- Added support for .symlink files
- Implemented recursive directory scanning
- Added broken symlink cleanup