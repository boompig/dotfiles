" Created by Daniel Kats
" May 27, 2014

highlight clear

if exists("syntax on")
    syntax reset
endif

let g:colors_name = "dbk_sublime"

set t_Co=256
set background=dark
highlight Normal ctermfg=lightgrey ctermbg=black guibg=black guifg=lightgrey

" navigation
highlight netrwDir ctermfg=grey

" general
highlight Comment ctermfg=8 guifg=grey
highlight String ctermfg=185 guifg=yellow
highlight LineNr ctermfg=grey ctermbg=8 guibg=darkgrey guifg=white
highlight Number ctermfg=164 guifg=#F064F5
highlight link Constant Number
highlight Type ctermfg=111 guifg=#90ABF5
highlight Statement ctermfg=161 guifg=#F564A8
highlight link Conditional Statement
highlight Function ctermfg=40 guifg=green
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
highlight link htmlSpecialChar Constant
highlight link htmlH1 Text
highlight link htmlTitle Text
highlight phpRegion ctermfg=12

" Python-specific
highlight link pythonBuiltin Type
highlight link pythonInclude Statement
highlight link pythonNumber Number

" YAML-specific
highlight link yamlKey Statement

" JS-specific
highlight link javaScriptNumber Number
highlight link javaScriptBraces htmlTag
" this is not the function name but just the keyword 'function'
highlight link javaScriptFunction Builtin
highlight link javaScriptIdentifier Builtin
