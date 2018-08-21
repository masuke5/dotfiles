set secure
if &compatible
  set nocompatible
endif

" Encode
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set ambiwidth=double

" File
set autoread

" Backup
set backupdir=$HOME/.vim/backup
set browsedir=buffer
set directory=$HOME/.vim/backup,/c/temp
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
set inccommand=split

" Input
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set mouse=a
set textwidth=0
set formatoptions=q
set belloff=all

" View
set number

" Indent
set breakindent

augroup FileTypeIndent
  autocmd!
  autocmd FileType vim call s:indent(2)
  autocmd FileType yaml call s:indent(2)
  autocmd FileType json call s:indent(2)
  autocmd FileType ruby call s:indent(2)
  autocmd FileType nim call s:indent(2)
  autocmd FileType toml call s:indent(2)
augroup END

function! s:indent(num)
  let &l:tabstop = a:num
  let &l:softtabstop = a:num
  let &l:shiftwidth = a:num
endfunction

" Syntax
syntax on
set autoindent

" Key
let mapleader = "\<Space>"

" Shortcut key
command! Nsm :%s/\v^\{ url/{ "url"
command! Ov :e $LOCALAPPDATA/nvim/init.vim
command! Uv :source $LOCALAPPDATA/nvim/init.vim

" Set filetype
augroup SetFileType
  autocmd!
  autocmd BufRead,BufNewFile *.ogassay set ft=ogassay
  autocmd BufRead,BufNewFile *.tanishi set ft=tanishi
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

" Plugin
filetype plugin on
let g:python3_host_prog = 'C:\Users\Shinsuke\Anaconda3\python.exe'

" vim-plug
call plug#begin('~/AppData/Local/nvim/plugged')

Plug 'masuke5/masuc'

Plug 'w0rp/ale'
Plug 'lambdalisue/gina.vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tyru/caw.vim'
" Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'othree/yajs.vim'
Plug 'fatih/vim-go'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go'
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-surround'
Plug 'napcs/vim-mycontrast'

call plug#end()

" ALE
let g:ale_linters = {
  \ 'c': ['clang'],
  \ 'cpp': ['clang', 'cppcheck'],
  \ 'go': [],
  \ 'javascript': ['eslint', 'flow'],
  \ 'typescript': ['tsserver', 'tslint'],
  \ 'python': ['flake8'],
  \ 'rust': []
\ }

let g:ale_completion_enabled = 1
let g:ale_java_javac_options = "-Xlint -J-Dfile.encoding=UTF8"
let g:ale_rust_rls_toolchain = 'stable'

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ }

let g:LanguageClient_autoStart = 1

" Gina.vim で分割されたウィンドウで開くようにする
call gina#custom#command#option('status', '--opener', &previewheight . 'split')
call gina#custom#command#option('commit', '--opener', &previewheight . 'split')
call gina#custom#command#option('log', '--opener', &previewheight . 'split')
call gina#custom#command#option('status', '--group', 'short')
call gina#custom#command#option('commit', '--group', 'short')
call gina#custom#command#option('log', '--group', 'short')

" caw.vim
nmap <leader>c <Plug>(caw:zeropos:toggle)
xmap <leader>c <Plug>(caw:zeropos:toggle)
nmap <leader>C <Plug>(caw:zeropos:uncomment)
xmap <leader>C <Plug>(caw:zeropos:uncomment)

" Gina.vim
nnoremap <leader>ss :<C-u>Gina status -s<CR>
nnoremap <leader>gc :<C-u>Gina commit<CR>
nnoremap <leader>ga :<C-u>Gina commit --amend<CR>
nnoremap <leader>gl :<C-u>Gina log<CR>

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
