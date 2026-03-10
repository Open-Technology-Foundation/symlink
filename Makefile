# Makefile - Install symlink
# BCS1212 compliant

PREFIX  ?= /usr/local
BINDIR  ?= $(PREFIX)/bin
MANDIR  ?= $(PREFIX)/share/man/man1
COMPDIR ?= /etc/bash_completion.d
DESTDIR ?=

.PHONY: all install uninstall check test help

all: help

install:
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 symlink $(DESTDIR)$(BINDIR)/symlink
	install -d $(DESTDIR)$(MANDIR)
	install -m 644 symlink.1 $(DESTDIR)$(MANDIR)/symlink.1
	@if [ -d $(DESTDIR)$(COMPDIR) ]; then \
	  install -m 644 symlink.bash_completion $(DESTDIR)$(COMPDIR)/symlink; \
	fi
	@if [ -z "$(DESTDIR)" ]; then $(MAKE) --no-print-directory check; fi

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/symlink
	rm -f $(DESTDIR)$(MANDIR)/symlink.1
	rm -f $(DESTDIR)$(COMPDIR)/symlink

check:
	@command -v symlink >/dev/null 2>&1 \
	  && echo 'symlink: OK' \
	  || echo 'symlink: NOT FOUND (check PATH)'

test:
	sudo ./test-symlink

help:
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Targets:'
	@echo '  install     Install to $(PREFIX)'
	@echo '  uninstall   Remove installed files'
	@echo '  check       Verify installation'
	@echo '  test        Run test suite (requires sudo)'
	@echo '  help        Show this message'
	@echo ''
	@echo 'Install from GitHub:'
	@echo '  git clone https://github.com/Open-Technology-Foundation/symlink.git'
	@echo '  cd symlink && sudo make install'
