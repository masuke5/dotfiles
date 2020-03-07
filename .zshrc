# source ~/.zplug/init.zsh

# zplug "zsh-users/zsh-syntax-highlighting", defer:2
alias ls='ls --color=auto'
alias la='ls --color=auto -a'
alias ll='ls --color=auto -al'
alias clip='xclip -selection clipboard'
alias rmswp='rm ~/.vim/backup/*.swp'

function ytmp3() {
    youtube-dl "$1" -x --audio-format mp3 --audio-quality 128k
}

function gvim() {
    /mnt/c/vim/vim81/gvim.exe $* &
}

autoload -Uz colors
colors

autoload -Uz compinit
compinit

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt inc_append_history
setopt hist_no_store
setopt pushd_ignore_dups
setopt auto_menu
setopt no_beep

PROMPT="%{$fg[yellow]%}%* %{$fg[cyan]%}%~%{$fg[white]%}# %{$reset_color%}"

bindkey -e

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

toggleRustBacktrace() {
    text="RUST_BACKTRACE=1 "
    case $BUFFER in
        "$text"*) BUFFER=`echo "$BUFFER" | sed -e s/^$text//`;;
        *) BUFFER="$text$BUFFER";;
    esac
}

zle -N toggleRustBacktrace
bindkey '^T' toggleRustBacktrace

export WDEV=/mnt/c/users/shinsuke/dev
export GOROOT=$HOME/go
export PATH=$GOROOT/bin:/usr/local/go/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

# OPAM configuration
. /home/shinsuke/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
