#!/usr/bin/env bash
DOTFILES=$HOME/lkaybob
OS_TYPE=$(uname -s)
NODE_VERSION=--lts
SKIP_DOCKER=false
SKIP_PACKAGES=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --skip-docker)
      SKIP_DOCKER=true
      shift
      ;;
    --skip-packages)
      SKIP_PACKAGES=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [--skip-docker] [--skip-packages]"
      exit 1
      ;;
  esac
done

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


__check_command() {
  command -v "$1" > /dev/null 2>&1
}

set_zsh() {
  # Check if zsh is installed first
  if [[ ! -x $(which zsh) ]]; then
    echo "Zsh not found. Please install zsh first."
    return 1
  fi
  
  # Check if oh-my-zsh is already installed
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "Oh-my-zsh already installed"
  else
    echo "Installing oh-my-zsh..."
    # Install oh-my-zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
      "" --unattended --keep-zshrc
    
    # Synchronize bullet-train theme
    wget -O $HOME/.oh-my-zsh/themes/bullet-train.zsh-theme \
      https://raw.githubusercontent.com/caiogondim/bullet-train-oh-my-zsh-theme/master/bullet-train.zsh-theme
    
    echo "Oh-my-zsh installation completed"
  fi
  
  # Always ensure our zshrc is symlinked
  [ -f $HOME/.zshrc ] && rm $HOME/.zshrc
  ln -nfs $DOTFILES/.zshrc $HOME/.zshrc
  echo "Zsh configuration linked"
}

set_homebrew() {
  # Check if homebrew exists
  if test ! $(which brew); then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  
  # Brew setup
  brew update
  brew tap homebrew/bundle
  
  # Install formulae first (compatible with Linuxbrew)
  brew bundle --file=$DOTFILES/osx/Brewfile.formula
  
  # Install casks (macOS only)
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    brew bundle --file=$DOTFILES/osx/Brewfile.cask
  fi
  
  # Clean up the caches
  brew cleanup
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    brew cask cleanup
  fi
}

set_nvm() {
  # Install NVM (Node Version Manager)
  if [[ ! -d "$HOME/.nvm" ]]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    
    # Load NVM immediately
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    
    # Install and use Node.js LTS
    nvm install $NODE_VERSION
    nvm use $NODE_VERSION
    nvm alias default $NODE_VERSION
    
    echo "Node.js LTS installed and activated via NVM"
  else
    echo "NVM already installed"
  fi
}

set_docker() {
  # Check if Docker is already installed
  if __check_command docker; then
    echo "Docker already installed"
    return
  fi
  
  echo "Installing Docker..."
  
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    # Docker Desktop for Mac is handled via Homebrew in Brewfile
    echo "Docker Desktop will be installed via Homebrew"
  else
    # Install Docker on Linux
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    
    # Add user to docker group to run docker without sudo
    sudo usermod -aG docker $USER
    echo "Docker installed. You may need to log out and back in for group changes to take effect."
  fi
}

# TODO RHEL / CentOS?
install_linux_packages() {
  sudo apt update
  paste -sd ' ' $DOTFILES/ubuntu/pre-packages.txt | xargs sudo apt install -y
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

if [[ "$SKIP_PACKAGES" == "false" ]]; then
  if [[ "$OS_TYPE" == "Darwin" ]]; then
    set_homebrew
  else
    install_linux_packages
  fi
else
  echo "Skipping package installation"
fi

if [[ "$SKIP_DOCKER" == "false" ]]; then
  set_docker
else
  echo "Skipping Docker installation"
fi
set_nvm
set_tmux
set_nvim
set_ssh

echo ""
echo "All done!"
