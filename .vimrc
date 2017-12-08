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
set clipboard=unnamed
set mouse=a
set textwidth=0
set formatoptions=q

" View
set laststatus=2
set splitbelow
if !has('nvim')
  set ballooneval
endif

" Indent
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
noremap <C-j> <esc>
noremap! <C-j> <esc>
inoremap <esc> <esc>:set iminsert=0<Cr>
map <C-n> :NERDTreeToggle<CR>
vnoremap <silent> <C-p> "0p<CR>
map <C-h> <esc>:NERDTreeFocus<CR>
noremap <C-s> <esc>:set nohlsearch<CR>

" Fazim
" inoremap <silent> <C-m> <esc>a<C-r>=strftime("%Y%m%d%H%M%S")<Cr><space>--<space>
" inoremap <C-i> <space>::<space>

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

" Syntax
syntax on
set autoindent
set backspace=indent,eol,start
set number
set cursorline

" Auto close html/xml tags
augroup AutoCloseHtmlXMLTags
  autocmd!
  autocmd Filetype xml        inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html       inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby      inoremap <buffer> </ </<C-x><C-o>
augroup END

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

  autocmd FileType ruby nnoremap <C-e> :!ruby %<CR>
  autocmd FileType python nnoremap <C-e> :!python %<CR>
  autocmd FileType perl nnoremap <C-e> :!perl %<CR>
  autocmd FileType go nnoremap <C-e> :!go run %<CR>
  autocmd FileType scheme nnoremap <C-e> :!gosh %<CR>
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

" {{{ dein
filetype plugin on

if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/dein'))
  call dein#begin(expand('~/.vim/dein'))

  let g:rc_dir = expand('~/.vim/rc')
  let s:toml = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

" }}}

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

" Python dll
if !has('nvim')
  set pythondll=C:/Windows/System32/python27.dll
  set pythonthreedll=C:/Python35/python35.dll
endif

" TypeScript
syntax match tsReference /\/\/\/\s*\<reference\s*path\=.*\s*\/\>/
highlight link tsReference Label
