#!/bin/bash

user="$(whoami)"
if [ "$user" = "root" ]; then
  echo 'rootユーザーでは実行しないでください'
  exit 1
fi

cwd=`dirname "${0}"`
expr "${0}" : "/.*" > /dev/null || cwd=`(cd "${cwd}" && pwd)`

if [ "$1" = "--force" ] || [ "$1" = "-f" ]; then
  force=true
else
  force=false
fi

function link() {
  if [ -z "$2" ]; then
    to=$HOME/$1
  else
    to=$2
  fi

  from=${cwd}/$1

  if [ -e $to ]; then
    if $force; then
      rm $to
      ln -s $from $to
      echo "$toを置き換えました"
    else
      echo "$toは既に存在します"
    fi
  else
    ln -s $from $to
    echo "$toにシンボリックリンクを作成しました"
  fi
}

function default() {
  if [ -z "$2" ]; then
    to=$HOME/$1
  else
    to=$2
  fi

  from=${cwd}/$1

  if [ -e $to ]; then
    echo "$toは既に存在します"
  else
    cp $from $to
    echo "$fromをコピーしました"
  fi
}

function rootlink() {
    link .vimrc.root $HOME/.vimrc
    link vim-config
}

# Vim
mkdir -p ~/.vim
link .vimrc
link .gvimrc
link vim-config
link coc-settings.json $HOME/.vim/coc-settings.json
link snippets $HOME/.vim/UltiSnips

# NeoVim
mkdir -p ~/.config/nvim
link ginit.vim ~/.config/nvim/ginit.vim
link .vimrc ~/.config/nvim/init.vim
link coc-settings.json $HOME/.config/nvim/coc-settings.json
link snippets $HOME/.config/nvim/UltiSnips

# Other
link .gitconfig
link .gitconfig.linux ~/.gitconfig.os
link .zshrc
link cheat ~/.config/cheat
link .Xresources
link .tmux.conf

linkfunc=$(declare -f link)
rootlinkfunc=$(declare -f rootlink)
sudo bash -c "cwd=$cwd; $linkfunc; $rootlinkfunc; rootlink"
