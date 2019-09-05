source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load --verbose

alias ls='ls --color=auto'

function gvim() {
    /mnt/c/vim/vim81/gvim.exe $* &
}

autoload -Uz colors
colors

autoload -Uz compinit
compinit

setopt histignorealldups

PROMPT="%{$fg[yellow]%}%* %{$fg[cyan]%}%~%{$fg[white]%}# %{$reset_color%}"

bindkey -e

export WDEV=/mnt/c/users/shinsuke/dev
export PATH=$HOME/.cargo/bin:$PATH
