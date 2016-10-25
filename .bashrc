# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=200000
echo " HISTSIZE is $HISTSIZE"
HISTFILESIZE=200000
echo " HISTFILESIZE is $HISTFILESIZE" 
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;31m\]\u@home \[\033[01;33m\]:)'; fi)\[\033[01;34m\] \W \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\033[00m\] "
#PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;31m\]\u@\h \[\033[01;33m\]:)'; fi)\[\033[01;34m\] \W \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\033[00m\] "
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

########################### rotational completion ########################### 
bind '"\C-i" menu-complete'

#                          functions 

echo_var () {
    error_echo_var="echo_var error:"
    case $# in
        0) echo $error_echo_var has to be at least one argument && return 1 ;;
        1) eval "echo var $1 is \$$1" ;;
        *) echo $error_echo_var too many args: $@ && return 1 ;;
    esac
} 

set_java_environment_bashrc () {
    #export JAVA_HOME="/home/nikiforo/bin/jre1.8.0_73"
    export JAVA_HOME="/home/nikiforo/src/jdk1.8.0_73"
    export JRE_HOME=$JAVA_HOME
    export PATH="$PATH:$JAVA_HOME/bin"
    echo JAVA_HOME is $JAVA_HOME
}

add_eclipse_to_path () {
    export PATH="$PATH:/home/nikiforo/bin/eclipse/java-mars/eclipse/eclipse"
    which eclipse 
}

source_aliases_bashrc () {
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
}

set_git_vars () { 
    export GIT_EDITOR=vim
    echo_var GIT_EDITOR 
} 

set_MY_vars_src_bin_dir_etc () { 
    export MY_BIN_DIR=$HOME/bin
    export MY_SRC_DIR=$HOME/src
    export MY_TMP_DIR=$HOME/tmp
    echo_var MY_BIN_DIR
    echo_var MY_SRC_DIR
    echo_var MY_TMP_DIR
} 
#                            body                           #   

echo "cd works with listing"

set_java_environment_bashrc

add_eclipse_to_path

source_aliases_bashrc

cd () {
    builtin cd "$@" && ] 
}

set_git_vars

set_MY_vars_src_bin_dir_etc 

cd $HOME
#                            end                            #   

