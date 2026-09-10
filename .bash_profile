# Source .bashrc for interactive login shells (e.g. SSH sessions).
# Bash reads only .bash_profile when it exists, skipping .profile, so
# without this the distro's .bashrc (colored prompt, completion, etc.)
# never runs on login.
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# swagger-codegen
# rust-lang
export PATH="/usr/local/opt/swagger-codegen@2/bin:$HOME/.cargo/bin:$PATH"

if [ -f $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

# Mac OSX Specific settings
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/opt/mysql-client/bin:/usr/local/opt/openjdk/bin:$HOME/.local/bin:$PATH"

  # iterm integration
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  
  export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Linux (Ubuntu/WSL) Specific settings
if [[ "$(uname -s)" == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
