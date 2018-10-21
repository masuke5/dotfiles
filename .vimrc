" set secure

if &compatible
  set nocompatible
endif

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set ambiwidth=double

" File
set autoread
set fileformat=unix

" Backup
set backupdir=$HOME/.vim/backup
set browsedir=buffer
set directory=$HOME/.vim/backup,/c/temp
set history=1000
set undodir=$HOME/undofile
set backup

" Search
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

" Input
set expandtab
set textwidth=0
set formatoptions=q
set belloff=all  " disable all bell
set autoindent
set backspace=indent,eol,start

" View
set number
set laststatus=2  " show status bar
set splitbelow
if !has('nvim')
  set ballooneval  " Enable balloon
endif

" Indent
set breakindent

function! s:set_tabwidth(width) abort
  let &tabstop = a:width
  let &shiftwidth = a:width
  let &softtabstop = a:width
endfunction

" Default tab width
call s:set_tabwidth(4)

augroup FileTypeIndnet
  autocmd!

  autocmd FileType vim call s:set_tabwidth(2)
  autocmd FileType ruby call s:set_tabwidth(2)
  autocmd FileType nim call s:set_tabwidth(2)
  autocmd FileType toml call s:set_tabwidth(2)
  autocmd FileType json call s:set_tabwidth(2)
  autocmd FileType yaml call s:set_tabwidth(2)
  autocmd FileType vue call s:set_tabwidth(2)
  autocmd FileType javascript call s:set_tabwidth(2)
  autocmd FileType typescript call s:set_tabwidth(2)
augroup END

" Leader
noremap <leader> <nop>
noremap <LocalLeader> <nop>
let g:mapleader = "\<Space>"
let g:mamplocalleader = '\'

" Shortcut
" Yank to clipboard
nnoremap <leader>y "+y  
vnoremap <leader>y "+y
" Paste from clipboard
nnoremap <leader>p "+p 
" Execute current line
nnoremap <leader>ve :exec getline('.')<CR>

" Alias
command! Uv source ~/.vimrc
command! Ov e ~/.vimrc
" Show highlight group of text cursor position
command! Hg echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')

" Syntax
syntax on

" Set filetype
augroup Filetype
  autocmd!
  autocmd BufRead,BufNewFile *.tanishi set filetype=tanishi
augroup END

" JSON formatting (call jq)
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction

" Plugin
call plug#begin('~/.vim/plugged')

" My colorscheme
Plug 'masuke5/masuc'
" Syntax check
Plug 'w0rp/ale'
" Show git diff
Plug 'airblade/vim-gitgutter'
" Golang
Plug 'fatih/vim-go'

" Autocompletion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'zchee/deoplete-go'

Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'flazz/vim-colorschemes'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': '!powershell ./install.ps1',
    \ }

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'wakatime/vim-wakatime'

call plug#end()

" Python3 executable
let g:python3_host_prog = 'C:/Users/Shinsuke/Anaconda3/python.exe'

" ALE
let g:ale_linters = {
  \ 'c': [],
  \ 'cpp': [],
  \ 'go': [],
  \ 'javascript': ['eslint', 'flow'],
  \ 'typescript': ['tsserver', 'tslint'],
  \ 'python': ['flake8'],
  \ 'rust': [],
  \ 'vue': ['vls'],
\ }

" Japanese error message
let g:ale_java_javac_options = "-Xlint -J-Dfile.encoding=UTF8"
"let g:ale_rust_cargo_check_tests = 1


" deoplete
let g:deoplete#enable_at_startup = 1

" LanguageClient-neovim
set hidden

let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery', '--log-file=c:/temp/cq.log'],
    \ 'c': ['cquery', '--log-file=c:/temp/cq.log'],
    \ 'rust': ['C:/Users/Shinsuke/.cargo/bin/rls.exe'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = 'C:/Users/Shinsuke/AppData/Local/nvim/settings.json'
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

" Maps K to hover, gd to goto definition, F2 to rename
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" tanishi
nnoremap <leader>t o<ESC>i<C-R>=strftime("created %Y/%m/%d %H:%M")<CR><CR>

colorscheme koehler
