# symlink

A Bash utility for creating symlinks in `/usr/local/bin` for executable files, making them accessible system-wide via the command line.

## Features

- Create symlinks for individual executable files
- Batch-create symlinks from configuration files (`.symlink`)
- Automatically handle permission elevation with sudo
- Manage existing symlinks with user prompts
- Clean up broken symlinks
- Verbose output options

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

## Usage

### Basic Usage

Create a symlink for a specific executable file:

```bash
sudo ./symlink /path/to/my/script
```

Create symlinks for multiple files:

```bash
sudo ./symlink /path/to/script1 /path/to/script2
```

### Using .symlink Configuration Files

Create a `.symlink` file in your project directory containing a list of executable files:

```
# Comments are allowed
script1
script2
bin/tool3
```

Each file path should be relative to the location of the `.symlink` file.

Then scan for and process all `.symlink` files from a directory:

```bash
sudo ./symlink -S /path/to/projects
```

If you omit the path, the current directory will be used:

```bash
sudo ./symlink -S
```

### Listing .symlink Files

To view the contents of all `.symlink` files in a directory without creating symlinks:

```bash
./symlink -l /path/to/projects
```

### Options

- `-P, --no-prompt`: Skip confirmation when removing existing symlinks
- `-S, --scan-symlink`: Scan for `.symlink` files and process them
- `-d, --delete-broken-symlinks`: Clean up broken symlinks in `/usr/local/bin`
- `-l, --list`: List contents of all `.symlink` files
- `-v, --verbose`: Show detailed output (default)
- `-q, --quiet`: Suppress informational messages
- `-V, --version`: Show version information
- `-h, --help`: Show help message

### Combined Options

You can combine options for more complex operations:

```bash
# Create symlinks without prompting and clean up broken links
sudo ./symlink -Pd /path/to/script

# Scan for .symlink files, skip prompts, and clean up broken links
sudo ./symlink -SPd /path/to/projects
```

## Requirements

- Bash 4.0+
- Root privileges (will auto-elevate with sudo if needed)

## License

[MIT](LICENSE)