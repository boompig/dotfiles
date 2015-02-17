"""""""""""""""""""""""""""""""""""""
" Written by Daniel Kats
" May 27, 2014
""""""""""""""""""""""""""""""""""""""

"""""""""""" Clear Previous Junk """"""""""""
set nocompatible
" clear previous variable settings
filetype off
filetype plugin indent off
"""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""" Vundle """"""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" language-specific stuff
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'elzr/vim-json'
Plugin 'digitaltoad/vim-jade'
Plugin 'fatih/vim-go'

" actual plugins
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-obsession'
Plugin 'kien/ctrlp.vim'
Plugin 'Shougo/neocomplcache.vim'
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" Auto-Complete """""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" Language-Specific """""""""""""""""""""""""""
" add support for go types
set runtimepath+=$GOROOT/misc/vim
" all *.md files refer to markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax on
set background=dark
set t_Co=256

" syntax inspector
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" super pro remapping of vim colon to semi-colon
nnoremap ; :

" reload vimrc quickly
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" simple switch for set paste
set pastetoggle=<F2>

" map :nt to :NerdTree
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

set hlsearch

set cindent
" backslash is harder to reach
let mapleader=","

" Vim magic on
set omnifunc=syntaxcomplete#Complete

" auto-close HTML tags
iabbrev </ </<C-X><C-O>

" open tabpanes in right instead of left
set splitright
set noswapfile

" vim-go folds everything by default, which is annoying.
let g:go_disable_autoinstall = 1
" vim-go also runs go-fmt on every save, disable that
let g:go_fmt_autosave = 0

" if file changed outside vim, automatically load newest version
set autoread
set foldmethod=manual

"set noerrorbells
"set visualbell

" for some reason, needs to be set twice
color molokai

" status line inspired by gary bernhardt
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

"""""""""""""""""" Keyboard shortcuts
" shortcut for faster moving between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" faster opening NerdTree
cnoremap NT NERDTree

" auto-completion
inoremap <C-Space> <C-X><C-O>

"""""""""""""""""" User-defined functions, for my sanity
function! Tex ()
    let fname=bufname("%")
    " do not include .tex
    let pdf_name=strpart(fname, 0, strlen(fname) - 4) . ".pdf"
    execute "! pdflatex % && open " . pdf_name
endfunction
noremap <leader>tex :.call Tex()<cr>

function! Cpp ()
    let fname=bufname("%")
    " do not include .cpp
    let bin_name=strpart(fname, 0, strlen(fname) - 4)
    execute "! g++ " . fname . " -o " . bin_name
endfunction
noremap <leader>cpp :.call Cpp()<cr>

function! BuildC ()
    let fname=bufname("%")
    " do not include .c
    let bin_name=strpart(fname, 0, strlen(fname) - 2)
    execute "! gcc " . fname . " -o " . bin_name
endfunction
map <C-B> :.call BuildC()<cr>

function! RunC ()
    let fname=bufname("%")
    " do not include .c
    let bin_name=strpart(fname, 0, strlen(fname) - 2)
    execute "! gcc " . fname . " -o " . bin_name . " && ./" . bin_name
endfunction
map <C-R> :.call RunC()<cr>

function! Py ()
    let fname=bufname("%")
    execute "! python %"
endfunction
noremap <leader>py :.call Py()<cr>

" rerun last command
noremap <leader>rep q:k<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""" Show current syntax group """"""""""""""""""""""""
map <leader>syn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
