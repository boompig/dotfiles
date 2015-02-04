# Written by Daniel Kats
# This script will automatically setup the dotfiles to 'just work'

if [ $SHELL = "/bin/bash" ]; then
    HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    HERE="$(pwd)"
fi

################ git stuff ##############
which git>/dev/null
if [ $? -ne 0 ]; then
    echo "git not installed, quitting">&2
    exit 1
fi
git config user.name "Daniel Kats"
git config user.email "boompigdev@gmail.com"
#########################################

# write bashrc
BASH_RC="$HOME/.bashrc"
if [ -f "$BASH_RC" ]
then
    echo "Error: $BASH_RC already exists">&2
else
    ln -s "$HERE/bashrc" "$BASH_RC"
fi

# write zshrc
ZSH="$HOME/.zshrc"
if [ -f "$ZSH" ]
then
    echo "Error: $ZSH already exists">&2
else
    ln -s "$HERE/zshrc" "$ZSH"
fi

# copy zsh color plugin
pushd "$HOME"
https://github.com/zsh-users/zsh-syntax-highlighting.git
popd

# write vimrc
which vim>/dev/null
if [ $? -eq 0 ]; then
    VIM_RC="$HOME/.vimrc"
    if [ -f "$VIM_RC" ]; then
        echo "Error: $VIM_RC already exists">&2
    else
        # write vimrc
        ln -s "$HERE/vimrc" "$VIM_RC"
    fi

    # copy over colorscheme
    VIM_COLOR_DIR="$HOME/.vim/colors"
    if [ ! -d "$VIM_COLOR_DIR" ]
    then
        mkdir -p "$VIM_COLOR_DIR"
    fi

    MY_VIM_COLOR="$HERE/config/dbk_sublime.vim"
    if [ ! -e "$HOME/.vim/colors/dbk_sublime.vim" ]; then
        cp "$MY_VIM_COLOR" "$VIM_COLOR_DIR"
    fi

    if [ -d ~/.vim/bundle/Vundle.vim ]
    then
        echo "Vundle is already installed">&2
    else
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi

    vim +PluginInstall +qa
else
    echo "Vim not installed">&2
    exit 2
fi
