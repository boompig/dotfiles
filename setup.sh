# Written by Daniel Kats
# This script will automatically setup the dotfiles to 'just work'

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
    if [ ! -d "$HOME/.vim/colors" ]
    then
        mkdir -p "$HOME/.vim/colors"
    fi
    cp "$HERE/config/dbk_sublime.vim" "$HOME/.vim/colors"

    if [ -d ~/.vim/bundle/Vundle.vim ]
    then
        echo "Vundle is already installed">&2
    else
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi

    vim +PluginInstall +qa
fi
