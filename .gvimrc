if has('win32')
  set guifont=Hack:h9
  set guifontwide=HackGen:h10
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

hi CursorInsert guifg=black guibg=lime
" set cursorline

set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:block-CursorInsert/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

command! Ogv :e ~/.gvimrc
command! Ugv :source ~/.gvimrc
