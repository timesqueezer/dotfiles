
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias ll='ls -lha --color=auto'
alias grep='grep --color=auto'
alias pacman='pacman'
alias spacman='sudo pacman'

alias svim='sudo vim'
alias sctl='sudo systemctl'

export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
export PATH="/usr/lib/colorgcc/bin:/home/matz/dotfiles:$PATH"
export LC_TIME="de_DE.UTF-8"

complete -cf sudo
export EDITOR=vim

eval $(keychain --eval --quiet -Q id_rsa)

