" " is comment
" backup
set backup
set directory=/home/nikiforo/tmp
set backupdir=/home/nikiforo/tmp/backup
"save ver stuff
"set patchmode=.clean
"let savevers_dirs = &backupdir
"let savevers_max = 3 

set showcmd
set number
set nowrap
set smartindent
"fold stuff
set syntax=cpp
let tcl_fold_enabled=7
let sh_fold_enabled=7
syntax region tclBlock  start="{" end="}" transparent fold
set foldmethod=syntax
set showmatch
set hlsearch
filetype plugin on
"commands
command R r
command Nn :set nonumber
command Hof :set nohlsearch
command Hon :set nohlsearch
command Q q
command Wq wq
command W  wq
command WQ wq
command QQ q!
command Ve :split /fsnfs/users/nikiforo/scripts/not-chemical/ee.sh
command Vv :split ~/.vimrc
command Se :s/start/end
"Abbreviations
abbreviate Wgo while getopts hv opt
abbreviate Eb #!/bin/bash
abbreviate Cc    #                                                    #
abbreviate Ch    #                         
abbreviate Cm    --------------------------- 
abbreviate Ps print::putsnow "[dict get [info frame 0] proc] starts"
abbreviate Pe print::putsnow "[dict get [info frame 0] proc] ends"
abbreviate Fa {for(i=1;i<NF;i++) printf("%s-",$i); printf("%s",$NF)}'
abbreviate Vopt echo "alias vv=\"vim $filename\"" > ~/tmp/.tempaliases
abbreviate Emopt em now type ss and then vv to vim this file

abbreviate Fa {for(i=1;i<NF;i++) printf("%s-",$i); printf("%s",$NF)}'
abbreviate Abs_awk function abs(x) { return ((x < 0.0) ? -x : x) } 
abbreviate Chb #                            body                           #  
abbreviate Che #                            end                            #  
abbreviate Bp read -p BREAKPOINT
abbreviate Rb read -p BREAKPOINT
abbreviate Rp read -p BREAKPOINT
abbreviate RP read -p BREAKPOINT
abbreviate RB read -p BREAKPOINT
abbreviate Crd -crdir_if_not_exists \|\| exit 1
abbreviate Chd -check_if_dir_exists \|\| exit 1
abbreviate Chf -check_if_file_exists \|\| exit 1
"colorscheme
colorscheme mine
"make comments grey
hi Comment ctermfg=DarkGrey
"tabs
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

"#                         #  mapping 
map <F2> za
map <F3> zA
map <F5> zR
" same as :wq
map <F10> ZZ 
" same as :q!
map <F8> ZQ
map <F12> :w <CR>
" for script p1- filter
"map <F2> <C-w><C-w>
map <F4> dd
" remap Shift-V bad behavior
map <S-Down> j
map <S-Up> k
"silent -ixon added to bashrc
map <C-q> :wq <CR>
map <C-s> :w <CR>
map <C-l> :q! <CR>
map <C-h> :set nohlsearch <CR>

"#                         #  mapping Ctrl-j, Ctrl-k to scroll funcs
map <C-j> zj
map <C-k> zk

"#                         #  diable folding in markdown
let g:vim_markdown_folding_disabled = 1
"#                         #  set at eighty column anchor 
highlight OverLength ctermbg=black ctermfg=magenta guibg=#592929
match OverLength /\%81v.\+/

"
map <C-y> yyp
"#                             when type () in bash file it creates function {
"
autocmd FileType sh  inoremap ()   () { _<CR>} <Esc>ko
autocmd FileType tcl inoremap {}   {} {<CR>print::putsnow "[dict get [info frame 0] proc] starts"<CR>print::putsnow "[dict get [info frame 0] proc] ends"<CR>} <Esc>kko

"#                            set pastemode toggle to insert code from internet
" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
set pastetoggle=<F6>

"#                         #  enable asciidoc
set syntax=asciidoc

"#                            Experimental vim folding
"
" Set a nicer foldtext function
" http://vim.wikia.com/wiki/Customize_text_for_closed_folds
 set foldtext=MyFoldText()
 function! MyFoldText()
   let line = getline(v:foldstart)
   if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
     let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
     let linenum = v:foldstart + 1
     while linenum < v:foldend
       let line = getline( linenum )
       let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
       if comment_content != ''
         break
       endif
       let linenum = linenum + 1
     endwhile
     let sub = initial . ' ' . comment_content
   else
     let sub = line
     let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
     if startbrace == '{'
       let line = getline(v:foldend)
       let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
       if endbrace == '}'
         let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
       endif
     endif
   endif
   let n = v:foldend - v:foldstart + 1
 " let info = " " . n . " lines"
   let info = " "
   let sub = sub . "                                                                                                                  "
   let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
   let fold_w = getwinvar( 0, '&foldcolumn' )
 " let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
 "  let sub = strpart( sub, 0, winwidth(0) - num_w - fold_w - 1 )
 " return sub . info
  return sub
 endfunction
"#                            Remark to replace dashes with spaces
"http://vim.wikia.com/wiki/Customize_text_for_closed_folds
set fillchars="fold:"
"#                            trying to highlight text more that 80 symbols.Google code style
"highlight OverLength ctermbg=black ctermfg=magenta guibg=#592929
"match OverLength /\%81v.\+/

"#                            different colorscheme for different filetype
autocmd FileType tcl hi Identifier ctermfg=Blue
"autocmd FileType tcl colorscheme koehler
"
"#                            netrw listing styles, when use vim to open
"#                         #  directory
let g:netrw_banner            = 0


"#                          Now using F6 we can replace word unded cursor
"
:nnoremap <F6> :%s/\<<C-r><C-w>\>/
