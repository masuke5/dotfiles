if &compatible
  set nocompatible
endif

function! s:auto_mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
  \    input(printf('"%s" does not exist. Create? [y/N] ', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set ambiwidth=double
scriptencoding utf-8

" File
set autoread
set fileformats=unix,dos

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
set pumheight=10
set noshowmode
set number
set laststatus=2
set splitbelow
set shortmess+=c
set cmdheight=1
set completeopt=menu,preview
set shortmess+=c
if !has('nvim')
  set ballooneval
else
  set inccommand=split
endif

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
  autocmd FileType ketos call s:set_tabwidth(2)
  autocmd FileType jinja call s:set_tabwidth(2)
augroup END

" filetype を設定する
augroup ExtensionFileType
  autocmd!
  autocmd BufNewFile,BufRead *.ejs set ft=html
  autocmd BufNewFile,BufRead *.ket set ft=ketos
  autocmd BufNewFile,BufRead *.html.tera set ft=jinja.html
augroup END

augroup Terminal
  autocmd!

  " ターミナルを開いたら行番号を隠す
  function! s:hide_linenumber_if_terminal()
    if &buftype == 'terminal'
      set nonumber
    else
      set number
    endif
  endfunction
  autocmd BufEnter * call timer_start(0, { -> s:hide_linenumber_if_terminal() })
  " ファイル書き込み時にディレクトリを作成する
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END

" Leader
noremap <leader> <nop>
noremap <LocalLeader> <nop>
let g:mapleader = "\<Space>"
let g:mamplocalleader = '\'

" Shortcut
" 現在行の Vim script を実行する
nnoremap <leader>ve :exec getline('.')<CR>
" 現在のタブでPowershellを実行する
nnoremap <leader>t :terminal ++close ++curwin pwsh<CR>
nnoremap <leader><Tab> ddO
" すべてのポップアップウィンドウを消す
nnoremap <silent> <leader>q :call popup_clear()<CR>
nnoremap <silent> <leader>p "+p

" Alias
command! Uv source ~/.vimrc
command! Ov e ~/.vimrc
" カーソル上のハイライトグループを表示する
command! Hg echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')

" Syntax
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

" tabline
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
  let sep = ''
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'

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

" Plugin
if has('nvim') && has('win32')
  let s:vim_plug_path = $LOCALAPPDATA . '/nvim/autoload/plug.vim'
elseif has('nvim') && has('unix')
  let s:vim_plug_path = '~/.local/share/nvim/site/autoload/plug.vim'
elseif has('win32')
  let s:vim_plug_path = $USERPROFILE . '\vimfiles\autoload\plug.vim'
elseif has('unix')
  let s:vim_plug_path = '~/.vim/autoload/plug.vim'
endif

if empty(glob(s:vim_plug_path))
  echoerr 'vim-plug をインストールしていません'
else
  call plug#begin('~/.vim/plugged')

  Plug 'airblade/vim-gitgutter'
  Plug 'fatih/vim-go'
  Plug 'tpope/vim-surround'
  Plug 'mattn/emmet-vim'
  Plug 'scrooloose/nerdtree'
  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-gitbranch'
  Plug 'scrooloose/nerdcommenter'
  Plug 'junegunn/goyo.vim'
  Plug 'kshenoy/vim-signature'
  Plug 'vim-scripts/taglist.vim'
  Plug 't9md/vim-quickhl'
  Plug 'nicwest/vim-http'

  " Syntax highlight
  Plug 'octol/vim-cpp-enhanced-highlight'
  Plug 'ElmCast/elm-vim'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'digitaltoad/vim-pug'
  Plug 'leafgarland/typescript-vim'
  Plug 'pangloss/vim-javascript'
  Plug 'posva/vim-vue'
  Plug 'PProvost/vim-ps1'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'Glench/Vim-Jinja2-Syntax'

  " Colorscheme
  Plug 'masuke5/masuc'
  Plug 'romainl/Apprentice'
  Plug 'jacoborus/tender.vim'
  Plug 'Haron-Prime/Antares'
  Plug 'tomasr/molokai'
  Plug 'w0ng/vim-hybrid'
  Plug 'morhetz/gruvbox'
  Plug 'JaySandhu/xcode-vim'
  Plug 'nelstrom/vim-mac-classic-theme'
  Plug 'endel/vim-github-colorscheme'
  Plug 'fabi1cazenave/kalahari.vim'
  Plug 'thinkpixellab/flatland'
  Plug 'joshdick/onedark.vim'
  Plug 'mrkn/mrkn256.vim'
  Plug 'jonathanfilip/vim-lucius'

  if has('win32')
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
  else
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
  endif

  call plug#end()
endif

" Python3 executable
if has('win32')
  let g:python3_host_prog = $USERPROFILE . '/Anaconda3/python.exe'
else
  let g:python3_host_prog = '/usr/bin/python3'
endif

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" C++ highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1

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
  \ 'colorscheme': 'powerline',
  \ 'active': {
  \   'left': [['mode', 'paste'],
  \            ['gitbranch', 'cocstatus', 'readonly', 'filename', 'modified']],
  \   'right': [['lineinfo'],
  \             ['percent'],
  \             ['charvaluehex', 'fileformat', 'fileencoding', 'filetype']]
  \ },
  \ 'component': {
  \   'charvaluehex': '0x%B'
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'gitbranch': 'gitbranch#name'
  \ },
  \ 'enable': {
  \   'statusline': 1,
  \   'tabline': 0
  \ }
  \ }

" tsuquyomi
let g:tsuquyomi_completion_detail = 1

" coc.nvim
augroup Coc
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

nmap <F2> <Plug>(coc-rename)
nmap <slient> <leader>n <Plug>(coc-diagnostic-prev)
nmap <slient> <leader>p <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>ad :<C-u>CocList diagnostics<CR>
nnoremap <silent> <space>ac  :<C-u>CocList commands<cr>
nnoremap <silent> <space>ao  :<C-u>CocList outline<cr>
nnoremap <silent> <space>as  :<C-u>CocList -I symbols<cr>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" NERDCommenter
let g:NERDSpaceDelims = 1

" quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

" Colorscheme
"let g:molokai_original = 1

let s:colorscheme_file = '~/.vim-colorscheme'
if !empty(glob(s:colorscheme_file))
  let s:colorscheme = readfile(expand(s:colorscheme_file))
  if !exists('g:colors_name') || g:colors_name == 'default'
    execute 'colorscheme' s:colorscheme[0]
    let &bg = s:colorscheme[1]
  endif
endif
set ambiwidth=single

" Enable syntax highlight
syntax on

" 下線を無効にする
highlight TabLine term=NONE gui=NONE
" 太字を無効にする
highlight TabLineSel term=NONE gui=NONE


