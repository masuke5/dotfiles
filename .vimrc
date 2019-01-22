" set secure

if &compatible
  set nocompatible
endif

function! s:auto_mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
  \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set ambiwidth=double

" File
set autoread
set fileformat=unix

" Backup
call s:auto_mkdir(expand('$HOME/.vim/backup'), 0)
call s:auto_mkdir(expand('$HOME/.vim/undofile'), 0)
set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/backup,/tmp
set undodir=$HOME/.vim/undofile
set browsedir=buffer
set history=1000
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
set pumheight=10
set noshowmode
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
" Enable doxygen syntax highlight
let g:load_doxygen_syntax = 1

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
if has('win32')
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': '!powershell ./install.ps1',
    \ }
else
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
endif

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'cakebaker/scss-syntax.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/echodoc.vim'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'

call plug#end()

" Python3 executable
if has('win32')
  let g:python3_host_prog = expand('$HOME/../Anaconda3/python.exe')
else
  let g:python3_host_prog = '/usr/bin/python3'
endif

" ALE
let g:ale_linters = {
  \ 'c': [],
  \ 'cpp': ['cquery'],
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
call deoplete#custom#option({
  \ 'ignore_sources': {
    \ 'c': ['buffer'],
    \ 'cpp': ['buffer', 'around'],
    \ },
  \ })

" vim-lsp
"if executable('cquery')
"  au User lsp_setup call lsp#register_server({
"    \ 'name': 'cquery',
"    \ 'cmd': {server_info->['cquery']},
"    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"    \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery' },
"    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"    \ })
"endif

" LanguageClient-neovim
set hidden

let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'rust': ['C:/Users/Shinsuke/.cargo/bin/rls.exe'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
if has('win32')
  let g:LanguageClient_settingsPath = expand('$LOCALAPPDATA/nvim/settings.json');
else
  let g:LanguageClient_settingsPath = expand('$HOME/.config/nvim/settings.json')
endif
let g:LanguageClient_diagnosticsEnable = 0
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

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" C++ highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1

colorscheme koehler
