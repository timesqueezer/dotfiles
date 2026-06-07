# ~/.zshrc — modern minimal setup (Starship, no Oh My Zsh / Powerlevel10k)

[[ -z $TMUX ]] && export TERM='xterm-256color'  # inside tmux, keep its tmux-256color
export GPG_TTY=$(tty)
export LC_ALL=$LANG

# --- History ---------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY INC_APPEND_HISTORY

# --- Completion ------------------------------------------------------------
# (zsh completion is case-sensitive by default, matching your old
#  CASE_SENSITIVE="true"; add a matcher-list below if you ever want it loose.)
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi

zstyle ':completion:*' menu select

# kubectl
kubectl() {
    command kubectl "$@"
    local ret=$?
    if [[ -z $KUBECTL_COMPLETE ]]; then
        source <(command kubectl completion zsh)
        KUBECTL_COMPLETE=1
    fi
    return $ret
}

# misc

setopt AUTO_CD              # type a dir name to cd into it
setopt AUTO_PUSHD           # cd builds a dir stack...
setopt PUSHD_IGNORE_DUPS    # ...without duplicates
setopt INTERACTIVE_COMMENTS # allow # comments at the prompt
setopt GLOB_DOTS            # globs match dotfiles too
setopt NO_BEEP              # kill the bell

# --- SSH key agent ---------------------------------------------------------
# eval $(keychain --eval --quiet -Q id_rsa)

# --- Plugins (pacman: zsh-autosuggestions zsh-syntax-highlighting) ---------
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# syntax-highlighting should be sourced last among the two
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^ ' autosuggest-accept       # Ctrl+Space accepts the suggestion

bindkey '^[[1;5C' forward-word    # Ctrl+Right
bindkey '^[[1;5D' backward-word   # Ctrl+Left

bindkey '^[[H'    beginning-of-line   # Home
bindkey '^[[F'    end-of-line         # End
bindkey '^[[3~'   delete-char         # Delete
bindkey '^[[3;5~' kill-word           # Ctrl+Delete
bindkey '^H'      backward-kill-word  # Ctrl+Backspace

# --- Node version manager (lazy-loaded) ------------------------------------
# Sourcing nvm eagerly adds ~0.5s to every shell start. Instead, stub it (and
# node/npm/npx) with functions that replace themselves on first use.
# https://mijndertstuij.nl/posts/life-is-too-short-for-a-slow-terminal/
export NVM_DIR="$HOME/.nvm"
_load_nvm() {
  unfunction nvm node npm npx 2>/dev/null
  [ -s /usr/share/nvm/nvm.sh ] && \. /usr/share/nvm/nvm.sh
  [ -s /usr/share/nvm/bash_completion ] && \. /usr/share/nvm/bash_completion
}
for _cmd in nvm node npm npx; do
  eval "${_cmd}() { _load_nvm; ${_cmd} \"\$@\"; }"
done
unset _cmd

# --- Prompt ----------------------------------------------------------------
eval "$(starship init zsh)"

# --- Optional modern tools (install, then uncomment) -----------------------
# eval "$(zoxide init zsh)"            # smarter cd      (pacman -S zoxide)
# eval "$(atuin init zsh)"             # searchable history (pacman -S atuin)
# source <(fzf --zsh)                  # fuzzy finder    (pacman -S fzf)

# --- Aliases ---------------------------------------------------------------
alias ls='eza --icons=always'
alias ll='eza -l --git --icons=always'
alias la='eza -la --git --icons=always'
alias lt='eza --tree --level=2 --icons=always'

alias t='tmux new -A -s main'   # attach to (or create) the main session

alias sctl='sudo systemctl'
alias spacman='sudo pacman'
alias svim='sudo vim'
alias k='kubectl'

# git (you only had `gs`; here are a few common ones — trim to taste)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'

export PATH="$HOME/.local/bin:$PATH"
