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

" show line #s
set number

" tabs are 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

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
