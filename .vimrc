" " is comment
"#                             backup
"
set backup
set directory=~/tmp
set backupdir=~/tmp/backup

"#                            save 'n' copies of edited files
"
set patchmode=.clean
let savevers_max = 3 
let savevers_dirs = &backupdir

"#                           misc options 
"
set showcmd
set number
set nowrap
set smartindent

"#                            fold stuff
"
set syntax=sh
let tcl_fold_enabled=7
let sh_fold_enabled=7
syntax region tclBlock  start="{" end="}" transparent fold
autocmd BufRead,BufNewFile *.src set filetype=fortran
set foldmethod=syntax
set showmatch
set hlsearch
filetype plugin on

"#                            commands
command R r
command Nn :set nonumber
command Hof :set nohlsearch
command Hon :set hlsearch
command Q q
command Wq wq
command W  wq
command WQ wq
command QQ q!
command Ve :split /fsnfs/users/nikiforo/scripts/not-chemical/ee.sh
command Vv :split ~/.vimrc
command Se :s/start/end
command Spmndo :sp /fsnfs/users/nikiforo/Documents/tutorials/mndo/mndo99.cpp

"#                            Abbreviations
abbreviate Eb #!/bin/bash
abbreviate Cc    #                                                    #
abbreviate Ch    #                           
abbreviate Cm    --------------------------- 
abbreviate Ps print::putsnow "[dict get [info frame 0] proc] starts"
abbreviate Pe print::putsnow "[dict get [info frame 0] proc] ends"
abbreviate Bs emf $FUNCNAME starts 
abbreviate Be emf $FUNCNAME ends && return 0
"abbreviate Bs echo "--------------------------- $FUNCNAME starts ---------------------------"
"abbreviate Be echo "--------------------------- $FUNCNAME ends   ---------------------------"
"abbreviate Bs echo "# \$FUNCNAME starts "
"abbreviate Be echo "# \$FUNCNAME ends "
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

abbreviate Vmd var vmd "/usr/users/nikiforo/bin/vmd/vmd" -check_if_file_exists \|\| exit 1
"#                            colorscheme
"colorscheme
"colorscheme evening
colorscheme mine
"make comments grey
"
"#                            for laptop
"set background=dark
"set t_Co=16
":highlight Normal ctermbg=black
hi Comment ctermfg=DarkGrey
"

"#                            tabs
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
"#                             mapping 
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
" #                            Trying to make Alt work
" http://vi.stackexchange.com/questions/2350/how-to-map-alt-key
" also changed ~/.Xdefaults with : 'xterm*metaSendsEscape: true', and 
" 'xrdb -l ~/.Xdefault' executed in terminal after
" not Alt-c is make a comment in bash
"map <\ec> ^i#
execute "set <M-c>=\ec"
map <M-c> ^i#<Esc>
vnoremap <M-c> I#<Esc>
"execute "set <M-w>=\ew"
"map <M-w> <C-w>

"execute "set <M-q>=\eq"
"map <M-q> :wq<CR>
"#                            mapping Alt-j,Alt-k to do up or down to fold
"execute "set <M-j>=\ej"
map <C-j> zj
"execute "set <M-k>=\ek"
map <C-k> zk

"#                            mapping searching word under cursor
" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
execute "set <M-r>=\er"
nnoremap <M-r> :%s/\<<C-r><C-w>\>/
"
map <C-y> yyp
"#                             when type () in bash file it creates function {
"
"autocmd FileType sh  inoremap ()   () {<CR>emf $FUNCNAME starts<CR>emf $FUNCNAME ends && return 0<CR>} <Esc>kko
"autocmd FileType sh  inoremap ()   () { _<CR>_; } <Esc>ko
autocmd FileType sh  inoremap ()   () { _<CR>} <Esc>ko
"autocmd FileType sh  inoremap ()   () {<CR>echo $FUNCNAME starts<CR>echo $FUNCNAME ends && return 0<CR>} <Esc>kko
"autocmd FileType sh  inoremap ()   () {<CR>emf_bashrc $FUNCNAME starts<CR>emf_bashrc $FUNCNAME ends && return 0<CR>} <Esc>kko
autocmd FileType tcl inoremap {}   {} {<CR>print::putsnow "[dict get [info frame 0] proc] starts"<CR>print::putsnow "[dict get [info frame 0] proc] ends"<CR>} <Esc>kko
"autocmd FileType sh inoremap ()   () {<CR>emf \$FUNCNAME starts<CR>emf \$FUNCNAME ends && return 0<CR>} <Esc>kko
"autocmd FileType sh abbreviate then then<CR>fi<ESC><C-<><Up>o
"autocmd FileType sh abbreviate do do<CR>done<ESC><C-<><Up>o
"
"#                            set pastemode toggle to insert code from internet
" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
set pastetoggle=<F6>

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

"#                            helpful command for tex-report
command RmColorsFromDashCells :s/\\cellcolor{red} -/ -/g

"#                            netrw listin styles
let g:netrw_banner            = 0
"#                            vim markdown
let g:vim_markdown_folding_disabled = 1

"# vim asciidoc
set syntax=asciidoc

