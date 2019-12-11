source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load

alias ls='ls --color=auto'
alias la='ls --color=auto -a'
alias ll='ls --color=auto -al'

function gvim() {
    /mnt/c/vim/vim81/gvim.exe $* &
}

autoload -Uz colors
colors

autoload -Uz compinit
compinit

export HISTSIZE=1000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt append_history
setopt hist_no_store
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_menu

PROMPT="%{$fg[yellow]%}%* %{$fg[cyan]%}%~%{$fg[white]%}# %{$reset_color%}"

bindkey -e

export WDEV=/mnt/c/users/shinsuke/dev
export PATH=$HOME/.cargo/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
