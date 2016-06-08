which apt-get &>/dev/null
if [ $? -eq 0 ]; then
    # tools needed for basic computer survival
    sudo apt-get install -y zsh tmux
    sudo apt-get install -y vim git tig
    sudo apt-get install -y tmux
    sudo apt-get install -y python-pip python3 python3-pip
    sudo pip install virtualenv
else
    echo 'This file is for systems which have `apt-get` only'
fi
