# Makefile for symlink - create and manage /usr/local/bin symlinks

PREFIX  ?= /usr/local
BINDIR   = $(PREFIX)/bin
MANDIR   = $(PREFIX)/share/man/man1
COMPDIR  = /etc/bash_completion.d

.PHONY: help install uninstall check test

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install symlink, manpage, and completion (requires sudo)
	install -d $(BINDIR)
	install -d $(MANDIR)
	install -d $(COMPDIR)
	install -m 755 symlink $(BINDIR)/symlink
	install -m 644 symlink.1 $(MANDIR)/symlink.1
	install -m 644 symlink.bash_completion $(COMPDIR)/symlink

uninstall: ## Remove installed files (requires sudo)
	rm -f $(BINDIR)/symlink
	rm -f $(MANDIR)/symlink.1
	rm -f $(COMPDIR)/symlink

check: ## Run shellcheck
	shellcheck -x -e SC2015 symlink

test: ## Run test suite (requires sudo)
	sudo ./test-symlink

#fin
