" このファイルにはプラグインなどに依存しない設定を記述する。

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

" Windowsではpwshを使う
if has('win32')
  set shell=pwsh
endif

" Encoding
" -----------------------------

set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
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
set formatoptions=qB
set belloff=all
set autoindent
set backspace=indent,eol,start
set updatetime=300
set showmatch
set matchtime=1
set matchpairs+=<:>
set ttimeoutlen=10 " Remove ESC key lag

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
else
set inccommand=split
endif

" Indent
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
  setlocal textwidth=80
  setlocal colorcolumn=+1
endfunction


" デフォルトのタブ幅
let s:def_tabwidth = 4
let &tabstop = s:def_tabwidth
let &shiftwidth = s:def_tabwidth
let &softtabstop = s:def_tabwidth

" ファイルの種類ごとの設定
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

" ディレクトリを作成する
augroup Terminal
  autocmd!
  
  " 現在のバッファがターミナルだったら行番号を隠す
  function! s:hide_linenumber_if_terminal()
    if &buftype == 'terminal'
      set nonumber
    else
      set nonumber
    endif
  endfunction

  " FIXME: これを追加すると起動時にVimのタイトルが表示されない
  " autocmd BufEnter * call timer_start(0, { -> s:hide_linenumber_if_terminal() })

  " ファイル書き込み時にディレクトリを作成する
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END

" Leader
" -------------------------------------

noremap <leader> <nop>
noremap <LocalLeader> <nop>
let g:mapleader = "\<Space>"
let g:mamplocalleader = '\'

" Shortcuts
" --------------------------------------

function! Toggle_file()
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

" 現在行の Vim script を実行する
nnoremap <leader>ve :exec getline('.')<CR>
nnoremap <leader><Tab> ddO
" すべてのポップアップウィンドウを消す
nnoremap <silent> <leader>q :call popup_clear()<CR>
nnoremap <silent> <leader>p "+p
inoremap <C-@> <ESC>
" 同じディレクトリの同じファイル名のヘッダファイルかソースファイルを開く
nnoremap <silent> <leader>f :call Toggle_file()<CR>
" タブ関連
nnoremap <leader>t :tabnew<CR>
nnoremap U @

" Aliases
" --------------------------------

" vimrcを再読込
command! Uv source ~/.vimrc
command! Ov e ~/.vimrc
" カーソル上のハイライトグループを表示する
command! Hg echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
" ANSI color codeを除去
command! DeleteAnsi %s/\[[0-9;]*m//g

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
  " Disable underline in tabline
  highlight TabLine term=NONE gui=NONE
  " Disable bold in tabline
  highlight TabLineSel term=NONE gui=NONE
endfunction
autocmd! ColorScheme * call s:highlight()
