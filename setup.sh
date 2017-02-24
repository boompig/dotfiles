#!/usr/bin/env bash

# Written by Daniel Kats
# This script will automatically setup the dotfiles to 'just work'

if [ $SHELL = "/bin/bash" ]; then
    HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    HERE="$(pwd)"
fi


git_or_exit() {
    which git>/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: git not installed, quitting">&2
        exit 1
    fi
}

vim_or_exit() {
    which vim>/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: vim not installed, quitting">&2
        exit 1
    fi
}

configure_git() {
    git config --global user.name "Daniel Kats"
    git config --global user.email "boompigdev@gmail.com"
    git config --global core.editor "$(which vim)"
    local git_version=$(git --version | sed 's/git version //')
    if [ $(echo "$git_version" | egrep '^2') ]; then
        echo "Performing git v2+ configuration"
        git config --global push.default simple
    else
        echo "Git version is $git_version < 2, ignoring git 2+ configuration"
    fi
}

install_bashrc() {
    local bashrc="$HOME/.bashrc"
    if [ -f "$bashrc" ]
    then
        echo "Warning: $bashrc already exists">&2
    else
        echo "Installing bashrc..."
        ln -s "$HERE/bashrc" "$bashrc"
    fi
}

install_zshrc() {
    # write zshrc
    local zshrc="$HOME/.zshrc"
    if [ -f "$zshrc" ]
    then
        echo "Warning: $zshrc already exists">&2
    else
        echo "Installing zshrc..."
        ln -s "$HERE/zshrc" "$zshrc"
    fi
}

install_zsh_syntax_highlighting() {
    if [ ! -d "$HOME/zsh-syntax-highlighting" ]
    then
        echo "Installing zsh syntax highlighting..."
        pushd "$HOME" >/dev/null
        git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git"
        popd >/dev/null
    else
        echo "Warning: $HOME/zsh-syntax-highlighting already installed"
    fi
}

install_tmux_conf() {
    local tmux_conf="$HOME/.tmux.conf"
    if [ -f "$tmux_conf" ]
    then
        echo "Warning: $tmux_conf already exists">&2
    else
        echo "Installing tmux.conf..."
        ln -s "$HERE/tmux.conf" "$tmux_conf"
    fi
}

create_vim_colorscheme_dir() {
    local vim_color_dir="$HOME/.vim/colors"
    if [ ! -d "$vim_color_dir" ]
    then
        mkdir -p "$vim_color_dir"
    fi
}

# 
# Args:
#   - name of colorscheme
#   - directory of colorscheme within vim folder (often same as colorscheme name)
#   - git repo of colorscheme
#   - path to relevant file within colorscheme directory
install_vim_colorscheme() {
    local name="$1"
    local directory="$2"
    local repo_url="$3"
    local path="$4"
    if [ ! -d "$HOME/.vim/$directory" ]; then
        echo "Installing $name colorscheme"
        pushd "$HOME/.vim" >/dev/null
        git clone "$repo_url"
        cp "$directory/$path" colors/
        popd >/dev/null
    else
        echo "Warning: $name colorscheme already installed"
    fi
}

install_vimrc() {
    # write vimrc
    which vim>/dev/null
    if [ $? -eq 0 ]; then
        local vimrc="$HOME/.vimrc"
        if [ -f "$vimrc" ]; then
            echo "Warning: $vimrc already exists">&2
        else
            echo "Installing vimrc..."
            ln -s "$HERE/vimrc" "$vimrc"
        fi
    else
        echo "Error: Vim not installed">&2
        exit 2
    fi
}

install_vim_plugins() {
    if [ -d "$HOME/.vim/autoload/plug.vim" ]
    then
        echo "Warning: Vundle is already installed">&2
    else
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    vim +PlugInstall +qa
}

install_my_vim_colorscheme() {
    local vim_color_dir="$HOME/.vim/colors"
    local my_vim_color="$HERE/config/dbk_sublime.vim"
    if [ ! -e "$vim_color_dir/dbk_sublime.vim" ]; then
        cp "$my_vim_color" "$vim_color_dir"
    fi
}

git_or_exit
vim_or_exit
configure_git
install_bashrc
install_zshrc
install_zsh_syntax_highlighting
install_tmux_conf

# vim stuff
create_vim_colorscheme_dir
install_vim_colorscheme \
    "Molokai" \
    "molokai" \
    "https://github.com/tomasr/molokai.git" \
    "colors/molokai.vim";
install_vim_colorscheme \
    "Github" \
    "vim-github-colorscheme" \
    "https://github.com/endel/vim-github-colorscheme.git" \
    "colors/github.vim";
install_vimrc
install_my_vim_colorscheme
install_vim_plugins

