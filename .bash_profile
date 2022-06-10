# swagger-codegen
# rust-lang
export PATH="/usr/local/opt/swagger-codegen@2/bin:$HOME/.cargo/bin:$PATH"

if [ -f $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

# Mac OSX Specific settings
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/opt/mysql-client/bin:/usr/local/opt/openjdk/bin:$PATH"

  # iterm integration
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  
  export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
