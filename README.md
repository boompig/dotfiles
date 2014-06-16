dotfiles
========

Linux/Mac Dotfiles

Free to take and use, just keep all the "written by" headers!

Installation Instructions
========================

For bashrc to work, do one of the following:

`echo 'source <path/to/repo>/bashrc' >> ~/.bashrc`

For vimrc to work, do the following:

`ln -s <path/to/repo>/vimrc ~/.vimrc`

For the vim colorscheme to work, do the following:

`mkdir -p ~/.vim/colors`
`ln -s <path/to/repo>/config/dbk_sublime.vim ~/.vim/colors/dbk_sublime.vim`

If you start vim and you get this error:
> E117: Unknown function: pathogen#infect
> E15: Invalid expression: pathogen#infect()
> Press ENTER or type command to continue

Then you don't have pathogen installed. Why not? Get it [here](https://github.com/tpope/vim-pathogen)
