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
set backupdir=$HOME/.vim/backup
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
set updatetime=300

" View
set hidden
set signcolumn=yes
set pumheight=10
set noshowmode
set number
set laststatus=2
set splitbelow
if !has('nvim')
  set ballooneval
endif
set noshowmode  " echodoc.vim
set shortmess+=c
set cmdheight=1

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
Plug 'ElmCast/elm-vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'romainl/Apprentice'
Plug 'jacoborus/tender.vim'
Plug 'Haron-Prime/Antares'

call plug#end()

set completeopt=menu,preview

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
  \ 'go': ['golint', 'govet'],
  \ 'html': [],
  \ 'typescript': ['tsserver', 'tslint'],
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

" Emmet
let g:user_emmet_settings = {
  \ 'variables': {
      \ 'lang': 'ja',
  \ },
\ }

" Golang syntax highlighting
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" lightline.vim
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [['mode', 'paste'],
  \            ['cocstatus', 'readonly', 'filename', 'modified']],
  \   'right': [['lineinfo'],
  \             ['percent'],
  \             ['fileformat', 'fileencoding', 'filetype']]
  \ },
  \ 'component': {
  \   'charvaluehex': '0x%B'
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ }
  \ }

" tsuquyomi
let g:tsuquyomi_completion_detail = 1

" coc.nvim
nmap <slient> <leader>n <Plug>(coc-diagnostic-prev)
nmap <slient> <leader>p <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <slient> <leader>a :<C-u>CocList diagnostics<CR>
