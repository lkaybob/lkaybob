# Assuming using Ubuntu server

sudo apt update
paste -sd ' ' $HOME/lkaybob/ubuntu/pre-packages.txt | xargs sudo apt install -y

## Node.js current
curl -sL https://deb.nodesource.com/setup_current.x | sudo -E bash -

## Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

paste -sd ' ' $HOME/lkaybob/ubuntu/packages.txt | xargs sudo apt install -y

ln -nfs $HOME/lkaybob/tmux/.tmux.conf $HOME/.tmux.conf
ln -nfs $HOME/lkaybob/ubuntu/.bash_aliases $HOME/.bash_aliases
