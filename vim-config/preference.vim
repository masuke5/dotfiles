" このファイルには見た目に関する設定を記述する。

" lightlineのカラースキームを設定する
function! s:set_lightline_colorscheme(name) abort
  let g:lightline.colorscheme = a:name
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

function! s:highlight()
  " backgroundの値に応じてlightlineのカラースキームを変える
  if &background ==# 'dark'
    call s:set_lightline_colorscheme('seoul256')
  else
    call s:set_lightline_colorscheme('PaperColor_light')
  endif

  " coc.nvimのエラーの下線を波線にする
  " hi CocErrorHighlight term=undercurl
  " hi CocWarningHighlight term=undercurl

  " カーソルの色をインサートモード時に黄緑色にする
  " hi CursorInsert ctermfg=lightgreen ctermbg=lightgreen

  " 透過
  if &background ==# 'dark'
    " highlight Normal ctermbg=NONE guibg=NONE
    " highlight Todo ctermbg=NONE guibg=NONE
    " highlight NonText ctermbg=NONE guibg=NONE
    " highlight EndOfBuffer ctermbg=NONE guibg=NONE
    " highlight Folded ctermbg=NONE guibg=NONE
    " highlight LineNr ctermbg=NONE guibg=NONE
    " highlight CursorLineNr ctermbg=NONE guibg=NONE
    " highlight SpecialKey ctermbg=NONE guibg=NONE
    " highlight ALEErrorSign ctermbg=NONE guibg=NONE
    " highlight ALEWarningSign ctermbg=NONE guibg=NONE
    " highlight GitGutterAdd ctermbg=NONE guibg=NONE
    " highlight GitGutterChange ctermbg=NONE guibg=NONE
    " highlight GitGutterChangeDelete ctermbg=NONE guibg=NONE
    " highlight GitGutterDelete ctermbg=NONE guibg=NONE
  endif
endfunction

autocmd! Colorscheme * call s:highlight()

set t_Co=256
let g:molokai_original = 1

colorscheme PaperColor
set background=dark

" Change cursor shape
" set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:block-CursorInsert/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
set guicursor=
