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
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias vim='nvim'

# fd
alias find=fdfind

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
    IN_GIT=$(git rev-parse --is-inside-work-tree 2>/dev/null)
    if [ -n "$IN_GIT" ]; then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/⎇  \1/'
        unset IN_GIT
    fi
}

if [ "$color_prompt" = yes ]; then
    # User
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;37m\033[40m 🐷 \u@\h'
    PS1+='\[\033[0;30m\033[104m█'

    # Directory
    PS1+='\[\033[0;30m\033[104m 🖿  \w'
    PS1+='\[\033[0m\033[1;34m█'

    # Branch
    PS1+='\[\033[1;94m$(parse_git_branch)\033[0;93m'
    PS1+='\[\033[00m\]'

    # Input
    PS1+='\'\n'⮩ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\'\n'⮩ '
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

# zoxide
eval "$(zoxide init bash --cmd cd)"

random_number1=$((1 + RANDOM % 6))
random_number2=$((1 + RANDOM % 6))
C1='\033[1;9'$random_number1'm'
C2='\033[1;9'$random_number2'm'
echo -e ${C1}' __       ______  __   __'            ${C2}'   ______     ___   ___  ___'
echo -e ${C1}'/\\ \\     /\\  ___\\/\\ \\__\\ \\'   ${C2}' /\\  __ \\   /  _`./\\  `.\\  \\'
echo -e ${C1}'\\ \\ \\    \\ \\ \\___\\ \\__  __\\' ${C2}'\\ \\ \\_\\ \\_/\\  \\\\ \\ \\   `\\  \\'
echo -e ${C1}' \\ \\ \\    \\ \\  ___\\/_/\\ \\/'   ${C2}'  \\ \\  ___ \\ \\  __ \\ \\       \\'
echo -e ${C1}'  \\ \\ \\____\\ \\ \\____ \\ \\ \\'  ${C2}'   \\ \\ \\__\\ \\ \\ \\/\\ \\ \\ `.    \\'
echo -e ${C1}'   \\ \\______\\ \\_____\\ \\ \\_\\'  ${C2}'   \\ \\______\\ \\_\\ \\_\\ \\_\\ `.__\\'
echo -e ${C1}'    \\/______/\\/_____/  \\/_/'       ${C2}'    \\/______/\\/_/\\/_/\\/_/`./__/'
echo ""
unset C1 C2 random_number1 random_number2

