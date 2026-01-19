# Symlink Utility

![Version](https://img.shields.io/badge/Version-1.4.0-blue.svg)
![License](https://img.shields.io/badge/License-GPL--3.0-green.svg)

A Bash utility that creates symbolic links in `/usr/local/bin` for executables, making them accessible system-wide. Designed for managing scripts across multiple directories with built-in safety and batch processing.

## Primary Use Case: `.symlink` Files

Create a `.symlink` file in any project directory listing executables to make available system-wide:

```
# Comments start with #
script1                       # → script1
tools/script2                 # → script2 (relative paths supported)
build.bash build              # → build (custom link name)
util.sh helper util-cmd       # → helper AND util-cmd (multiple links)
```

Format: `<source> [<linkname>...]` — one entry per line. Inline comments (`# ...`) are stripped.

Process all `.symlink` files in a directory tree:

```bash
sudo symlink -SPd /my/scripts
```

This scans for `.symlink` files (max depth 5), creates symlinks, skips prompts for existing links (`-P`), and cleans broken symlinks (`-d`).

## Installation

```bash
# Clone and install
git clone https://github.com/user/symlink.git
cd symlink
sudo ./symlink ./symlink

# Verify
symlink --version
```

## Usage Examples

```bash
# Main usage - scan with no prompts, clean broken links
sudo symlink -SPd /my/scripts

# Scan current directory
sudo symlink -SPd

# List .symlink contents without creating links
symlink -l /path/to/projects

# Single file symlinking
sudo symlink /path/to/script

# Dry-run to preview changes
symlink -n ./my-script.sh

# Debug mode
symlink --debug -nSPd /path/to/scripts
```

## Command-Line Options

| Option | Description |
|--------|-------------|
| `-S, --scan-symlink` | Scan for `.symlink` files and process them |
| `-P, --no-prompt` | Skip confirmation prompts for existing symlinks |
| `-d, --delete-broken-symlinks` | Clean up broken symlinks in target directory |
| `-t, --target-dir DIR` | Custom target directory (default: `/usr/local/bin`) |
| `-l, --list` | List `.symlink` file contents only |
| `-n, --dry-run` | Preview changes without executing |
| `-v, --verbose` | Verbose output |
| `-q, --quiet` | Suppress informational messages |
| `-D, --debug` | Debug mode with trace logging |
| `-h, --help` | Display help |
| `-V, --version` | Show version |

Options can be combined: `-SPd` for no-prompt scan with cleanup.

## Safety Features

Protects 53 critical system binaries from accidental replacement, limits scan depth to 5 levels, applies timeouts during path resolution, and auto-detects interactive mode for appropriate prompting.

## Environment Variables

| Variable | Purpose |
|----------|---------|
| `SYMLINK_DEBUG=1` | Enable debug logging to `/tmp/symlink-trace-<user>-<pid>.log` |
| `SYMLINK_FORCE_CRITICAL=1` | Bypass critical file protection (use with caution) |

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | Permission denied |
| 3 | File not found |
| 22 | Invalid option |
| 50 | No symlink files found |

## Requirements

- Bash 5.2+
- Root privileges (auto-elevates with sudo)
- Standard Linux utilities (readlink, timeout)

## License

[GPL-3.0](LICENSE) - GNU General Public License v3.0

## Contributing

Contributions welcome via Pull Requests.
