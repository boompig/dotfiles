" Written by Daniel Kats
" May 27, 2014

set nocompatible

" backslash is harder to reach
let mapleader=","

" clear previous variable settings
filetype off
filetype plugin indent off


" add support for go types
set runtimepath+=$GOROOT/misc/vim

filetype plugin indent on
syntax on

" syntax inspector
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" use my custom color scheme
colorscheme dbk_sublime

" auto-close HTML tags
set omnifunc=htmlcomplete#CompleteTags

" super pro remapping of vim colon to semi-colon
nnoremap ; :

" reload vimrc quickly
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" simple switch for set paste
set pastetoggle=<F2>

cnoreabbrev <expr> nt ((getcmdtype() is# ':' && getcmdline() is# 'nt')?('NERDTree'):('nt'))

" show line #s
set number

" tabs are 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set shiftround
set softtabstop=4
" show matching parens
set showmatch

" show whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" enable mouse!!!
" set mouse=a

" show colour column after 100 chars
set textwidth=99
set colorcolumn=+1
highlight ColorColumn ctermbg=8

set hlsearch

set cindent

" turn on Pathogen to discovery plugins
execute pathogen#infect()

" Vim magic on
set omnifunc=syntaxcomplete#Complete

" auto-close HTML tags
iabbrev </ </<C-X><C-O>

" shortcut for faster moving between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open tabpanes in right instead of left
set splitright
set noswapfile
" for some reason, needs to be set twice
color dbk_sublime
