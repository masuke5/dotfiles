gui

set guioptions-=T " ツールバーを非表示
set guioptions-=L " 左のスクロールバーを非表示
set guioptions-=l
"set guioptions-=R " 右のスクロールバーを非表示
"set guioptions-=r
set guioptions-=m " メニューバーを非表示

set guioptions-=e

set guicursor=n-v-sm:block,ci-ve:ver25,r-cr-o:hor20,i:hor5,c:hor15

command! ThinCursor :set guicursor=n-v-sm:block,ci-ve:ver25,r-cr-o:hor20,i:ver5,c:hor15
command! MSGothic :set guifont=MS_Gothic:h12 | :set guifontwide=MS_Gothic:h12
command! DefaultFont :set guifont& | :set guifontwide&
command! Consolas :set guifont=Consolas:h11 | :set linespace=-1

"set transparency=250

"set guifont=Terminus:h11
"set guifontwide=Cica:h11
set guifont=Myrica_M:h12
set guifontwide=Migu_1M:h12
"set guifontwide=Ricty_Diminished:h11

" フォントを綺麗にする
set renderoptions=type:directx,geom:1,renmode:5

set linespace=0

set undodir=C:/Users/SHINSUKE/undofile
colo masuc
"set bg=dark

hi Pmenu ctermbg=8 guibg=#606060
hi PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
hi PmenuSbar ctermbg=0 guifg=#d6d6d6
hi PmenuThumb guifg=#3cac3c

if &background == "dark"
  hi Comment guifg=#ffbe00
else
  hi Comment guifg=#12199b
endif

"hi Cursor guibg=Green

hi javascriptAwaitFuncKeyword guifg=#ce76e5

command! Ogv e ~/.gvimrc
command! Ugv source ~/.gvimrc

let g:not_first_init = 1
