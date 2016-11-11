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


""""""""""""""""""""""" vim-plug """"""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" language-specific stuff
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'digitaltoad/vim-jade'
Plug 'fatih/vim-go'
Plug 'petRUShka/vim-opencl'
" disabled because it stops highlighting print functions
"Plug 'hdima/python-syntax.git'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" syntax folding for Python
Plug 'tmhedberg/SimpylFold'
" Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
" Python docs in vim
Plug 'davidhalter/jedi'
Plug 'Shutnik/jshint2.vim'
" Scala
Plug 'derekwyatt/vim-scala'
" Terraform
Plug 'hashivim/vim-terraform'
" Gradle (Java build tool)
Plug 'https://github.com/tfnico/vim-gradle.git'
" HTML5
Plug 'othree/html5.vim'
" CSS3
Plug 'hail2u/vim-css3-syntax'

" actual plugins
Plug 'rking/ag.vim'
" this plugin auto-generates boilerplate HTML
Plug 'mattn/emmet-vim'
" Python tooling
Plug 'davidhalter/jedi-vim'
" good vim defaults
Plug 'tpope/vim-sensible'
" extended % matching to HTML
Plug 'tmhedberg/matchit'
" easy comment/uncomment
Plug 'scrooloose/nerdcommenter'
" easily align text into columns
"Plug 'godlygeek/tabular'
" better star search
Plug 'nelstrom/vim-visual-star-search'
" better file browser. disabled because slow to start up
"Plug 'scrooloose/nerdtree'
" better file finder
Plug 'kien/ctrlp.vim'
" autocomplete
Plug 'Shougo/neocomplete.vim'
" this plugin only exists to show current branch info in statusline. disabled
" because slow to start up
"Plug 'tpope/vim-fugitive'
" this is the statusline plugin
Plug 'itchyny/lightline.vim'
" display buffers as tabs
Plug 'ap/vim-buftabline'
" shortcuts for fast switching between buffers
Plug 'tpope/vim-unimpaired'
" autoclose HTML
Plug 'vim-scripts/closetag.vim'
" faster folding
Plug 'Konfekt/FastFold'
" import sorting for Python
Plug 'fisadev/vim-isort'
" allows for async make
Plug 'tpope/vim-dispatch'

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" Auto-Complete """""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1
let g:neocomplete#enable_at_startup = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" airline  """"""""""""""""""""""""""""""""""""
"" use pretty symbols
"let g:airline_powerline_fonts = 1
"" disable a few extensions
"let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#branch#enabled = 1
"let g:airline_section_y = ' '
"let g:airline_section_z = ' '
"" make tabs pretty
"let g:airline#extensions#tabline#enabled = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" Language-Specific """""""""""""""""""""""""""
" add support for go types
set runtimepath+=$GOROOT/misc/vim
" all *.md files refer to markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" allow .js files to have React-style highlighting
let g:jsx_ext_required = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
syntax on
set background=dark
set t_Co=256

"""""""""""""""""""""" syntax inspector """""""""""""""""""""""""""""""
"nmap <C-S-P> :call <SID>SynStack()<CR>
"function! <SID>SynStack()
    "if !exists("*synstack")
        "return
    "endif
    "echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
"endfunc
"""""""""""""""""""""" syntax inspector """""""""""""""""""""""""""""""

" super pro remapping of vim colon to semi-colon
nnoremap ; :

"automatically apply vimrc changes on write
"if has("autocmd")
    "autocmd bufwritepost .vimrc source $MYVIMRC
"endif

" reload vimrc quickly
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" simple switch for set paste
set pastetoggle=<F2>

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
"set list
"set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
"set nolist

set hlsearch
set incsearch

set cindent
" backslash is harder to reach
let mapleader=","

" Vim magic on
set omnifunc=syntaxcomplete#Complete

" auto-close HTML tags
iabbrev </ </<C-X><C-O>

" open tab
" panes in right instead of left
set splitright
set splitbelow
set noswapfile

" vim-go folds everything by default, which is annoying.
let g:go_disable_autoinstall = 1
" vim-go also runs go-fmt on every save, disable that
let g:go_fmt_autosave = 0

" if file changed outside vim, automatically load newest version
set autoread
" allow for folding, but open everything by default
"set foldmethod=syntax
set nofoldenable

colorscheme molokai

" enable status line always
set laststatus=2


"""""""""""""""""" Keyboard shortcuts
" shortcut for faster moving between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>

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

function! Build ()
    let ext=expand("%:e")
    let fname=bufname("%")
    if ext=="js" || ext=="css"
        execute "! grunt build"
    elseif ext=="c"
        " do not include .c
        let bin_name=strpart(fname, 0, strlen(fname) - 2)
        execute "! gcc " . fname . " -o " . bin_name
    elseif ext=="cpp"
        " do not include .cpp
        let bin_name=strpart(fname, 0, strlen(fname) - 4)
        execute "! g++ " . fname . " -o " . bin_name
    elseif ext=="go"
        execute "! go build " . fname
    elseif ext==""
        echom "no build action associated with empty extension"
    else
        echom "no build action associated with extension " . ext
    endif
endfunction
" map <C-B> :.call Build()<cr>

function! Run ()
    let ext=expand("%:e")
    let fname=bufname("%")
    if ext=="c"
        " do not include .c
        let bin_name=strpart(fname, 0, strlen(fname) - 2)
        execute "! gcc " . fname . " -o " . bin_name . " && ./" . bin_name
    elseif ext=="cpp"
        " do not include .cpp
        let bin_name=strpart(fname, 0, strlen(fname) - 4)
        execute "! g++ " . fname . " -o " . bin_name . "&& ./" . bin_name
    elseif ext=="sh"
        execute "! " . fname
    elseif ext=="py"
        execute "! python " . fname
    elseif ext=="go"
        " do not include .go
        let bin_name=strpart(fname, 0, strlen(fname) - 3)
        execute "! go build " . fname . " && ./" . bin_name
    elseif ext==""
        echom "no run action associated with empty extension"
    else
        echom "no run action associated with extension " . ext
    endif
endfunction
" map <C-R> :.call Run()<cr>

function! Py ()
    let fname=bufname("%")
    execute "! python %"
endfunction
noremap <leader>py :.call Py()<cr>

" rerun last command
noremap <leader>rep q:k<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""" Disable ex mode """"""
nnoremap Q <Nop>
"""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""" (Maybe temporarily) disable arrow keys in insert mode """""""
nmap <Up> <nop>
nmap <Down> <nop>
nmap <Left> <nop>
nmap <Right> <nop>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" hide toolbar in gVim
set guioptions-=T

"""" Show current syntax group """"""""""""""""""""""""
map <leader>syn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""" F-key mappings """"""""""""""""""
nmap <F8> :TagbarToggle<CR>
"nmap <F7> :NERDTreeToggle<CR>
nmap <F5> :Make<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""" Special rules for Tex and markdown
function! TexRules()
    set background=light
    set wrap
    set linebreak
    colorscheme github
    set spell
    set nolist
endfunc
autocmd FileType tex call TexRules()
autocmd FileType markdown call TexRules()

" automatically compile scala on write
"autocmd bufWritePost *.scala make
" make using vim-dispatch in the background
autocmd bufWritePost *.scala Make!

""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""" Pretty tab-bar """"""""""""""""""""
hi TabLineFill ctermfg=8 ctermbg=Black
hi TabLine ctermfg=LightGrey ctermbg=8
hi TabLineSel ctermfg=White ctermbg=4
" always show tab bar
set showtabline=2
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yank directly into system clipboard
"set clipboard=unnamed

" allow buffers to be in the background
set hidden

""""""""""""" Ctrl-p options """"""""""""""""""""
let g:ctrlp_custom_ignore = {
            \ 'file': '\v\.(pyc|class)'
            \}
""""""""""""" Ctrl-p options """"""""""""""""""""

""""""""""""" vim-json options """"""""""""""""""
let g:vim_json_syntax_conceal = 0
""""""""""""" vim-json options """"""""""""""""""
