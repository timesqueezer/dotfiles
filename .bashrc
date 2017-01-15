
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias ll='ls -lha --color=auto'
alias grep='grep --color=auto'
alias pacman='pacman'
alias spacman='sudo pacman'

alias mkchr='sudo extra-i686-build && sudo multilib-build'
alias mkchr32='sudo extra-i686-build'
alias mkchr64='sudo multilib-build'
alias db-aur='ssh sigurd.archlinux.org /arch/db-update'
alias svim='sudo vim'
alias sctl='sudo systemctl'

export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
export PATH="/usr/lib/colorgcc/bin:$PATH"
export LC_TIME="de_DE.UTF-8"

complete -cf sudo
export EDITOR=vim
alias sharedir='python -m http.server'

eval $(keychain --eval --quiet -Q id_rsa)

if [[ -n "$DISPLAY" ]]; then
	BROWSER=chromium
fi
