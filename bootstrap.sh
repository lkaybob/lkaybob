# Check if homebrew exists
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Brew setup
brew update
brew tap homebrew/bundle
brew bundle --file=$HOME/dotfiles/Brewfile

# Clean up the caches
brew cleanup
brew cask cleanup

# Set the zsh as primary shell
chsh -s $(which zsh)
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
mkdir -p $HOME/.oh-my-zsh/custome/themes
cd $HOME/.oh-my-zsh/custome/themes
wget https://raw.githubusercontent.com/caiogondim/bullet-train.zsh/master/bullet-train.zsh-theme
cd $HOME

[ ! -f $HOME/.zshrc ] && ln -nfs $HOME/dotfiles/.zshrc $HOME/.zshrc
source $HOME/.zshrc