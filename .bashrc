# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

emf_bashrc () { #helpful function to print functions inside bashrc script
    bashrc=~/.bashrc
    [ ! -f $bashrc ] && echo $@ && return
    tput setaf 0 && tput bold
    if [ `grep -c "\<$1\> ()" $bashrc` -eq 1 ] ; then
        INDENT=`grep "\<$1\> ()" $bashrc | awk ' BEGIN {FS=""} 
                                                { 
                                                    for(i=1;i<=NF;i++) {
                                                        if($i==" ") a++; else {print a;exit}
                                                    }
                                                }'`
        for ((count=1;count<=${INDENT:=0};count++)) ; do
            echo -n " "
        done
        grep "\<$1\> ()" $bashrc | awk -v arg=$2 '{print "#",$1,arg}' 
    else
        grep -c "\<$1\> ()" $bashrc
    fi
    unset count
    tput sgr0
} 
em_bashrc () { #helpful function to print expressions inside functions
    for ((count=1;count<=${INDENT:=0};count++)) ; do
        echo -n " "
    done
    i=1
    for arg in $@ ; do
        tput setaf $i && tput bold 
        echo -n "$arg "
        let i=$i+1
    done
    echo
    tput sgr0
    unset i
    unset arg
    unset count
} 

check_whether_we_have_interactive_shell_bashrc () {
    emf_bashrc $FUNCNAME starts
    if [ -z "$PS1" ] ; then
        em "\$PS1" is empty 
        return
    else
        em_bashrc shell is interactive
        em_bashrc PS1 is $PS1
    fi
    
} 
set_history_settings_bashrc () {
    emf_bashrc $FUNCNAME starts
    # don't put duplicate lines in the history. See bash(1) for more options
    # ... or force ignoredups and ignorespace
    HISTCONTROL=ignoredups:ignorespace
    em_bashrc "HISTCONTROL is $HISTCONTROL"
    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=200000
    HISTFILESIZE=200000
    em_bashrc HISTSIZE is $HISTSIZE
    em_bashrc HISTFILESIZE is $HISTFILESIZE

    # append to the history file, don't overwrite it
    em_bashrc history is appended, not overwritten, \"shopt -s histappend\"
    shopt -s histappend
    
} 
check_the_window_size_after_each_command_and_if_necessary_update_it_bashrc () {
    emf_bashrc $FUNCNAME starts
    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    em_bashrc "shopt -s checkwinsize"
    shopt -s checkwinsize
    
} 
make_less_more_friendly_for_non_text_input_files_bashrc () {
    emf_bashrc $FUNCNAME starts
    # make less more friendly for non-text input files, see lesspipe(1)
    if [ -x /usr/bin/lesspipe ] ; then
        eval "$(SHELL=/bin/sh lesspipe)"
        emf 'eval "$(SHELL=/bin/sh lesspipe)"'
    else
        em_bashrc lesspipe doesnt exist
    fi
    
} 
set_variable_identifying_the_chroot_you_work_in_bashrc () {
    emf_bashrc $FUNCNAME starts
    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
        em_bashrc debian_chroot is $debian_chroot
    fi
    
} 

set_color_prompt_bashrc () {
    emf_bashrc $FUNCNAME starts
    check_if_TERM_is_xterm_color () {
        emf_bashrc $FUNCNAME starts
        # set a fancy prompt (non-color, unless we know we "want" color)
        case "$TERM" in
            xterm-color) 
                color_prompt=yes 
                em_bashrc TERM is $TERM, so color_prompt = yes
            ;;
            *) echo TERM is $TERM, just chilling ;;
        esac
        
    } 
    check_if_tput_exist_and_setaf_is_enabled () {
        emf_bashrc $FUNCNAME starts
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            color_prompt=yes
            em_bashrc /usr/bib/tput exist and tput setaf is supported, so color_prompt = yes
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
        else
            color_prompt=
            em_bashrc 'color_prompt=' empty?
        fi
        
    } 
    #                         #  body #                         #   
    check_if_TERM_is_xterm_color
    check_if_tput_exist_and_setaf_is_enabled
    #                         #  end  #                         #   
    
} 
enable_color_support_of_ls_and_also_add_handy_aliases_bashrc () {
    emf_bashrc $FUNCNAME starts
    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        em_bashrc /usr/bin/dircolors exist and is executable
        if [ -r ~/.dir_colors ] ; then
            em_bashrc ~/.dir_colors exist, we execute /usr/bin/dircolors with ~/.dir_colors
            eval "$(dircolors -b ~/.dir_colors)" 
        else
            em_bashrc ~/.dir_colors doesnt exist, we execute /usr/bin/dircolors without ~/.dir_colors
            eval "$(dircolors -b)"
        fi
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
        em_bashrc setting \"color = auto option\" to \"ls\",\"dir\",\"vdir\",\"grep\",\"fgrep\",\"egrep\"
    else
        em_bashrc /usr/bin/dircolors doesnt exist
    fi
    
} 
set_command_prompt_PS1_bashrc () {
    emf_bashrc $FUNCNAME starts
    check_if_term_is_xterm_or_rxvt_and_set_prompt_PS1_accordingly_bashrc () {
        emf_bashrc $FUNCNAME starts
        em_bashrc TERM is $TERM,
        case "$TERM" in
            xterm*|rxvt*)
                # If this is an xterm set the title to user@host:dir
                PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
                em_bashrc setting PS1 to user@host:dir
            ;;
            *) em_bashrc just chilling ;;
        esac
        
    } 
    #PS1="bash-\W->"
    PS1="$( if [[ ${EUID} == 0 ]] ; then \
                echo '\[\033[01;31m\]\h'; \
            else \
                echo '\[\033[01;31m\]\u@\h \[\033[01;33m\]:)'; \
            fi )\[\033[01;34m\] \W \n \$( [[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\033[00m\] "
    # see here details https://wiki.archlinux.org/index.php/Color_Bash_Prompt
    
} 

enable_programmable_completion_features_bashrc () {
    emf_bashrc $FUNCNAME starts
    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        em_bashrc check shopt -oq posix
        shopt -oq posix
        em_bashrc status is $?
        em_bashrc /etc/bash/completion is exist and shopt -oq posix returns 1
        source /etc/bash_completion
    fi
    
}
enable_rotational_completion () {
    emf_bashrc $FUNCNAME starts
    bind '"\C-i" menu-complete'
    
} 

err_handle () { # returning status of each command executed
    status=$?
    if [ $status -eq 0 ] ; then
          tput setaf 2 && tput bold 
          echo status is $status
          tput sgr0 
    else
          tput setaf 1 && tput bold 
          echo status is $status
          tput sgr0 
    fi  
}
source_if_exist () { # handy function to check before source 
    echo $FUNCNAME $1 starts
    case $# in 
        1) 
            if [ -f $1 ] ; then
                source $1
            else 
                em_bashrc file $1 doesnt exist && return 1 
            fi
        ;;
        *) em_bashrc only one argument is supported && return 1 ;;
    esac
    echo $FUNCNAME $1 ends && return 0
} 

export_global_vars_bashrc () {
    echo $FUNCNAME starts
    export_f_to_fsnfs_users_nikiforo () {
        emf_bashrc $FUNCNAME starts
        export f="/fsnfs/users/nikiforo"
        em_bashrc f is $f
        
    } 
    export_library_paths () {
        emf_bashrc $FUNCNAME starts
        export LD_LIBRARY_PATH=/usr/lib64:/usr/lib:/fsnfs/users/nikiforo/lib  
        export LIBRARY_PATH=/usr/lib64:/usr/lib:/fsnfs/users/nikiforo/lib 
        
    } 
    export_path_adding_sge_stuff_usr_bin_and_usr_lib_mit_bin () {
        emf_bashrc $FUNCNAME starts
        export PATH=/fsnfs/users/sge-6.2/bin/lx24-amd64:/usr/bin/:/bin:/usr/lib/mit/bin
        
    } 
    export_pkg_config_path () {
        emf_bashrc $FUNCNAME starts
        export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:/usr/share/pkgconfig
        
    } 
    export_cpaths () {
        emf_bashrc $FUNCNAME starts
        export CPATH=/usr/include
        export C_INCLUDE_PATH=/usr/include
        export CPLUS_INCLUDE_PATH=/usr/include
        
    } 
    export_manpath () {
        emf_bashrc $FUNCNAME starts
        export MANPATH=/fsnfs/users/sge-6.2/man:/usr/share/man:/usr/local/man:/opt/mpich/man:/usr/local/man:/usr/share/man:/opt/mpich/man
        
    } 

    export_cvs_vars_to_work_with_eva_and_mndo () {
        emf_bashrc $FUNCNAME starts
        export CVSEDITOR='/usr/bin/vim'
        export CVSROOT=':pserver:nikiforo@op22th1:/ns80th/nas/users/cvs/cvsroot'
        export CVS_RSH=ssh
        em_bashrc "CVSROOT is $CVSROOT"
        em_bashrc "CVS_RSH is $CVS_RSH"
        em_bashrc "CVSEDITOR is $CVSEDITOR"
        
    } 
    export_SGE_vars_just_in_case_they_are_empty () {
        emf_bashrc $FUNCNAME starts
        export SGE_ROOT=/fsnfs/users/sge-6.2
        export SGE_CELL=default
        export SGE_CLUSTER_NAME=p6444
        em_bashrc SGE_ROOT is $SGE_ROOT
        em_bashrc SGE_CELL is $SGE_CELL
        em_bashrc SGE_CLUSTER_NAME is $SGE_CLUSTER_NAME
        
    } 
    export_TEXINPUTS_and_possibly_all_related_to_tex_stuff () {
        emf_bashrc $FUNCNAME starts
        export TEXMFHOME="$HOME/texmf"
        #export TEXINPUTS="$TEXMFHOME"
        #em_bashrc TEXINPUTS is $TEXINPUTS
        
    } 
    add_tex_live_to_path_and_manpath () {
        emf_bashrc $FUNCNAME starts
        export MANPATH=$MANPATH:/fsnfs/users/nikiforo/bin/texlive/2014/texmf-dist/doc/man
        export PATH=$PATH:/fsnfs/users/nikiforo/bin/texlive/2014/bin/x86_64-linux
        
    } 
    add_columbus_and_perl5lib_path () {
        emf_bashrc $FUNCNAME starts
        #export COLUMBUS=/fsnfs/users/bin/COLUMBUS7/C70_beta.2011-03-24/Columbus
        export OLD_COLUMBUS=/fsnfs/users/bin/COLUMBUS7/C70_beta.2011-03-24/Columbus
        export MyCOLUMBUS=/fsnfs/users/nikiforo/src/columbus-binary-my-try/Columbus
        #export COLUMBUS=/fsnfs/users/nikiforo/src/columbus-binary-my-try/Columbus
        #export COLUMBUS=/fsnfs/users/nikiforo/src/c2-comp-by-me-col-with-shell-include/Columbus
        #export COLUMBUS=/fsnfs/users/nikiforo/src/columbus/c2-april-2014-source/Columbus
        #export COLUMBUS=/fsnfs/users/nikiforo/src/columbus/c1-april-2014-bin-release/Columbus
        export COLUMBUS="/fsnfs/users/nikiforo/src/columbus/c3-jan-2015-bin-release/Columbus"
        export PATH=$PATH:$COLUMBUS
        export PERL5LIB="/fsnfs/users/nikiforo/src/perl_libs_for_columbus:$COLUMBUS"
        export PERL5LIB="$PERL5LIB:$COLUMBUS"
        export PERL5LIB="$PERL5LIB:$COLUMBUS/CPAN"
        export PERL5LIB="$PERL5LIB:$COLUMBUS/perlscripts"
        em_bashrc "COLUMBUS is $COLUMBUS"
        
    } 

    source_different_paths_for_diff_progs_bashrc () {
        emf_bashrc $FUNCNAME starts
        #source /fsnfs/users/nikiforo/bin/paths/paths-for-openmd.sh
        #source /fsnfs/users/nikiforo/bin/paths/paths-for-vmd.sh
        #source /fsnfs/users/nikiforo/bin/paths/paths-for-opengl.sh
        source_if_exist /fsnfs/users/nikiforo/bin/paths/paths-for-c-include-files.sh
        source_if_exist /fsnfs/users/nikiforo/bin/paths/paths-for-ffmpeg.sh
        #source /fsnfs/users/nikiforo/bin/paths/paths-for-vmd.sh
        #source /fsnfs/users/nikiforo/bin/paths-for-valgrind.sh
        source_if_exist /fsnfs/users/nikiforo/bin/paths/path-printout.sh
        
    } 
    deprecated_commented () {
        emf_bashrc $FUNCNAME starts
        #export PATH=$PATH:/fsnfs/users/nikiforo/bin/netpbm/bin # path for a ppmtompeg 
        
    } 
    export_MOPAC_variables_bashrc () {
        emf_bashrc $FUNCNAME starts
        export MOPAC_LICENSE="/fsnfs/users/nikiforo/src/mopac2016/"
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/fsnfs/users/nikiforo/src/mopac2016/lib"
        
    } 
    export_java_vars_jdk_to_run_idea () { 
        emf_bashrc $FUNCNAME starts
       export JAVA_HOME="/usr/users/nikiforo/src/jdk1.8.0_73"
       export JAVA_BINDIR="$JAVA_HOME/bin"
       
    } 
    #                         #  body #                         #  
    export_f_to_fsnfs_users_nikiforo
    export_library_paths
    export_path_adding_sge_stuff_usr_bin_and_usr_lib_mit_bin
    export_pkg_config_path
    export_cpaths
    export_manpath

    export_cvs_vars_to_work_with_eva_and_mndo
    export_SGE_vars_just_in_case_they_are_empty
    export_TEXINPUTS_and_possibly_all_related_to_tex_stuff
    add_tex_live_to_path_and_manpath
    add_columbus_and_perl5lib_path

    source_different_paths_for_diff_progs_bashrc
    export_MOPAC_variables_bashrc
    export_java_vars_jdk_to_run_idea
    #                         #  end  #                         #   
    echo $FUNCNAME ends && return 0
} 

source_aliases_bashrc () {
    emf_bashrc $FUNCNAME starts
    source_if_exist /fsnfs/users/nikiforo/scripts/not-chemical/.aliases-i-know-well-bash 
    source_if_exist /fsnfs/users/nikiforo/scripts/not-chemical/.bash-aliases-new 
    
} 
add_programs_to_path_to_use_them_bashrc () {
    emf_bashrc $FUNCNAME starts
    add_htop_to_path_bashrc () {
        emf_bashrc $FUNCNAME starts
        ########################### htop ########################### 
        export PATH=$PATH:/fsnfs/users/nikiforo/bin/htop/bin:~/bin/vmd
        
    } 
    add_turbmole_to_path () { 
        export TURBODIR=/usr/users/turbomole66
        export TURBOMOLE_SYSNAME="x86_64-unknown-linux-gnu"
        export PATH=$PATH:$TURBODIR/scripts
        export PATH=$PATH:$TURBODIR/bin/$TURBOMOLE_SYSNAME
    } 
    add_grrm_to_path () { 
        export GRRMroot="/fsnfs/users/grrm14/"
        export PATH=$PATH:$GRRMroot
    } 
    #                         #  body #                         #   
    add_htop_to_path_bashrc
    add_turbmole_to_path
    add_grrm_to_path
    #                         #  end  #                         #   
    
} 

set_ifort_compiler_bashrc () {
    emf_bashrc $FUNCNAME starts
    source_ifort_and_mkl_vars_for_mndo_run_axel_scripts () {
        emf_bashrc $FUNCNAME starts
        #source /usr/users/bin/intel/composer_xe_2013/bin/compilervars.sh intel64
        #source /usr/users/bin/intel/composer_xe_2013_sp1/mkl/bin/mklvars.sh intel64
        
    } 
    set_ifort_manually_adding_the_path () {
        emf_bashrc $FUNCNAME starts
        export PATH=$PATH:/usr/users/bin/intel/composer_xe_2013/bin
        
    } 
    #                         #  body #                         #   
    source_ifort_and_mkl_vars_for_mndo_run_axel_scripts
    set_ifort_manually_adding_the_path
    em_bashrc which ifort
    which ifort
    #                         #  end #                         #   
    
} 

add_stty_ixon_to_fix_map_ctrl_q_problem_in_vim () {
    emf_bashrc $FUNCNAME starts
    stty -ixon
    
}
#                         #  body #                         #  
check_whether_we_have_interactive_shell_bashrc
set_history_settings_bashrc
check_the_window_size_after_each_command_and_if_necessary_update_it_bashrc
make_less_more_friendly_for_non_text_input_files_bashrc
set_variable_identifying_the_chroot_you_work_in_bashrc

set_color_prompt_bashrc
enable_color_support_of_ls_and_also_add_handy_aliases_bashrc
set_command_prompt_PS1_bashrc

enable_programmable_completion_features_bashrc
enable_rotational_completion

trap 'err_handle' ERR # see err_handle function 

export_global_vars_bashrc

source_aliases_bashrc
cd () { #                         #  cd with ls of a dir where you enter
    if [ -f $list ] ; then
        #                         #  set list_of_visited_dirs #                         #  
        list="/fsnfs/users/nikiforo/scripts/not-chemical/list-of-visited-dirs.list"
        #                         #  create old_list of visited dirs #                         #   
        [ `awk 'END {print NR}' $list` -ge 1000 ] && cat $list > $list.old && date > $list 
        #                         #  set screen name by counting columns #                         #  
        if [ `tput cols` -le 90 ] ; then
            screen_name="Small left"
        else
            screen_name="Right big"
        fi
        if [ -f $1 ] ; then
            echo $1 is file 
            dir=`echo $1 | awk -F"/" ' { for(i=1;i<NF;i++) printf("%s/",$i) }'`
            echo "dir is $dir"
            builtin cd "$dir" 
            ]
        else
            if [ -d $1 ] ; then
                builtin cd $1 
                ]
            else 
                case $1 in
                    -) 
                        builtin cd - 
                        ]
                    ;;
                    *) 
                        if [ -e $1 ] ; then
                            echo first argument is `file $1`
                            return 1
                        else
                            echo file $1 doesnt exist
                        fi
                    ;;
                esac
            fi
        fi
        #                         #  add date and name of visited dir to list_of_visited_dirs #                         #  
        echo -e `date` "\nSmall left\n$PWD\n" >> $list
        #                         #  unset used vars #                         #  
        unset list
        unset dir
        unset screen_name
    else
        echo file $list doesnt exist, using usual cd
        builtin cd $@
        ls --color=always -xGhop
    fi
}
add_programs_to_path_to_use_them_bashrc

set_ifort_compiler_bashrc

#add_stty_ixon_to_fix_map_ctrl_q_problem_in_vim
#                         #  end #                         #  
