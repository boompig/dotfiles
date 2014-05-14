syntax on
set background=dark
colorscheme default

" show line #s
set number

" tabs are 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

set hlsearch

" Vim magic on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" auto-close HTML tags
:iabbrev </ </<C-X><C-O>
