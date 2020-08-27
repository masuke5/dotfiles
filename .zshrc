# プラグイン

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light tj/git-extras

# fzf
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# エイリアス
alias ls='ls --color=auto'
alias la='ls --color=auto -a'
alias ll='ls --color=auto -al'
alias dco='docker-compose'
alias clip='xclip -selection clipboard'
alias rmswp='rm ~/.vim/backup/*.swp'
alias tmuxcolors='for i in {0..255}; do  printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done'

autoload -Uz colors
colors

autoload -Uz compinit
compinit

autoload -Uz edit-command-line

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history
setopt inc_append_history
setopt hist_no_store
setopt pushd_ignore_dups
setopt auto_menu

PROMPT="%{$fg[yellow]%}%* %{$fg[cyan]%}%~%{$fg[white]%}$ %{$reset_color%}"

# shortcut

bindkey -e

# BashのC-x C-e
zle -N edit-command-line
bindkey "^X^E" edit-command-line

bindkey "^O" autosuggest-accept

# RUST_BACKTRACE=1を付けたり消したり
toggleRustBacktrace() {
    text="RUST_BACKTRACE=1 "
    case $BUFFER in
        "$text"*) BUFFER=`echo "$BUFFER" | sed -e s/^$text//`;;
        *) BUFFER="$text$BUFFER";;
    esac
}

zle -N toggleRustBacktrace
bindkey '^T' toggleRustBacktrace

# go get
gobin() {
    if [[ "$1" =~ ".+/.+" ]]; then
        curl -sf "https://gobinaries.com/$1" | sh
    else
        echo "usage: gobin author/name"
    fi
}

# 環境変数
export EDITOR=vim
export GOPATH=$HOME/dev/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --no-ignore-vcs --ignore-file $HOME/.fdignore"

# OPAM configuration
. /home/shinsuke/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
