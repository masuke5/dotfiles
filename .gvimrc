if has('win32')
  set guifont=Menlo:h10
else
  set guifont=Menlo\ 10
endif
"set guifontwide=Takaoゴシック:h11
" Use DirectWrite
set renderoptions=type:directx,renmode:5
"set linespace=-4

command! Ogv :e ~/.gvimrc
command! Ugv :source ~/.gvimrc

colorscheme dracula
