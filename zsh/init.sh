# TODO Test if zsh exists

# Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Synchronize bullet-train theme
cd $HOME/lkaybob/zsh
git submodule init
git submodule update
ln -nfs $HOME/lkaybob/zsh/themes/bullet-train/bullet-train.zsh-theme $HOME/.oh-my-zsh/themes/bullet-train.zsh-theme
cd $HOME/lkaybob

ln -nfs $HOME/lkaybob/osx/.bash_profile $HOME/.bash_profile

[ ! -f $HOME/.zshrc ] && ln -nfs $HOME/lkaybob/.zshrc $HOME/.zshrc
source $HOME/.zshrc
