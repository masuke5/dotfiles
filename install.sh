#!/bin/bash

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

link .vimrc
link .gvimrc
link .gitconfig
link ginit.vim ~/.config/nvim/ginit.vim
link .vimrc ~/.config/nvim/init.vim
