# Download vim-plug first
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# TODO  Linking for Windows?
ln -nfs $HOME/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim

nvim -c "PlugInstall" -c "CocInstall $(paste -sd ' ' $HOME/dotfiles/nvim/coc-extensions.txt)"

# TODO quit nvim after installation?
