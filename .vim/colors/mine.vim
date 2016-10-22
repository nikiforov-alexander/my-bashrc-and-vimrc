" Vim color file
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2001 Jul 23

" This is the default color scheme.  It doesn't define the Normal
" highlighting, it uses whatever the colors used to be.

" Set 'background' back to the default.  The value can't always be estimated
" and is then guessed.
hi clear Normal
set bg&

" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "default"


set t_Co=256
hi Folded     cterm=bold ctermbg=black ctermfg=DarkBlue
"hi Folded     cterm=bold ctermbg=DarkGrey ctermfg=darkgray guibg=LightGrey guifg=DarkBlue
"hi FoldColumn term=standout ctermbg=DarkGrey ctermfg=DarkBlue guibg=Grey      guifg=DarkBlue
hi Function term=bold               ctermfg=Yellow 
" vim: sw=2
