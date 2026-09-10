# Global Instructions

Machine-wide preferences for Claude Code, loaded in every project on this box. Repo-specific
details belong in that repo's own `CLAUDE.md`, not here.

## Package Management (Linux/Ubuntu)

- Prefer Homebrew (`brew`) over `apt`/`apt-get` for installing tools on Ubuntu. Only reach for
  `apt` when a package genuinely isn't available via `brew`.
- Before running `brew install`/`brew uninstall` directly, check whether the current user owns
  the Homebrew prefix, e.g. `stat -c '%U' $(brew --prefix)`. If it's owned by another user (as on
  the macOS setup, where Homebrew runs under an `administrator` account), don't execute the
  command — print it for the user to run manually instead. If it's owned by the current user,
  run it directly.
- New packages for this dotfiles repo go in the relevant `Brewfile` (`ubuntu/Brewfile`,
  `osx/Brewfile.formula`, `osx/Brewfile.cask`), not one-off installs, so `brew bundle` stays the
  source of truth.

## Shell & Editor Defaults

- Default shell is zsh (oh-my-zsh, bullet-train theme). Default shell snippets/examples to zsh
  syntax over bash unless a project specifies otherwise.
- Default editor is Neovim. Prefer Neovim-compatible suggestions over Vim/other editors when
  giving editor-specific advice.

@~/.claude/CLAUDE.local.md
