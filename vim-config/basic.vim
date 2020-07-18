" プラグインなどに依存しない設定

if &compatible
  set nocompatible
endif

function! s:auto_mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
  \    input(printf('"%s" does not exist. Create? [y/N] ', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" Shell
" ----------------------------

" WindowsではPowershell Coreを使う
if has('win32')
  set shell=pwsh
endif

" Encoding
" -----------------------------

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set ambiwidth=single

" File
" -----------------------------

set autoread
set fileformats=unix,dos

" Backup
" -----------------------------

call s:auto_mkdir(expand('$HOME/.vim/backup'), 0)
call s:auto_mkdir(expand('$HOME/.vim/undofile'), 0)
set browsedir=buffer
set directory=$HOME/.vim/backup
set history=1000
set undodir=$HOME/.vim/undofile
set backupdir=$HOME/.vim/backup
set backup

" Search
" ------------------------------

set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

" Input
" -------------------------------

set expandtab
set textwidth=0
set belloff=all
set autoindent
set backspace=indent,eol,start
set updatetime=300
set showmatch
set matchtime=1
set matchpairs+=<:>
set ttimeoutlen=10 " ESCキーの遅延を解消

" View
" -------------------------------

set hidden
set pumheight=10
set noshowmode
set relativenumber
set laststatus=2
set splitbelow
set shortmess+=c
set cmdheight=1
set completeopt=menu
if !has('nvim')
set ballooneval
set showcmd
set foldmethod=marker
else
set inccommand=split
endif

" ファイルタイプごとの設定
" -------------------------------

set breakindent

" タブ幅を設定する
function! s:set_tabwidth(width) abort
  let &l:tabstop = a:width
  let &l:shiftwidth = a:width
  let &l:softtabstop = a:width
endfunction

function s:set_rust_options()
  setlocal textwidth=100
  setlocal colorcolumn=+1
endfunction

function s:set_ocaml_options()
  setlocal textwidth=100
  setlocal colorcolumn=+1
  call s:set_tabwidth(2)
endfunction

function s:set_python_options()
  setlocal textwidth=100
  setlocal colorcolumn=+1
endfunction

" デフォルトのタブ幅
let s:def_tabwidth = 4
let &tabstop = s:def_tabwidth
let &shiftwidth = s:def_tabwidth
let &softtabstop = s:def_tabwidth

" ファイルタイプごとの設定
augroup SettingsPerFileType
  autocmd!
  " タブ幅を2にする
  autocmd FileType vim,ruby,nim,toml,json,yaml,vue,javascript,typescript,html,pug,jinja,sml,css call s:set_tabwidth(2)

  autocmd FileType rust call s:set_rust_options()
  autocmd FileType python call s:set_python_options()
  autocmd FileType ocaml call s:set_ocaml_options()
augroup END

" 拡張子を元にfiletypeを設定する
augroup FileTypeFromExtension
  autocmd!
  autocmd BufNewFile,BufRead *.ejs set ft=html
  autocmd BufNewFile,BufRead *.html.tera set ft=jinja.html
augroup END

" 現在のバッファがターミナルだったら行番号を隠す
augroup TerminalNumber
  autocmd!

  function! s:hide_linenumber_if_terminal()
    if &buftype == 'terminal'
      set nonumber
    else
      set nonumber
    endif
  endfunction

  " FIXME: これを追加すると起動時にVimのタイトルが表示されない
  " autocmd BufEnter * call timer_start(0, { -> s:hide_linenumber_if_terminal() })
augroup END

augroup MkdirWhenWrite
  " ファイル書き込み時にディレクトリが存在しなかったら作成するかどうか聞く
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END

" Leader
" -------------------------------------

" leaderをスペースキーに設定
noremap <leader> <nop>
noremap <LocalLeader> <nop>
let g:mapleader = "\<Space>"
let g:mamplocalleader = '\'

" Shortcuts
" --------------------------------------

" C/C++のソースファイルとヘッダファイルを切り替える
function! ToggleFile()
  let l:source_exts = ['cpp', 'c', 'cxx']
  let l:header_exts = ['h', 'hpp', 'hxx']

  let l:ext = expand('%:e')
  let l:curfile = expand('%:p:r')

  " Header
  let l:index = index(l:header_exts, l:ext)
  if l:index >= 0
    for ext in l:source_exts
      let l:filename = l:curfile . '.' . ext
      if !empty(glob(l:filename))
        execute 'e ' . l:filename
        return
      endif
    endfor

    execute 'e ' . l:curfile . '.' . l:source_exts[0]
    return
  endif

  " Source
  let l:index = index(l:source_exts, l:ext)
  if l:index >= 0
    for ext in l:header_exts
      let l:filename = l:curfile . '.' . ext
      if !empty(glob(l:filename))
        execute 'e ' . l:filename
        return
      endif
    endfor

    execute 'e ' . l:curfile . '.' . l:header_exts[0]
    return
  endif
endfunction

" TODO: 
" (a|, b, c)
" (a|), (b, c), d)
" (a, '(', c) アポストロフィが識別子に使える言語もある
function! BackwardArg() abort
endfunction

function! ForwardArg() abort
endfunction

" 現在行の Vim script を実行する
nnoremap <leader>ve :exec getline('.')<CR>
" すべてのポップアップウィンドウを消す
nnoremap <silent> <leader>q :call popup_clear()<CR>
" JIS配列のときもUS配列と同じ位置でESCできるようにする
inoremap <C-@> <ESC>
" US配列では@キーが押しづらい
nnoremap U @
" C/C++のソースファイルとヘッダファイルを切り替える
nnoremap <silent> <leader>f :call ToggleFile()<CR>
" タブ関連
nnoremap <leader>t :tabnew<CR>
nnoremap <C-h> gT
nnoremap <C-l> gt
" 検索キーワードを削除（ハイライトも消える）
nnoremap <silent> <leader>n :let @/ = ''<CR>
" 前後の引数に移動する
nnoremap <silent> [ BackwardArg()
nnoremap <silent> ] ForwardArg()

" Aliases
" --------------------------------

" カーソル上のハイライトグループを表示する
command! Hg echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
" バッファ内のANSI制御文字を除去
command! DeleteAnsi %s/\[[0-9;]*m//g
" 打ち間違い
command! W w

" Syntax
" ---------------------------------

" Doxygenのハイライトを有効にする
let g:load_doxygen_syntax = 1

" jqを実行してJSONをフォーマット
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction

" tabline
" --------------------------------

function! s:tabpage_label(n)
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? ' +' : ''

  " カレントバッファのファイル名
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]
  let fname = fnamemodify(bufname(curbufnr), ':t')
  if fname == ''
    let fname = '[無名]'
  endif

  let label = a:n . ' ' . fname . mod

  return '%' . a:n . 'T' . hi . ' ' . label . ' %T%#TabLineFill#'
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let tabpages = join(titles, '') . '%#TabLineFill#%T'

  " 選択しているタブページのカレントバッファのディレクトリ
  let bufnrs = tabpagebuflist(tabpagenr())
  let curbufnr = bufnrs[tabpagewinnr(tabpagenr()) - 1]
  let dname = fnamemodify(bufname(curbufnr), ':p:h')
  let cwd = fnamemodify(dname, ":~")
  if has('win32')
    let cwd = substitute(cwd, escape($USERPROFILE, '\'), 'W~', '')
    let cwd = substitute(cwd, '\\', '/', 'g')
  endif

  let info = cwd
  return tabpages . '%=' . info
endfunction

set tabline=%!MakeTabLine()

function! s:highlight()
  " tablineの下線を無効にする
  highlight TabLine term=NONE gui=NONE
  " tablineの太字を無効にする
  highlight TabLineSel term=NONE gui=NONE
endfunction

autocmd! ColorScheme * call s:highlight()
