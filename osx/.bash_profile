# swagger-codegen
export PATH="/usr/local/opt/swagger-codegen@2/bin:$PATH"

# added by travis gem
[ -f /Users/lkaybob/.travis/travis.sh ] && source /Users/lkaybob/.travis/travis.sh

# rust-lang
export PATH="$HOME/.cargo/bin:$PATH"

# iterm integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# openjdk
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Alias for Mac OSX
if [ -f $HOME/lkaybob/osx/.bash_aliases ]; then
    source $HOME/lkaybob/osx/.bash_aliases
fi

# Add alias for common aliases for nix system
if [ -f $HOME/lkaybob/ubuntu/.bash_aliases ]; then
    source $HOME/lkaybob/ubuntu/.bash_aliases
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
