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
endfunction

autocmd! Colorscheme * call s:highlight()

set t_Co=256
let g:molokai_original = 1

colorscheme badwolf 
set background=dark

" Change cursor shape
" set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:block-CursorInsert/lCursor,r-cr:hor20-Cursor/lCursor,sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
