# Changelog

All notable changes to **symlink** are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2026-05-31

A safety- and robustness-focused release driven by a full code audit. Adds
opt-in clobber control, generalises critical-file protection, hardens the
privileged path, and repairs significant test-suite rot.

### Added
- `-f, --force` — replace a pre-existing **non-symlink** file in
  non-interactive mode. Without it such files are now skipped rather than
  silently destroyed.
- `--backup` — rename a replaced file to `NAME.bak~` before clobbering it.
- **PATH-shadow advisory** — any link whose name would override another
  executable on `PATH` is flagged (non-blocking non-interactively; prompts in
  interactive mode).
- **Untrusted-input containment** — `.symlink` source paths that are absolute
  or escape the file's directory (via `..`), and link names that are not a
  single bare filename, are rejected.
- Tests: pty-driven interactive critical-file `y`/`n` cases, non-interactive
  skip regression, `--force`/`--backup` coverage, and shadow-advisory tests
  (85 → 92 tests).

### Changed
- Non-interactive mode no longer overwrites pre-existing regular files by
  default (see `--force`).
- `CRITICAL_FILES` expanded with `apt crontab dd dpkg env ln scp ssh su
  systemctl visudo`; documented as a best-effort guard, not a security boundary.
- `warn()` is now unconditional so safety warnings surface without `-v`.
- `-n, --dry-run` auto-enables verbose output so the preview lists each
  per-file decision.
- Debug trace file is created via `mktemp(1)` in `$TMPDIR` (default `/tmp`),
  with mode `0600` — replacing the predictable `/tmp/symlink-trace-<user>-<pid>`
  path.
- Auto-elevation forwards only `SYMLINK_DEBUG` instead of using `sudo -E`, so
  `SYMLINK_FORCE_CRITICAL` no longer crosses the privilege boundary unvalidated.
- `is_critical_file` matches on basename only.
- Documentation (man page, README, bash completion) synced with current
  behaviour.

### Fixed
- Replacement operations were counted as both *replaced* and *created* in the
  summary; a replacement is now counted once.
- `-l` listing now strips comments using the same rules as the `-S` parser, so
  the listing faithfully previews what scanning would act on.
- `trim()` uses `printf` instead of `echo -n`, so a token of exactly `-n`,
  `-e`, or `-E` is no longer silently dropped.
- Loop variables `line` and `batch` are now declared `local`.
- Test suite: replaced tautological `assert_success echo` checks with real
  assertions; debug-trace tests now parse the logged path (no `/tmp` glob, no
  stale-file masking); `assert_contains` / `assert_output_*` now match
  literally rather than as regex; version assertions derive from the script's
  `VERSION` constant.

### Security
- Closes a predictable-`/tmp` trace-file symlink-attack vector (CWE-377/CWE-59).
- Closes a path-traversal / PATH-hijack vector when scanning an untrusted tree
  as root.

## [1.4.1] - 2026-05-10

### Changed
- Makefile upgraded to BCS1212 compliance.
- Internal and external documentation synced with code.

## [1.4.0] - 2026-04-23

### Added
- `.symlink` batch processing, auto-sudo elevation, critical-file protection,
  dry-run mode, broken-symlink cleanup, and the BCS-compliant test suite.

[1.5.0]: https://github.com/Open-Technology-Foundation/symlink/releases/tag/v1.5.0
[1.4.1]: https://github.com/Open-Technology-Foundation/symlink/releases/tag/v1.4.1
[1.4.0]: https://github.com/Open-Technology-Foundation/symlink/releases/tag/v1.4.0
