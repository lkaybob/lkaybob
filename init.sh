#!/usr/bin/env bash
DOTFILES=$HOME/lkaybob
OS_TYPE=$(uname -s)

print_banner() {
  echo "    ____               __          __           __      __  _____ __"
  echo "   / / /______ ___  __/ /_  ____  / /_     ____/ /___  / /_/ __(_) /__  _____"
  echo "  / / //_/ __ \`/ / / / __ \/ __ \/ __ \   / __  / __ \/ __/ /_/ / / _ \/ ___/"
  echo " / / ,< / /_/ / /_/ / /_/ / /_/ / /_/ /  / /_/ / /_/ / /_/ __/ / /  __(__  )"
  echo "/_/_/|_|\__,_/\__, /_.___/\____/_.___/   \__,_/\____/\__/_/ /_/_/\___/____/"
  echo "             /____/"
  echo ""
  
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    echo "Detected OS as Mac OS..."
  else
    echo "Detected OS as Linux..."
  fi
}

set_zsh() {
  if [[ ! -x $(which zsh) ]]; then
    # Install oh-my-zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
      "" --unattended --keep-zshrc
    
    # Synchronize bullet-train theme
    wget -O $HOME/.oh-my-zsh/themes/bullet-train.zsh-theme \
      https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
    
    [ -f $HOME/.zshrc ] && rm $HOME/.zshrc
    ln -nfs $DOTFILES/.zshrc $HOME/.zshrc
  fi
}

set_homebrew() {
  # Check if homebrew exists
  if test ! $(which brew); then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  
  # Brew setup
  brew update
  brew tap homebrew/bundle
  brew bundle --file=$DOTFILES/osx/Brewfile
  
  # Clean up the caches
  brew cleanup
  brew cask cleanup
}

# TODO RHEL / CentOS?
install_linux_packages() {
  sudo apt update
  paste -sd ' ' $DOTFILES/ubuntu/pre-packages.txt | xargs sudo apt install -y
  
  ## Node.js current
  curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -
  
  ## Docker
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  
  paste -sd ' ' $DOTFILES/ubuntu/packages.txt | xargs sudo apt install -y
}

set_bash_files() {
  ln -nfs $DOTFILES/.bash_aliases $HOME/.bash_aliases
  ln -nfs $DOTFILES/.bash_profile $HOME/.bash_profile

  source $HOME/.bash_profile
}

set_tmux() {
  ln -nfs $DOTFILES/.tmux.conf $HOME/.tmux.conf
}

set_nvim() {
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  if [ ! -d $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim
  fi

  ln -nfs $DOTFILES/.config/nvim/init.vim $HOME/.config/nvim/init.vim
  ln -nfs $DOTFILES/.config/nvim/nvim-tree.lua $HOME/.config/nvim/nvim-tree.lua
  ln -nfs $DOTFILES/.config/nvim/lualine.lua $HOME/.config/nvim/lualine.lua
}

set_ssh() {
  rsync -av --no-perms $DOTFILES/.ssh $HOME/
}

# Main body
print_banner
set_zsh

if [[ "$OS_TYPE" == "Darwin" ]]; then
  set_homebrew
else
  install_linux_packages
fi

set_tmux
set_nvim
set_ssh

echo ""
echo "All done!"
