if has('win32')
  set guifont=Dejavu_Sans_Mono_for_Powerline:h10
  set guifontwide=更紗等幅ゴシック_J:h10
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
