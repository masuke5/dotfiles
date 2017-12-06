gui

set guioptions-=T " ツールバーを非表示
set guioptions-=L " 左のスクロールバーを非表示
set guioptions-=l
"set guioptions-=R " 右のスクロールバーを非表示
"set guioptions-=r
set guioptions-=m " メニューバーを非表示

"ウィンドウサイズ設定
set lines=50
set columns=116

"set transparency=250

"set guifont=Terminus:h11
"set guifontwide=Cica:h11
set guifont=InputMono:h10
set guifontwide=Ricty_Diminished:h11

set undodir=C:/Users/SHINSUKE/undofile
colo lucius
set bg=dark

let g:airline_theme = 'kolor'

hi Pmenu ctermbg=8 guibg=#606060
hi PmenuSel ctermbg=1 guifg=#dddd00 guibg=#1f82cd
hi PmenuSbar ctermbg=0 guifg=#d6d6d6
hi PmenuThumb guifg=#3cac3c

hi Comment guifg=#ffbe00

command! Ogv e ~/.gvimrc
command! Ugv source ~/.gvimrc
