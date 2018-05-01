set secure

if $VIM_CYGWIN
  set shell=cmd
  set shellcmdflag=/c
endif

" Encode
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
set ambiwidth=double

" File
set autoread

" Backup
set backupdir=$HOME/.vim/backup
set browsedir=buffer
set directory=$HOME/.vim/backup,/c/temp
set history=1000
set backup

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

set undodir=C:/Users/SHINSUKE/undofile

" Input
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set mouse=a
set textwidth=0
set formatoptions=q
set belloff=all

" View
set laststatus=2
set splitbelow
if !has('nvim')
  set ballooneval
endif

" Indent
set breakindent
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.jezcon setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType nim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType toml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" ShortcutKey
inoremap <esc> <esc>:set iminsert=0<Cr>
nnoremap <C-s> :cd %:h<CR>
nnoremap <C-j> "*y
vnoremap <C-j> "*y
nnoremap <silent> <C-p> "*p

" Fazim
" inoremap <silent> <C-m> <esc>a<C-r>=strftime("%Y%m%d%H%M%S")<Cr><space>--<space>
" inoremap <C-i> <space>::<space>

" leader
noremap <leader> <nop>
noremap <LocalLeader> <nop>
let g:mapleader = "\<Space>"
let g:mamplocalleader = '\'

" Brackets completion
"inoremap { {}<Left>
"inoremap " ""<Left>
"inoremap ' ''<Left>

" Alias
command! Mp cd ~/Programming/Projects
command! Mpd cd ~/Documents/Projects
command! Nt NERDTree
command! Uv source ~/.vimrc
command! Ov e ~/.vimrc
command! DeinToml e ~/.vim/rc/dein.toml
command! DeinLazyToml e ~/.vim/rc/dein_lazy.toml
command! Gd GoDef
command! Now <esc>a<C-r>=strftime("%Y-%m-%dT%H:%M:%S+09:00")<CR><ESC>

command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')

" Syntax
syntax on
set autoindent
set backspace=indent,eol,start
set number

if !has("gui_running")
  hi CursorLine ctermbg=darkblue
  augroup Terminal
    autocmd!
    autocmd InsertEnter * set cul
    autocmd InsertLeave * set nocul
  augroup END
endif

" Auto close html/xml tags
" augroup AutoCloseHtmlXMLTags
"   autocmd!
"   autocmd Filetype xml        inoremap <buffer> </ </<C-x><C-o>
"   autocmd Filetype html       inoremap <buffer> </ </<C-x><C-o>
"   autocmd Filetype eruby      inoremap <buffer> </ </<C-x><C-o>
" augroup END

" Japanese Documents
set runtimepath+=~/.vim/doc-ja

" git
autocmd FileType gitcommit let s:call_git = 1

if exists('s:call_git')
  exit
endif

" Remove end spaces
"autocmd! BufWritePre * :%s/\s\+$//ge "末尾の空白を削除

" Set filetype
augroup fileType
  autocmd!
  autocmd BufRead,BufNewFile *.ogassay set ft=ogassay
augroup END

" Run script
augroup RunScript
  autocmd!

  nnoremap <C-e> :!build %<CR>
  autocmd FileType ruby nnoremap <C-e> :!ruby %<CR>
  autocmd FileType python nnoremap <C-e> :!python %<CR>
  autocmd FileType perl nnoremap <C-e> :!perl %<CR>
  autocmd FileType go nnoremap <C-e> :!go run main.go<CR>
  autocmd FileType scheme nnoremap <C-e> :!gosh %<CR>
  autocmd FileType rust nnoremap <C-e> :!cargo run<CR>
  autocmd FileType vim nnoremap <C-e> :source %<CR>
  autocmd FileType lisp nnoremap <C-e> :!sbcl --script %<CR>
augroup END

" Format JSON
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction

filetype plugin on

if &compatible
  set nocompatible
endif

if !$VIM_TERM_CYGWIN
  " {{{ dein
  let s:dein_dir = expand('~/.vim/dein')
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
  endif

  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let g:rc_dir = expand('~/.vim/rc')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    if has('nvim') 
      call dein#load_toml(g:rc_dir . '/dein_nvim.toml', {'lazy': 0})
    endif

    call dein#end()
    call dein#save_state()
  endif

  filetype plugin indent on
  syntax enable

  if dein#check_install()
    call dein#install()
  endif

  " }}}
endif

" dein.toml/dein_lazy.toml highlighting
augroup MyVimrc
  autocmd!
augroup END

autocmd MyVimrc BufNewFile,BufRead dein*.toml call s:syntax_range_dein()

function! s:syntax_range_dein() abort
  let start = '^\s*hook_\%('.
  \           'add\|source\|post_source\|post_update'.
  \           '\)\s*=\s*%s'

  call SyntaxRange#Include(printf(start, "'''"), "'''", 'vim', '')
  call SyntaxRange#Include(printf(start, '"""'), '"""', 'vim', '')
endfunction

" Reload
" <F10> で編集中の Vim script をソース
if !exists('*s:source_script')
  " ~/.vimrc をソースすると関数実行中に関数の上書きを行うことになりエラーとなるため
  " 'function!' による強制上書きではなく if によるガードを行っている
  function s:source_script(path) abort
    let path = expand(a:path)
    if !filereadable(path)
      return
    endif
    execute 'source' fnameescape(path)
    echomsg printf(
          \ '"%s" has sourced (%s)',
          \ simplify(fnamemodify(path, ':~:.')),
          \ strftime('%c'),
          \)
  endfunction
endif
nnoremap <silent> <F10> :<C-u>call <SID>source_script('%')<CR>

" Python dll
if !has('nvim')
  set pythondll=C:/Windows/System32/python27.dll
  set pythonthreedll=C:/Python35/python35.dll
endif

" TypeScript
syntax match tsReference /\/\/\/\s*\<reference\s*path\=.*\s*\/\>/
highlight link tsReference Label

set hidden
  let g:lightline = {
    \ 'tabline': {
      \   'left': [ [ 'bufferinfo' ],
      \             [ 'separator' ],
      \             [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
      \   'right': [ [ 'close' ], ],
      \ },
    \ 'component_expand': {
      \   'buffercurrent': 'lightline#buffer#buffercurrent',
      \   'bufferbefore': 'lightline#buffer#bufferbefore',
      \   'bufferafter': 'lightline#buffer#bufferafter',
      \ },
    \ 'component_type': {
      \   'buffercurrent': 'tabsel',
      \   'bufferbefore': 'raw',
      \   'bufferafter': 'raw',
      \ },
    \ 'component_function': {
      \   'bufferinfo': 'lightline#buffer#bufferinfo',
      \ },
    \ 'component': {
      \   'separator': '',
      \ },
  \ }

  " lightline-buffer function settings
  let g:lightline_buffer_show_bufnr = 1
  let g:lightline_buffer_rotate = 0
  let g:lightline_buffer_fname_mod = ':t'
  let g:lightline_buffer_excludes = ['vimfiler']

  let g:lightline_buffer_maxflen = 30
  let g:lightline_buffer_maxfextlen = 3
  let g:lightline_buffer_minflen = 16
  let g:lightline_buffer_minfextlen = 3
  let g:lightline_buffer_reservelen = 20
