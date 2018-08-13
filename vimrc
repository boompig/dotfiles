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
Plug 'digitaltoad/vim-pug'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
"Plug 'digitaltoad/vim-pug'
Plug 'mustache/vim-mustache-handlebars'
"Plug 'fatih/vim-go'
"Plug 'petRUShka/vim-opencl'
" disabled because it stops highlighting print functions
"Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx'
" syntax folding for Python
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
" Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
" Python docs in vim
Plug 'Shutnik/jshint2.vim', { 'for': 'javascript' }
" Scala
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
" Terraform
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
" Gradle (Java build tool)
Plug 'tfnico/vim-gradle'
" HTML5
Plug 'othree/html5.vim', { 'for': 'html' }
" CSS3
"Plug 'hail2u/vim-css3-syntax'
" Markdown
" screws with indent and doesn't really provide any functionality
"Plug 'plasticboy/vim-markdown'
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
" AppleScript
Plug 'vim-scripts/applescript.vim'
" Markdown live preview
"Plug 'suan/vim-instant-markdown', { 'for': 'markdown' }
"TODO put this in a better place
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_allow_external_content = 0
"TODO this is probably not the best thing...
"set shell=/bin/bash
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'cespare/vim-toml'
Plug 'peitalin/vim-jsx-typescript'
" for flow
"Plug 'flowtype/vim-flow'

" actual plugins
"Plug 'w0rp/ale'
Plug 'vim-syntastic/syntastic'
Plug 'rking/ag.vim'
" this plugin auto-generates boilerplate HTML
Plug 'mattn/emmet-vim', { 'for': 'html' }
" Python tooling
"Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" extended % matching to HTML; put this before vim-sensible
Plug 'tmhedberg/matchit'
" good vim defaults
Plug 'tpope/vim-sensible'
" easy comment/uncomment
Plug 'scrooloose/nerdcommenter'
" easily align text into columns
"Plug 'godlygeek/tabular'
" better star search
Plug 'nelstrom/vim-visual-star-search'
" better file browser. disabled because slow to start up
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" better file finder
Plug 'kien/ctrlp.vim'
" better buffer management
"Plug 'jeetsukumaran/vim-buffergator'
" autocomplete
if has('nvim')
    Plug 'Shougo/deoplete.nvim'
    let g:deoplete#enable_at_startup = 1
else
    if has('lua')
        Plug 'Shougo/neocomplete.vim'
        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplete#enable_at_startup = 1
	else
		"Plug 'Valloric/YouCompleteMe'
    endif
endif
" this plugin only exists to show current branch info in statusline. disabled
" because slow to start up
"Plug 'tpope/vim-fugitive'
" this is the statusline plugin
Plug 'itchyny/lightline.vim'
" display buffers as tabs
"Plug 'ap/vim-buftabline'
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
" automatically jsdoc for javascript
Plug 'heavenshell/vim-jsdoc'

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_running")
    " set GUI options
    set guifont=Source_Code_Pro:h15
    " hide toolbar in gVim
    set guioptions-=T
    "colorscheme solarized
    colorscheme molotov
    "set background=light
    let g:solarized_termcolors=256
else
    "let g:molotov = 1

    set background=dark
    "colorscheme molokai
	colorscheme afterglow

    " enables solarized theme in terminal
    let g:solarized_termcolors=256

    " pretty colours for tabline only in non-GUI mode
    highlight TabLineFill ctermfg=8 ctermbg=Black
    highlight TabLine ctermfg=LightGrey ctermbg=8
    highlight TabLineSel ctermfg=White ctermbg=4
endif

""""""""""""""""""" lightline config """"""""""""""""""""""""""""
" basic: just includes colorscheme
"let g:lightline = {
      "\ 'colorscheme': 'wombat',
    "\}
" first part changes the appearance of INSERT etc
" second part adds lock to read-only part of statusline
" 3-4 makes pretty separators
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" buftabline config """""""""""""""""""""""""""
if exists("g:buftabline_show")
    " show vim-internal buffer number for faster buffer switching
    let g:buftabline_numbers = 1
    " allow Mac to switch between buffers using command + #
    nmap <D-1> <Plug>BufTabLine.Go(1)
    nmap <D-2> <Plug>BufTabLine.Go(2)
    nmap <D-3> <Plug>BufTabLine.Go(3)
    nmap <D-4> <Plug>BufTabLine.Go(4)
    nmap <D-5> <Plug>BufTabLine.Go(5)
    nmap <D-6> <Plug>BufTabLine.Go(6)
    nmap <D-7> <Plug>BufTabLine.Go(7)
    nmap <D-8> <Plug>BufTabLine.Go(8)
    nmap <D-9> <Plug>BufTabLine.Go(9)
    nmap <D-0> <Plug>BufTabLine.Go(10)
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" remember more """""""""""""""""""""""""""""""
set history=1000
set undolevels=1000
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" Language-Specific """""""""""""""""""""""""""
" add support for go types
set runtimepath+=$GOROOT/misc/vim
" all *.md files refer to markdown
autocmd BufNewFile,BufReadPost *.md setlocal filetype=markdown conceallevel=0 linebreak spell
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 0
" allow .js files to have React-style highlighting
let g:jsx_ext_required = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""" Python options """""""""""""""""""""""""""""""
autocmd FileType python setlocal foldenable foldlevel=20
"""""""""""""""""" Python options """""""""""""""""""""""""""""""

filetype plugin indent on
syntax on
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
set noexpandtab
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
"set ignorecase
set smartcase

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
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""" Show current syntax group """""""""""""""""""""""
map <leader>syn :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""" F-key mappings """""""""""""""""
nmap <F8> :TagbarToggle<CR>
nmap <F7> :NERDTreeToggle<CR>
"nmap <F7> :Vexplore<CR>
nmap <F5> :Make<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""" NERDTree config """""""""""""""""""
if has('NERDTree')
    " NERDTree will cd when you cd
    "let NERDTreeChDirMode=2
    let NERDTreeIgnore = ['\.pyc$']
    "set autochdir
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""" Pretty tab-bar """"""""""""""""""""
" always show tab bar
set showtabline=2
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yank directly into system clipboard
"set clipboard=unnamed

" allow buffers to be in the background
set hidden
"set cursorline

""""""""""""" Ctrl-p options """"""""""""""""""""
let g:ctrlp_custom_ignore = {
            \ 'file': '\v\.(pyc|class|pem|lock)',
			\ 'dir': '\.git$\|node_modules$\|venv$\|venv3$'
            \}
" persist the ctrlp cache
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" use ag if available
"if executable('ag')
    "let g:ctrl_user_command = 'ag %s -l --nocolor -g ""'
"endif
""""""""""""" Ctrl-p options """"""""""""""""""""

""""""""""""" vim-json options """"""""""""""""""
let g:vim_json_syntax_conceal = 0
""""""""""""" vim-json options """"""""""""""""""

" crontab options
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

"""""""""" simpylfold options """"""""""""""""""
let g:SimpylFold_fold_import = 0
let g:SimpylFold_docstring_preview = 0
set foldmethod=syntax
""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=
set wildignore+=*.pyc
set wildignore+=*.zip
set wildignore+=*.avro
set wildignore+=*.npz
set wildignore+=tags

"""""""""" ale linter """"""""""""""""""""""""""
"au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
"let g:ale_linters = {'jsx': ['eslint']}
""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""" syntastic linter """"""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = []
let g:syntastic_python_checkers = ['pyflakes']
"let g:syntastic_typescript_checkers = ['tslint']
""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""" vim-flow """""""""""""""""""
" do not show quickfix menu when there are no errors
let g:flow#autoclose = 1
""""""""""""""""""" netrw """"""""""""""""""""""

""""""""""""""""""" netrw """"""""""""""""""""""
" this is the neovim file navigation vewer
if has('nvim')
    let g:netrw_banner = 0
endif
""""""""""""""""""" netrw """"""""""""""""""""""

" allow for project-specific vim files
set exrc
set secure
