" 外観に関する設定

" lightlineのカラースキームを設定する
function! s:set_lightline_colorscheme(name) abort
  let g:lightline.colorscheme = a:name
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" backgroundの値に応じてlightlineのカラースキームを変える
function! s:set_lightline_colorscheme_by_background() abort
  if &background ==# 'dark'
    call s:set_lightline_colorscheme('wombat')
  else
    call s:set_lightline_colorscheme('PaperColor_light')
  endif
endfunction

" アクティブでないウィンドウの明かりを消す
function! s:dim_inactive_window() abort
  autocmd ColorScheme * highlight NormalNC guifg=#a0a0a0 guibg=#121212
  autocmd WinEnter,BufWinEnter * setlocal wincolor=
  autocmd WinLeave * setlocal wincolor=NormalNC
endfunction

" 背景を透過する
function s:make_transparent() abort
  if &background ==# 'dark'
    highlight Normal ctermbg=NONE guibg=NONE
    highlight Todo ctermbg=NONE guibg=NONE
    highlight NonText ctermbg=NONE guibg=NONE
    highlight EndOfBuffer ctermbg=NONE guibg=NONE
    highlight Folded ctermbg=NONE guibg=NONE
    highlight LineNr ctermbg=NONE guibg=NONE
    highlight CursorLineNr ctermbg=NONE guibg=NONE
    highlight SpecialKey ctermbg=NONE guibg=NONE
    highlight ALEErrorSign ctermbg=NONE guibg=NONE
    highlight ALEWarningSign ctermbg=NONE guibg=NONE
    highlight GitGutterAdd ctermbg=NONE guibg=NONE
    highlight GitGutterChange ctermbg=NONE guibg=NONE
    highlight GitGutterChangeDelete ctermbg=NONE guibg=NONE
    highlight GitGutterDelete ctermbg=NONE guibg=NONE
  endif
endfunction

" インサートモード時にカーソルの色を変える（GVimのみ動作）
function s:set_cursor_color_on_insert() abort
  if has('gui')
    hi CursorInsert ctermfg=lightgreen ctermbg=lightgreen
  endif
endfunction

function! s:on_highlight()
  call s:set_lightline_colorscheme_by_background()
  " call s:make_transparent()
  call s:set_cursor_color_on_insert()
  " call s:dim_inactive_window()
endfunction

autocmd! Colorscheme * call s:on_highlight()

" カラースキーム
" -----------------------------------------

" それぞれのカラースキームの設定
let g:molokai_original = 1

" デフォルトのカラースキーム
if !exists('g:colors_name')
  " 設定更新時は変えない
  colorscheme PaperColor
  set background=dark
endif

" カーソルの形状を同じにする
if has('nvim')
  set guicursor=
endif
