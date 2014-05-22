set background=dark
highlight clear

if exists("syntax on")
    syntax reset
endif

let g:colors_name = "dbk_sublime"

" general
highlight Comment ctermfg=8
highlight String ctermfg=142
highlight LineNr ctermfg=grey ctermbg=8
highlight Number ctermfg=164
highlight link Constant Number
highlight Type ctermfg=111
highlight Statement ctermfg=161
highlight link Conditional Statement
highlight Function ctermfg=40
highlight link Builtin Type

" Go-specific
highlight link goDirective Statement
highlight link goDeclaration Type 

" Vim-specific
highlight link vimCommand Type
highlight link vimHighlight Type
highlight link vimHiClear Constant
highlight link vimOption vimHiClear
highlight link vimGroup Type

" HTML-specific
highlight htmlArg ctermfg=2
highlight htmlTag ctermfg=7
highlight link htmlEndTag htmlTag

" Python-specific
highlight link pythonBuiltin Type
