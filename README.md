# Symlink Utility

![Version](https://img.shields.io/badge/Version-1.3.7-blue.svg)
![License](https://img.shields.io/badge/License-GPL--3.0-green.svg)

A Bash utility that creates symbolic links in `/usr/local/bin` for executables, making them accessible system-wide. Designed for system administrators managing scripts across multiple directories, with built-in safety features and batch processing capabilities.

## Primary Use Case: The `.symlink` File System

The key feature of `symlink` is managing executables through `.symlink` configuration files. Create a `.symlink` file in any project directory listing executables that should be available system-wide:

```
# This is a comment
script1
tools/script2
bin/tool3
```

Process all `.symlink` files in a directory tree with one command:

```bash
sudo symlink -SPd /my/scripts
```

This:
- Scans `/my/scripts` for `.symlink` files (safely limited to depth 5)
- Creates symlinks in `/usr/local/bin` for each listed executable
- Skips prompts when replacing existing symlinks (-P)
- Cleans up broken symlinks (-d)
- Automatically handles privileged operations via sudo

## Features

- **`.symlink` File Processing**: Central feature for managing multiple executables
- **Batch Processing**: Efficiently creates multiple symlinks in a single operation
- **Automatic Permissions**: Handles sudo elevation transparently
- **Interactive Detection**: Auto-detects terminal interactivity and adjusts prompting
- **Safety Measures**: Prevents overwriting critical system files without confirmation
- **Timeout Protection**: Prevents hanging during path resolution operations
- **Scan Depth Limiting**: Restricts directory scanning to safe depths (5 levels)
- **Broken Link Cleanup**: Optional cleaning of dead symlinks in target directories
- **Flexible Output**: Verbose, quiet, and debug output modes with color support
- **Dry-Run Mode**: Preview operations without making changes
- **Smart Summary**: Reports created, replaced, skipped, and error links

## `.symlink` File Format

```
# Comment line
script1
tools/script2
bin/tool3
```

- Paths should be relative to the `.symlink` file location
- Empty lines and lines starting with `#` are ignored
- Leading/trailing whitespace is automatically trimmed
- Files must be executable and accessible
- Processing fails safely if files don't exist or aren't executable

## Installation

```bash
# Clone repository
git clone https://github.com/user/symlink.git
cd symlink

# Make executable
chmod +x ./symlink

# Install system-wide (optional)
sudo ./symlink ./symlink

# Verify
symlink --version
```

### Quick Install
```bash
curl -Lo /tmp/symlink https://raw.githubusercontent.com/user/symlink/main/symlink && chmod +x /tmp/symlink && sudo /tmp/symlink /tmp/symlink && symlink --version
```

## Usage Examples

### Process `.symlink` Files
```bash
# Main usage - scan with no prompts and clean broken links
sudo symlink -SPd /my/scripts

# Scan current directory
sudo symlink -SPd

# With interactive prompts
sudo symlink -S /path/to/project
```

### List `.symlink` Files
```bash
symlink -l /path/to/projects
```

### Individual File Symlinking
```bash
# Single file
sudo symlink /path/to/my/script

# Multiple files
sudo symlink /path/to/script1 /path/to/script2
```

## Command-Line Options

| Option | Description |
|--------|-------------|
| `-S` | Scan for `.symlink` files and process them (limited to depth 5) |
| `-P` | Skip confirmation prompts for existing symlinks |
| `-d` | Clean up broken symlinks in target directory |
| `-t` | Specify custom target directory (default: `/usr/local/bin`) |
| `-l` | List contents of `.symlink` files only (no symlinking) |
| `-n` | Dry-run mode (show what would happen without changes) |
| `-v` | Verbose output with additional details |
| `-q` | Quiet mode (suppresses informational messages) |
| `-h` | Display help message |
| `-V` | Show version information |
| `--debug` | Debug mode with detailed logging to trace file |

**Tip:** Combine options: `-SPd` for no-prompt scan with cleanup

## Safety Features

- Critical system files (`bash`, `sh`, `ls`, `cp`, `mv`, `rm`, `sudo`, `chmod`, `chown`) require explicit confirmation
- Scanning in target directory is restricted to prevent recursive issues
- Path resolution operations have timeouts to prevent hanging
- Batch processing with progress tracking for reliable completion
- Pure Bash approach for broken symlink detection to avoid recursion issues

## Requirements

- Bash 4.0+
- Root privileges (auto-elevates with sudo)
- Write access to `/usr/local/bin` (or custom target directory)
- Standard Linux utilities (find, readlink, timeout)

## Exit Codes

- `0`: Success
- `1`: General error
- `2`: Permission denied
- `3`: File not found
- `22`: Invalid option
- `50`: No symlink files found

## Environment Variables

### Debug Mode
```bash
# Enable debug logging with environment variable
SYMLINK_DEBUG=1 symlink -SPd /path/to/scripts

# Or use command-line flag (equivalent)
symlink --debug -SPd /path/to/scripts
```
Debug logs are written to: `/tmp/symlink-trace-<username>-<pid>.log` and contain detailed execution information including:
- Command-line arguments and options
- Path resolution operations
- Batch processing progress
- Detailed error conditions
- Final operation summary

### Critical Files Override
```bash
# Force replacement of critical system files in non-interactive mode
SYMLINK_FORCE_CRITICAL=1 symlink -SP /path/to/script
```
**Caution:** This bypasses important safety checks. Only use when absolutely necessary and when you fully understand the potential consequences. Replacing critical system files can break your system.

## License

[GPL-3.0](LICENSE) - GNU General Public License v3.0

## Contributing

Contributions welcome via Pull Requests.

## Changelog

### Version 1.3.7
- Fixed hanging issues in broken symlink cleanup and path resolution
- Improved non-interactive mode detection with `[[ -t 0 ]]` terminal check
- Enhanced critical file safety with confirmation requirements
- Added the `SYMLINK_FORCE_CRITICAL` environment variable for automated scripts
- Implemented timeout-based path resolution to prevent hanging
- Added pure Bash approach for scanning to avoid recursion issues
- Limited directory scanning depth to 5 levels for safety
- Improved batch processing with progress tracking
- Enhanced error handling with better reporting

### Version 1.3.0
- Added debug mode with comprehensive logging to trace files
- Implemented batch processing for multiple `.symlink` files
- Fixed sudo elevation issues with proper environment preservation
- Added progress tracking for batch operations
- Improved error handling and recovery strategies

### Version 1.2.0
- Added dry-run mode for previewing operations without changes
- Improved handling of critical system files with warnings
- Enhanced error reporting and exit code consistency

### Version 1.1.0 
- Added `.symlink` file support for batch symlinking
- Implemented directory scanning for `.symlink` files
- Added broken symlink cleanup functionality
- Added support for handling existing files/symlinks
