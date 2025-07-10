# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for setting up development environments across macOS and Linux systems. The main entry point is `init.sh`, which orchestrates the installation and configuration of development tools, shell configurations, and application settings.

## Key Commands

### Setup and Installation
- `./init.sh` - Main setup script that detects OS and configures the entire development environment
- `brew bundle --file=osx/Brewfile` - Install macOS packages (if on macOS)
- `sudo apt update && paste -sd ' ' ubuntu/pre-packages.txt | xargs sudo apt install -y` - Install Linux prerequisites
- `paste -sd ' ' ubuntu/packages.txt | xargs sudo apt install -y` - Install Linux packages

### Development Environment
- The repository uses NVM (Node Version Manager) to install and manage Node.js LTS version
- Docker and Docker Compose are configured for both platforms
- Neovim with vim-plug plugin manager is the primary editor setup

## Architecture and Structure

### Platform-Specific Configuration
- `osx/` - macOS-specific configurations
  - `Brewfile` - Homebrew package definitions for macOS
  - `com.googlecode.iterm2.plist` - iTerm2 configuration
  - `unload-pulse-secure.sh` - Pulse Secure cleanup script
- `ubuntu/` - Linux-specific configurations  
  - `packages.txt` - Main Ubuntu packages to install
  - `pre-packages.txt` - Prerequisites that must be installed first
  - `README.md` - Ubuntu-specific notes

### Dotfiles Structure
- Shell configurations: `.zshrc`, `.bash_aliases`, `.bash_profile`
- Terminal multiplexer: `.tmux.conf`
- Editor: `.config/nvim/` (init.vim, lualine.lua, nvim-tree.lua)
- SSH configuration: `.ssh/config`

### Setup Process Flow
1. OS detection (Darwin vs Linux)
2. Shell setup (zsh with oh-my-zsh and bullet-train theme)
3. Package installation (Homebrew for macOS, apt for Ubuntu)
4. Docker installation (with validation check)
5. Node.js LTS installation via NVM
6. Dotfile symlinking
7. Neovim configuration with vim-plug

## Important Notes

- The init script downloads and installs software from external sources
- All dotfiles are symlinked from this repository to home directory
- SSH configuration is copied (not symlinked) for security
- The script expects to be run from `$HOME/lkaybob` directory
- Ubuntu package names are based on Ubuntu 20.04