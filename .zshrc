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
alias clip='xclip -selection clipboard'
alias rmswp='rm ~/.vim/backup/*.swp'

function ytmp3() {
    youtube-dl "$1" -x --audio-format mp3 --audio-quality 128k
}

function tw() {
    youtube-dl "$1" -o '%(uploader_id)s-%(id)s.%(ext)s' -x --audio-format mp3 --audio-quality 256k -k
}

function downblob() {
 ffmpeg -user_agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" -i "$1" -movflags faststart -c copy -bsf:a aac_adtstoasc "$2"
}

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

# C-x C-e
zle -N edit-command-line
bindkey "^X^E" edit-command-line

bindkey "^O" autosuggest-accept

# RUST_BACKTRACE=1
toggleRustBacktrace() {
    text="RUST_BACKTRACE=1 "
    case $BUFFER in
        "$text"*) BUFFER=`echo "$BUFFER" | sed -e s/^$text//`;;
        *) BUFFER="$text$BUFFER";;
    esac
}

zle -N toggleRustBacktrace
bindkey '^T' toggleRustBacktrace

dir_back() {
    cd ..
}

zle -N dir_back
bindkey '^H' dir_back

export WDEV=/mnt/c/users/shinsuke/dev
export GOROOT=$HOME/go
export GOPATH=$HOME/dev/go
export PATH=$GOROOT/bin:/usr/local/go/bin:$HOME/.local/bin:$HOME/.cargo/bin:$PATH

# OPAM configuration
. /home/shinsuke/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
