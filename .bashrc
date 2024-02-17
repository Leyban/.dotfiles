# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# if [ -n "$force_color_prompt" ]; then
#     if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#         # We have color support; assume it's compliant with Ecma-48
#         # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#         # a case would tend to support setf rather than setaf.)
#         color_prompt=yes
#     else
#         color_prompt=
#     fi
# fi

# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias vim='nvim'

alias ipdocker='docker inspect -f "{{.Name}}:{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -q) | sed "s/\///" | sed "s/:/\t/"'

#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Show git branch name
force_color_prompt=yes
color_prompt=yes

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

if [ "$color_prompt" = yes ]; then
    # User
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;90m\033[107m  \u@\h'
    PS1+='\[\033[1;97m\033[44m█◤'
    # Directory
    PS1+=' 🖿  \w'
    PS1+='\[\033[0;34m\033[103m█◤'

    # Branch
    PS1+='\[\033[1;90m\033[103m⎇  $(parse_git_branch)\033[0;93m'
    PS1+='█◤\[\033[00m\]'

    # Input
    PS1+='\'\n'⮩ 🐷 '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\'\n'⮩ 🐷 '
fi
unset color_prompt force_color_prompt


# Ignore Case
bind 'set completion-ignore-case on'

# direnv
eval "$(direnv hook bash)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Cargo PATH
export PATH=$PATH:/home/user/.cargo/bin

# NVIM PATH
export PATH=$PATH:/usr/local/nvim/bin

# NEOVIM EDITOR
export VISUAL=nvim
export EDITOR="$VISUAL"

# GO ENV
export PATH=$PATH:/usr/local/go/bin

# JAVA ENV
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin

# I don't know what this is for
export PDSH_RCMD_TYPE=ssh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

YELLOW='\033[1;33m'
BLUE='\033[1;94m'
echo -e ${YELLOW}' __       ______  __   __'            ${BLUE}'  ______     ___   ___  ___'
echo -e ${YELLOW}'/\\ \\     /\\  ___\\/\\ \\__\\ \\'   ${BLUE}'/\\  __ \\   /  _`./\\  `.\\  \\'
echo -e ${YELLOW}'\\ \\ \\    \\ \\ \\___\\ \\__  __\\' ${BLUE}' \\ \\_\\ \\_/\\  \\\\ \\ \\   `\\  \\'
echo -e ${YELLOW}' \\ \\ \\    \\ \\  ___\\/_/\\ \\/'   ${BLUE}' \\ \\  ___ \\ \\  __ \\ \\       \\'
echo -e ${YELLOW}'  \\ \\ \\____\\ \\ \\____ \\ \\ \\'  ${BLUE}'  \\ \\ \\__\\ \\ \\ \\/\\ \\ \\ `.    \\'
echo -e ${YELLOW}'   \\ \\______\\ \\_____\\ \\ \\_\\'  ${BLUE}'  \\ \\______\\ \\_\\ \\_\\ \\_\\ `.__\\'
echo -e ${YELLOW}'    \\/______/\\/_____/  \\/_/'       ${BLUE}'   \\/______/\\/_/\\/_/\\/_/`./__/'
unset YELLOW BLUE

