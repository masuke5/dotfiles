if has('win32')
  set guifont=Dejavu_Sans_Mono:h9
  set guifontwide=Cica:h11
  set renderoptions=type:directx,renmode:5
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

hi Cursor guifg=black guibg=cyan
"set cursorline

command! Ogv :e ~/.gvimrc
command! Ugv :source ~/.gvimrc
