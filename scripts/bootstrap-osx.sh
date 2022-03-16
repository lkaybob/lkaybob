# Check if homebrew exists
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Brew setup
brew update
brew tap homebrew/bundle
brew bundle --file=$HOME/lkaybob/osx/Brewfile

# Clean up the caches
brew cleanup
brew cask cleanup

# Init zsh
$HOME/lkaybob/zsh/init.sh

ln -nfs $HOME/lkaybob/osx/.bash_profile $HOME/.bash_profile
ln -nfs $HOME/lkaybob/osx/.bash_aliases $HOME/.bash_aliases
