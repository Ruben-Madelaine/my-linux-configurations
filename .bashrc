[ -z "$PS1" ] && return
PROMPT_DIRTRIM=1 #len of current working directory
set -o vi #allows vi inside bash
bind 'set completion-ignore-case on'
# shopt -s cd spell
# complete -d cd

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=
HISTFILESIZE=

shopt -s histappend # append to the history file after each command
shopt -s checkwinsize # check the window size after each command and, if necessary, update

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


# set terminal line start
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]Ruben \[\033[00m\]:\[\033[94m\]\w\[\033[93m\]\$(parse_git_branch)\[\033[00m\]\$ "
#export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]Bash🍏\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Allow aliases from .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


HISTTIMEFORMAT="%F %T "

# set directory color
alias ls='ls --color'
LS_COLORS='di=32:fi=0:ln=94:pi=33:so=33:bd=33:cd=33:or=31:mi=31:ex=33:*.rpm=90'
export LS_COLORS
export EDITOR=vim
export VISUAL=vim


if command -v tmux >/dev/null 2>&1; then
# if not inside a tmux session, and if no session is started, start a new session
	[ -z "${TMUX}" ] && (tmux attach >/dev/null 2>&1 || tmux)
fi


source "$HOME/.cargo/env"

#exa installation : select configure installation in the terminal then don't allow path edition
# https://ourcodeworld.com/articles/read/832/how-to-install-and-use-exa-a-modern-replacement-for-the-ls-command-in-ubuntu-16-04
