set background=dark
highlight clear

if exists("syntax on")
    syntax reset
endif

let g:colors_name = "dbk_sublime"

" general
highlight Comment ctermfg=34
highlight String ctermfg=142
highlight LineNr ctermfg=grey ctermbg=8
highlight Number ctermfg=164
highlight Constant ctermfg=164
highlight Type ctermfg=111
highlight Statement ctermfg=161
highlight Conditional ctermfg=161

" Go-specific
highlight goDirective ctermfg=161
highlight goDeclaration ctermfg=111
highlight goConstants ctermfg=164
highlight goBuiltins ctermfg=111
highlight goDeclType ctermfg=111

" Vim-specific
highlight vimCommand ctermfg=111
highlight vimHighlight ctermfg=111
highlight vimHiClear ctermfg=127
highlight vimOption ctermfg=127
