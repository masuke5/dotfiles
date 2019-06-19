if has('win32')
  set guifont=Terminus:h11
  set guifontwide=Cica:h11
  "set renderoptions=type:directx,renmode:0
else
  set guifont=Menlo\ 10
endif
"set guifontwide=Takaoゴシック:h11
" Use DirectWrite
"set linespace=-1

"set guioptions-=e " テキストベースのタブページを使う
"set guioptions-=m " メニューバーを表示しない
"set guioptions-=T " ツールバーを表示しない
"set guioptions-=r " スクロールバーを表示しない
set guioptions=

command! Ogv :e ~/.gvimrc
command! Ugv :source ~/.gvimrc
