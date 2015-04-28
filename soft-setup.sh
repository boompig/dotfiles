if [ `uname | grep -i 'linux'` ]; then
    # tools needed for basic computer survival
    sudo apt-get install zsh
    sudo apt-get install vim git tig
    sudo apt-get install tmux
    sudo apt-get install python-pip python3
else
    echo "This file is for Linux only"
fi
