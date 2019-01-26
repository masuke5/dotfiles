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
set browsedir=buffer
set directory=$HOME/.vim/backup
set history=1000
set undodir=$HOME/.vim/undofile
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
set belloff=all
set autoindent
set backspace=indent,eol,start

" View
set pumheight=10
set noshowmode
set number
set laststatus=2
set splitbelow
if !has('nvim')
  set ballooneval
endif
set noshowmode  " echodoc.vim

" Indent
set breakindent

function! s:set_tabwidth(width) abort
  let &tabstop = a:width
  let &shiftwidth = a:width
  let &softtabstop = a:width
endfunction

" デフォルトのタブ幅
call s:set_tabwidth(4)

" ファイルの種類に応じてタブ幅を変える
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
  autocmd FileType html call s:set_tabwidth(2)
  autocmd FileType pug call s:set_tabwidth(2)
augroup END

augroup ExtensionFileType
  autocmd!
  autocmd BufNewFile,BufRead *.ejs set ft=html
augroup END

" Leader
noremap <leader> <nop>
noremap <LocalLeader> <nop>
let g:mapleader = "\<Space>"
let g:mamplocalleader = '\'

" Shortcut
" クリップボードにヤンクする
nnoremap <leader>y "+y  
vnoremap <leader>y "+y
" クリップボードから貼り付ける
nnoremap <leader>p "+p 
" 現在行の Vim script を実行する
nnoremap <leader>ve :exec getline('.')<CR>
nnoremap <leader>t :terminal ++close ++curwin pwsh<CR>

" Alias
command! Uv source ~/.vimrc
command! Ov e ~/.vimrc
" カーソル上のハイライトグループを表示する
command! Hg echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')

" Syntax
syntax on
" Enable doxygen syntax highlight
let g:load_doxygen_syntax = 1

" JSON のフォーマット (jq)
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

Plug 'masuke5/masuc'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'

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
Plug 'Shougo/denite.nvim'
Plug 'digitaltoad/vim-pug'
Plug 'PProvost/vim-ps1'
Plug 'Shougo/echodoc.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'scrooloose/nerdtree'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'

call plug#end()

set completeopt-=preview

" Python3 executable
if has('win32')
  let g:python3_host_prog = $USERPROFILE . '/Anaconda3/python.exe'
else
  let g:python3_host_prog = '/usr/bin/python3'
endif

" ALE
let g:ale_linters = {
  \ 'c': [],
  \ 'cpp': [],
  \ 'go': ['gometalinter'],
  \ 'javascript': ['eslint', 'flow'],
  \ 'typescript': ['tsserver', 'tslint'],
  \ 'python': ['flake8'],
  \ 'rust': ['cargo'],
  \ 'vue': ['tslint'],
  \ 'html': [],
\ }

" Java で日本語のエラーメッセージを文字化けしないようにする
let g:ale_java_javac_options = "-Xlint -J-Dfile.encoding=UTF8"

let g:ale_go_gometalinter_options = '--fast'

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('LanguageClient', 'input_pattern', '\S+$')
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
    \ 'go': ['go-langserver'],
    \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    \ 'rust': ['C:/Users/Shinsuke/.cargo/bin/rls.exe'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = 'C:/Users/Shinsuke/AppData/Local/nvim/settings.json'
"let g:LanguageClient_diagnosticsEnable = 0
"set completefunc=LanguageClient#complete
"set formatexpr=LanguageClient_textDocument_rangeFormatting()

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

" Denite
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])

nnoremap <silent> <C-m> :<C-u>Denite file_rec<CR>

" echodoc
let g:echodoc_enable_at_startup = 1

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" C++ highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1

colorscheme koehler
