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

" vim-lspのハイライト
function s:fix_vim_lsp_highlight() abort
  " エラー、警告を波線にする
  highlight SWarning cterm=undercurl guisp=Yellow gui=undercurl
  highlight SError cterm=undercurl guisp=Red gui=undercurl
  highlight link LspErrorHighlight SError
  highlight link LspErrorText SError
  highlight clear LspErrorLine
  highlight link LspWarningHighlight SWarning
  highlight link LspWarningText SWarning
  highlight clear LspWarningLine
endfunction

function! s:on_highlight()
  call s:set_lightline_colorscheme_by_background()
  " call s:make_transparent()
  call s:set_cursor_color_on_insert()
  " call s:dim_inactive_window()
  call s:fix_vim_lsp_highlight()
endfunction

autocmd! Colorscheme * call s:on_highlight()

" マウスを使う
set mouse=a
set ttymouse=xterm2

" カラースキーム
" -----------------------------------------

" それぞれのカラースキームの設定
let g:molokai_original = 1

" 256色
set termguicolors

" tatebou cursor
" let &t_SI .= "\e[6 q"
" let &t_EI .= "\e[2 q"
" let &t_SR .= "\e[4 q"

" 波線
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

" デフォルトのカラースキーム
if !exists('g:colors_name')
  " 設定更新時は変えない
  set background=dark
  colorscheme ayu
endif

" カーソルの形状を同じにする
if has('nvim')
  set guicursor=
endif
