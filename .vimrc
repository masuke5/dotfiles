scriptencoding utf-8

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
if has('win32')
set shell=pwsh
endif

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set ambiwidth=single

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
set showmatch
set matchtime=1
set matchpairs+=<:>
set ttimeoutlen=10 " Remove ESC key lag

" View
set hidden
set pumheight=10
set noshowmode
set relativenumber
set laststatus=2
set splitbelow
set shortmess+=c
set cmdheight=1
set completeopt=menu,preview
if !has('nvim')
set ballooneval
set showcmd
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
  autocmd BufRead,BufNewFile,BufEnter *.vim call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.ruby call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.nim call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.toml call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.json call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.yaml call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.vue call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.js call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.ts call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.html call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.pug call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.html.tera call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.sml call s:set_tabwidth(2)
  autocmd BufRead,BufNewFile,BufEnter *.css call s:set_tabwidth(2)
augroup END

" filetype を設定する
augroup ExtensionFileType
  autocmd!
  autocmd BufNewFile,BufRead *.ejs set ft=html
  autocmd BufNewFile,BufRead *.html.tera set ft=jinja.html
augroup END

augroup Terminal
  autocmd!
  
  " ターミナルを開いたら行番号を隠す
  function! s:hide_linenumber_if_terminal()
    if &buftype == 'terminal'
      set nonumber
    else
      set nonumber
    endif
  endfunction
  " FIXME: これを追加するとVimのタイトルが表示されない
  " autocmd BufEnter * call timer_start(0, { -> s:hide_linenumber_if_terminal() })
  " ファイル書き込み時にディレクトリを作成する
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
augroup END

" Leader
noremap <leader> <nop>
noremap <LocalLeader> <nop>
let g:mapleader = "\<Space>"
let g:mamplocalleader = '\'

" Shortcut
function! Toggle_file()
let l:ext = expand('%:e')
let l:curfile = expand('%:p:r')
if l:ext ==# 'h'
  execute 'e ' . l:curfile . '.cpp'
elseif l:ext ==# 'cpp'
  execute 'e ' . l:curfile . '.h'
endif
endfunction

" 現在行の Vim script を実行する
nnoremap <leader>ve :exec getline('.')<CR>
nnoremap <leader><Tab> ddO
" すべてのポップアップウィンドウを消す
nnoremap <silent> <leader>q :call popup_clear()<CR>
nnoremap <silent> <leader>p "+p
inoremap <C-@> <ESC>
" 同じディレクトリの同じファイル名のヘッダ・ソース・ファイルを開く
nnoremap <silent> <leader>g :call Toggle_file()<CR>
" fzf.vim
nnoremap <leader>j :Files<CR>
nnoremap <leader>w :RG<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>k :History:<CR>
nnoremap <leader>l :GFiles<CR>
" タブ関連
nnoremap <leader>t :tabnew<CR>
" gitgutter-vim
nnoremap <leader>go :GitGutter<CR>
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gp :GitGutterPrevHunk<CR>

" Alias
command! Uv source ~/.vimrc
command! Ov e ~/.vimrc
" カーソル上のハイライトグループを表示する
command! Hg echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
command! DeleteAnsi %s/\[[0-9;]*m//g

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
Plug 'fatih/vim-go', { 'for': 'go' }
" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/goyo.vim'
Plug 'kshenoy/vim-signature'
Plug 'vim-scripts/taglist.vim'
Plug 'nicwest/vim-http'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Shirk/vim-gas'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'machakann/vim-swap'
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'masuke5/doisa-vim'
Plug 'jez/vim-better-sml', { 'for': 'sml' }
Plug 'KabbAmine/vCoolor.vim'
Plug 'osyo-manga/vim-over'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wakatime/vim-wakatime'
Plug 'Sirver/ultisnips'
Plug 'honza/vim-snippets'

" Syntax highlight
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': 'javascript' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'PProvost/vim-ps1', { 'for': 'ps1' }
Plug 'justinmk/vim-syntax-extra'
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
Plug 'masuke5/lang2.vim', { 'for': 'lang2' }

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
Plug 'fabi1cazenave/kalahari.vim'
Plug 'thinkpixellab/flatland'
Plug 'joshdick/onedark.vim'
Plug 'mrkn/mrkn256.vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'cormacrelf/vim-colors-github'
Plug 'dracula/vim'
Plug 'vim-scripts/Wombat'
Plug 'altercation/vim-colors-solarized'
Plug 'Rigellute/rigel'
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'
Plug 'nightsense/cosmic_latte'
Plug 'nightsense/snow'
Plug 'arcticicestudio/nord-vim'
Plug 'sjl/badwolf'
Plug 'ayu-theme/ayu-vim'

if has('win32')
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
else
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
endif

" firenvim
if has('nvim')
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif

call plug#end()
endif

" Python3 executable
if has('win32')
let g:python3_host_prog = $USERPROFILE . '/Anaconda3/python.exe'
else
let g:python3_host_prog = '/usr/bin/python3'
endif

" C++ highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
" let g:cpp_experimental_template_highlight = 1

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
" dark: seoul256
" light: PaperColor_light
let g:lightline = {
\ 'colorscheme': 'seoul256',
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

" coc.nvim
augroup Coc
autocmd!
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

inoremap <silent><expr> <C-j> coc#refresh()

nmap <F2> <Plug>(coc-rename)
nmap <silent> <leader>an <Plug>(coc-diagnostic-next)
nmap <silent> <leader>ap <Plug>(coc-diagnostic-prev)

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
endfunction

" sandwich.vim
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
let g:sandwich#recipes += [
  \   {
  \     'buns': ['(*', '*)'],
  \     'input': ['l'],
  \     'filetype': ['sml', 'ocaml'],
  \     'match_syntax': 1,
  \     'nesting': 1,
  \   },
  \ ]

" python-syntax
let g:python_highlight_all = 1

" firenvim
let g:firenvim_config = {
    \ 'localSettings': {
        \ '.*': {
            \ 'selector': 'textarea, div[role="textbox"]',
            \ 'priority': 0,
        \ }
    \ }
\ }

" coc-snippets
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

let g:UltiSnipsEditSplit="vertical"

" fzf.vim
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -g "!package-lock.json"  %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Preference
source $HOME/.vim-preference

" Enable syntax highlight
syntax on

function! s:highlight()
  " Disable underline in tabline
  highlight TabLine term=NONE gui=NONE
  " Disable bold in tabline
  highlight TabLineSel term=NONE gui=NONE
endfunction
autocmd! ColorScheme * call s:highlight()
