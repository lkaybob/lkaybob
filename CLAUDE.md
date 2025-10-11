# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for setting up development environments across macOS and Linux systems. The main entry point is `init.sh`, which orchestrates the installation and configuration of development tools, shell configurations, and application settings.

## Key Commands

### Setup and Installation
- `./init.sh` - Main setup script that detects OS and configures the entire development environment
- `./init.sh --skip-docker` - Skip Docker installation during setup
- `./init.sh --skip-packages` - Skip package installation during setup (useful for partial setups)
- `brew bundle --file=osx/Brewfile.formula` - Install macOS command-line tools
- `brew bundle --file=osx/Brewfile.cask` - Install macOS GUI applications (macOS only)
- `brew bundle --file=ubuntu/Brewfile` - Install Linux packages via Linuxbrew

### Neovim Plugin Management
- `:PlugInstall` - Install Neovim plugins after symlinking config files
- `:PlugUpdate` - Update installed plugins
- `:PlugClean` - Remove unused plugins

## Architecture and Structure

### Setup Process Flow (init.sh:190-210)
The setup follows this order:
1. OS detection (Darwin vs Linux) via `uname -s`
2. Shell setup (zsh with oh-my-zsh and bullet-train theme)
3. Package installation via unified Homebrew approach (conditional on `--skip-packages` flag)
   - macOS: Split Brewfile approach - formulae (Brewfile.formula) and casks (Brewfile.cask)
   - Linux: Linuxbrew installation with ubuntu/Brewfile
4. Docker configuration (conditional on `--skip-docker` flag)
   - Docker is installed via Brewfile on both platforms
   - On Linux: Adds user to docker group for non-sudo access
5. NVM and Node.js LTS installation
6. Dotfile symlinking (bash, zsh, tmux)
7. Neovim configuration with vim-plug
8. SSH configuration (copied via rsync, not symlinked)

### Unified Homebrew Architecture
The repository uses Homebrew/Linuxbrew for package management across both platforms:
- `osx/Brewfile.formula` - macOS command-line tools and libraries
- `osx/Brewfile.cask` - macOS GUI applications (macOS-only, skipped on Linux)
- `ubuntu/Brewfile` - Linux packages via Linuxbrew

This unified approach provides consistent package management across macOS and Linux systems. The `set_homebrew()` function (init.sh:77-112) handles installation for both platforms, automatically detecting the OS and using the appropriate Brewfile.

### Platform-Specific Configuration
- `osx/` - macOS-specific configurations
  - `Brewfile.formula` - macOS command-line tools
  - `Brewfile.cask` - macOS GUI applications
  - `com.googlecode.iterm2.plist` - iTerm2 configuration
  - `unload-pulse-secure.sh` - Pulse Secure cleanup script
- `ubuntu/` - Linux-specific configurations
  - `Brewfile` - Linux packages installed via Linuxbrew
  - `README.md` - Linux-specific notes about Linuxbrew usage

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
- Linuxbrew is installed to `/home/linuxbrew/.linuxbrew` on Linux systems and added to PATH via `.bash_profile`
- All external downloads use unversioned URLs (oh-my-zsh, NVM, vim-plug) which may break over time
- On Linux, adding user to docker group requires logout/login for group membership to take effect
- NVM is installed to `$HOME/.nvm` and immediately loads Node.js LTS version
- The setup is idempotent - running multiple times will skip already-installed components
- Docker and docker-compose are installed via Brewfile on both platforms
