if has('win32')
  set guifont=Menlo:h10
  set guifontwide=Myrica_M:h11
  set renderoptions=type:directx,renmode:0
else
  set guifont=Menlo\ 10
endif
"set guifontwide=Takaoゴシック:h11
" Use DirectWrite
"set linespace=-4

command! Ogv :e ~/.gvimrc
command! Ugv :source ~/.gvimrc

colorscheme dracula
