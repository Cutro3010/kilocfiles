# Master Makefile for kilocfiles project

# Folders containing the sub-projects
CFILES_DIR = cfiles
KILO_DIR   = kilo

# Default prefix if none is given (e.g., /usr or /usr/local)
export prefix ?= /usr

.PHONY: all kilo_build cfiles_build install uninstall clean

# 1. Default rule: Build both projects
all: kilo_build cfiles_build

kilo_build:
	$(MAKE) -C $(KILO_DIR)

cfiles_build:
	$(MAKE) -C $(CFILES_DIR) prefix=$(prefix)

# 2. Install rule: Installs cfiles, its scripts, manpages, AND kilo to the path
install: all
	@echo "Installing cfiles and scripts..."
	$(MAKE) -C $(CFILES_DIR) install prefix=$(prefix) DESTDIR=$(DESTDIR)
	@echo "Installing kilo..."
	install -Dm 755 $(KILO_DIR)/kilo $(DESTDIR)/$(prefix)/bin/kilo
	@echo "All installations complete!"

# 3. Uninstall rule: Cleanly deletes everything from the system path
uninstall:
	$(MAKE) -C $(CFILES_DIR) uninstall prefix=$(prefix) DESTDIR=$(DESTDIR)
	rm -f $(DESTDIR)/$(prefix)/bin/kilo

# 4. Clean rule: Cleans build files in both subdirectories
clean:
	$(MAKE) -C $(KILO_DIR) clean
	$(MAKE) -C $(CFILES_DIR) clean
