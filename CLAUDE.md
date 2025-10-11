# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for setting up development environments across macOS and Linux systems. The main entry point is `init.sh`, which orchestrates the installation and configuration of development tools, shell configurations, and application settings.

## Key Commands

### Setup and Installation
- `./init.sh` - Main setup script that detects OS and configures the entire development environment
- `./init.sh --skip-docker` - Skip Docker installation during setup
- `./init.sh --skip-packages` - Skip package installation during setup (useful for partial setups)
- `brew bundle --file=osx/Brewfile.formula` - Install Homebrew formulae (works on both macOS and Linux with Linuxbrew)
- `brew bundle --file=osx/Brewfile.cask` - Install macOS GUI applications (macOS only)
- `sudo apt update && paste -sd ' ' ubuntu/pre-packages.txt | xargs sudo apt install -y` - Install Linux prerequisites
- `paste -sd ' ' ubuntu/packages.txt | xargs sudo apt install -y` - Install Linux packages

### Neovim Plugin Management
- `:PlugInstall` - Install Neovim plugins after symlinking config files
- `:PlugUpdate` - Update installed plugins
- `:PlugClean` - Remove unused plugins

## Architecture and Structure

### Setup Process Flow (init.sh:185-210)
The setup follows this order:
1. OS detection (Darwin vs Linux) via `uname -s`
2. Shell setup (zsh with oh-my-zsh and bullet-train theme)
3. Package installation (conditional on `--skip-packages` flag)
   - macOS: Split Brewfile approach - formulae (Brewfile.formula) and casks (Brewfile.cask)
   - Linux: Two-stage apt install - pre-packages first, then main packages
4. Docker installation (conditional on `--skip-docker` flag)
   - macOS: Via Homebrew cask
   - Linux: Official Docker repository installation with user group setup
5. NVM and Node.js LTS installation
6. Dotfile symlinking (bash, zsh, tmux)
7. Neovim configuration with vim-plug
8. SSH configuration (copied via rsync, not symlinked)

### Brewfile Split Architecture
The repository uses separate Brewfiles for Linuxbrew compatibility:
- `osx/Brewfile.formula` - Command-line tools and libraries (compatible with both macOS and Linuxbrew)
- `osx/Brewfile.cask` - macOS GUI applications (macOS-only, skipped on Linux)

This separation allows the formula file to be used on Linux via Linuxbrew while the cask file is only processed on macOS.

### Platform-Specific Configuration
- `osx/` - macOS-specific configurations
  - `Brewfile.formula` - Cross-platform command-line tools
  - `Brewfile.cask` - macOS GUI applications
  - `com.googlecode.iterm2.plist` - iTerm2 configuration
  - `unload-pulse-secure.sh` - Pulse Secure cleanup script
- `ubuntu/` - Linux-specific configurations
  - `pre-packages.txt` - Build essentials and prerequisites (must be installed first)
  - `packages.txt` - Main Ubuntu packages (automake, libtool-bin, gettext, etc.)
  - Package names are based on Ubuntu 20.04 (may differ in earlier versions)

### Dotfiles Symlinking Strategy
Most configuration files are symlinked from `$HOME/lkaybob` to home directory:
- Shell: `.bash_aliases`, `.bash_profile`, `.zshrc`
- Terminal multiplexer: `.tmux.conf`
- Editor: `.config/nvim/init.vim`, `.config/nvim/nvim-tree.lua`, `.config/nvim/lualine.lua`

**Exception**: SSH configuration (`.ssh/`) is copied via `rsync -av --no-perms` rather than symlinked for security purposes.

### Neovim Configuration
The setup uses vim-plug as the plugin manager with these main plugins:
- `coc.nvim` - Intellisense and language server support
- `nvim-tree.lua` - File explorer (toggled with Ctrl+N)
- `lualine.nvim` - Statusline customization
- `markdown-preview.nvim` - Live markdown preview

Key bindings defined in init.vim:37-38:
- `Ctrl+N` - Toggle file tree
- `<leader>r` - Refresh file tree
- `<leader>n` - Find current file in tree

## Important Notes

- The init script expects to be run from `$HOME/lkaybob` directory (hardcoded in init.sh:2)
- All external downloads use unversioned URLs (oh-my-zsh, NVM, vim-plug) which may break over time
- On Linux, Docker installation requires logout/login after setup for group membership to take effect
- NVM is installed to `$HOME/.nvm` and immediately loads Node.js LTS version
- The setup is idempotent - running multiple times will skip already-installed components
