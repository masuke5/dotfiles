"Encode
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8
set ambiwidth=double

"File
set autoread

augroup onSave
  autocmd!
  "autocmd BufWritePre * :%s/\s\+$//ge "末尾の空白を削除
augroup END

augroup fileType
  autocmd!
  autocmd BufRead,BufNewFile *.ogassay set ft=ogassay
augroup END

augroup RunScript
  autocmd!

  autocmd FileType ruby nnoremap <C-e> :!ruby %<CR>
  autocmd FileType python nnoremap <C-e> :!python %<CR>
  autocmd FileType perl nnoremap <C-e> :!perl %<CR>
  autocmd FileType go nnoremap <C-e> :!go run %<CR>
  autocmd FileType scheme nnoremap <C-e> :!gosh %<CR>
augroup END

command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction

"Backup
set backupdir=$HOME/.vim/backup
set browsedir=buffer
set directory=$HOME/.vim/backup,/c/temp
set history=1000

"Search
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

set undodir=C:/Users/SHINSUKE/undofile

"Input
set shiftwidth=4
set tabstop=4
set expandtab
set softtabstop=4
set clipboard=unnamed
set mouse=a
set textwidth=0
set formatoptions=q
"set iminsert=2

augroup fileTypeIndent
  autocmd!
  "autocmd BufNewFile,BufRead *.gradle setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.jezcon setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.json setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType vim setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType nim setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

"ShortcutKey
noremap <C-j> <esc>
noremap! <C-j> <esc>
"nnoremap <C-b> :Gulp<CR>
inoremap <esc> <esc>:set iminsert=0<Cr>
map <C-n> :NERDTreeToggle<CR>
vnoremap <silent> <C-p> "0p<CR>
map <C-h> <esc>:NERDTreeFocus<CR>
noremap <C-s> <esc>:set nohlsearch<CR>
" inoremap <silent> <C-m> <esc>a<C-r>=strftime("%Y%m%d%H%M%S")<Cr><space>--<space>
" inoremap <C-i> <space>::<space>

"Brackets
"inoremap { {}<Left>
"inoremap " ""<Left>
"inoremap ' ''<Left>

"Alias
command! Mp cd ~/Programming/Projects
command! Mpd cd ~/Documents/Projects
command! Nt NERDTree
command! Uv source ~/.vimrc
command! Ov e ~/.vimrc
command! DeinToml e ~/.vim/rc/dein.toml
command! DeinLazyToml e ~/.vim/rc/dein_lazy.toml
command! Gd GoDef
command! Now <esc>a<C-r>=strftime("%Y-%m-%dT%H:%M:%S+09:00")<CR><ESC>

"Syntax
syntax on
set autoindent
set backspace=indent,eol,start
set number
set cursorline
"let g:molokai_original = 1 "実際のmonokaiの色に近づける

augroup AutoCloseHtmlXMLTags
  autocmd!
  autocmd Filetype xml        inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html       inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby      inoremap <buffer> </ </<C-x><C-o>
augroup END

"let g:airline_theme = 'kolor'

"Japanese Documents
set runtimepath+=~/.vim/doc-ja

" :e時に自動ディレクトリ作成
" augroup AutoMkdir
"   au!
"   au BufNewFile * call PromptAndMakeDirectory()
" augroup END
"
" function! PromptAndMakeDirectory()
"   let dir = expand("<afile>:p:h")
"   if !isdirectory(dir) && confirm("Create a new directory [".dir."]?", "&Yes\n&No") == 1
"     call mkdir(dir, "p")
"     file %
"   endif
" endfunction

"git
autocmd FileType gitcommit let s:call_git = 1

if exists('s:call_git')
  exit
endif

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

" deoplete.nvim
let g:python3_host_prog = "C:/Python35/python.exe"
let g:deoplete#enable_at_startup = 1

"neocomplete
" set nocompatible
"
" set runtimepath+=~/.vim/dein/repos/github.com/Shougo/neocomplete.vim/
"
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_auto_select = 1
"
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
"
" if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns = {}
" endif

"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

"caw.vim
nmap <leader>c <Plug>(caw:zeropos:toggle)
xmap <leader>c <Plug>(caw:zeropos:toggle)
nmap <leader>C <Plug>(caw:zeropos:uncomment)
xmap <leader>C <Plug>(caw:zeropos:uncomment)

"vim-quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

"vim-airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
"let g:airline_powerline_fonts = 1

"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
"
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
"let g:airline_symbols.crypt = '🔒'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.maxlinenr = '☰'
"let g:airline_symbols.maxlinenr = ''
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.spell = 'Ꞩ'
"let g:airline_symbols.notexists = '∄'
"let g:airline_symbols.whitespace = 'Ξ'
"let g:airline_powerline_fonts = 1
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''

"Ruby
let g:rsenseHome = 'c:/Ruby24-x64/bin/rsense'
"let g:monster#completion#rcodetools#backend = "async_rct_complete"
"let g:neocomplete#sources#omni#input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'


"Python
set splitbelow

if !has('nvim')
  set pythondll=C:/Windows/System32/python27.dll
  set pythonthreedll=C:/Python35/python35.dll
endif

autocmd FileType python setlocal completeopt-=preview
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:syntastic_python_checkers = ['flake8']

"Rust
augroup MyVimrc
  autocmd!
augroup END

let g:rustfmt_autosave = 1

let g:deoplete#sources#rust#racer_binary='C:/Users/SHINSUKE/.cargo/bin/racer.exe'
let g:deoplete#sources#rust#rust_source_path='C:\Users\SHINSUKE\.rustup\toolchains\nightly-x86_64-pc-windows-msvc/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#show_duplicates = 1
let g:deoplete#sources#rust#disable_keymap = 1
nmap <buffer> gd <plug>DeopleteRustGoToDefinitionDefault
nmap <buffer> K  <plug>DeopleteRustShowDocumentation

let g:syntastic_rust_checkers = ['rustc']

"Auto Format
let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'

"Racer
let g:racer_cmd = expand('~/.cargo/bin/racer')

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config['syntax/rust'] = {
    \ 'command':      'rustc',
    \ 'cmdopt':       '-Zparse-only',
    \ 'exec':         '%c %o %s:p',
    \ 'outputter':    'quickfix',
\ }
autocmd MyVimrc FileType BufWritePost *.rs QuickRun -type syntax/rust

"Golang
"let g:neocomplete#sources#omni#input_patterns.go = ''

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

augroup Golang
  autocmd!
  autocmd FileType go :highlight goErr cterm=bold ctermfg=214 gui=bold guifg=#eddd33
  autocmd FileType go :match goErr /\<err\>/
  autocmd FileType go nnoremap <C-m> :GoTestFunc<CR>
augroup END

let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
let g:go_list_type = "quick_fix"

"TypeScript
let g:tsuquyomi_completion_detail = 1
let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_completion_preview = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

if !has('nvim')
  set ballooneval
endif

augroup Typescript
  autocmd!

  autocmd FileType typescript nnoremap <C-b> :Gulp<CR>
  autocmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
  autocmd FileType typescript nnoremap <C-k> :TsuSignatureHelp<CR>

augroup END

"let g:neocomplete#force_omni_input_patterns.typescript = '[^. *\t]\.\w*\|\h\w::'

syntax match tsReference /\/\/\/\s*\<reference\s*path\=.*\s*\/\>/
highlight link tsReference Label

"C/C++
let g:marching_clang_command = "C:/msys64/mingw64/bin/clang++.exe"

let g:marching#clang_command#options = {
  \ "cpp": "-std=gnu++1y"
\ }

"let g:marching_clang_command_option="-IC:/Users/SHINSUKE/Programming/Libraries/C++/oxygine-framework-with-sdl/oxygine-framework/oxygine/src"


let g:marching_include_paths = [
  \ "C:/MinGW/lib/gcc/mingw32/6.3.0/include/c++",
  \ "C:/Users/SHINSUKE/Programming/Libraries/C++/oxygine-framework-with-sdl/oxygine-framework/oxygine/src",
  \ "C:/Users/SHINSUKE/Programming/Libraries/C++/oxygine-framework-with-sdl/SDL/include"
\ ]

"let g:neocomplete#force_omni_input_patterns.cpp =
"      \ '[^.[:digit:] *\t]\%(\.\|->\))\w*\|\h\w*::\w*'

let g:marching#default_config = {
  \ "ignore_pat": '^_\D'
\ }

let g:marching_backend = "sync_clang_command"

"Markdown
let g:vim_markdown_folding_disabled = 1

"C#
let g:Omnisharp_server_type = 'roslyn'
let g:OmniSharp_host = "http://localhost:2000"

"let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:syntastic_cs_checkers = ['code_checker']

set completeopt+=longest

augroup omnisharp_commands
  autocmd!

  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

  autocmd FileType cs nnoremap <C-b> :wa!<CR>:OmniSharpBuild<CR>

  autocmd BufWritePost *.cs call OmniSharp#AddToProject()
  autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

  "The following commands are contextual, based on the current cursor position.

  autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
  autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
  autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
  autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
  autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
  "finds members in the current buffer
  autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
  " cursor can be anywhere on the line containing an issue
  autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
  autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
  autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
  autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
  "navigate up by method/property/field
  autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
augroup END

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

"let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'

command! -nargs=1 Ehe !<f-args>\bin\debug\<f-args>.exe

"CtrlP
"let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
"let g:ctrlp_clear_cache_on_exit = 0
"let g:ctrlp_lazy_update = 1
"let g:ctrlp_root_markers = ['Gemfile', 'pom.xml', 'build.xml']
"let g:ctrlp_max_height = 20
"let g:ctrlp_custom_ignore = {
"  \ 'dir':   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }

"Emmet.vim
let g:user_emmet_settings = {
\   'lang': 'ja'
\ }

"Fazima
let g:fazima#enable = 0

"incsearch.vim
"map / <Plug>(incsearch-forward)
"map ? <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)

"vim-quickrun
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner'    : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter' : 'error',
      \ 'outputter/error/success' : 'buffer',
      \ 'outputter/error/error'   : 'quickfix',
      \ 'outputter/buffer/split'  : ':rightbelow 8sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ }

"Java
let g:JavaComplete_ClasspathGenerationOrder = ['Maven', 'Eclipse', 'Gradle']

function! AJavaImports()
  :JCimportsAddMissing
  :JCimportsRemoveUnused
endfunction

augroup JavaA
  autocmd!
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
  autocmd BufWrite *.java call AJavaImports()
augroup END

let g:syntastic_java_javac_options = "-Xlint -J-Dfile.encoding=UTF8"
let g:syntastic_java_javac_delete_option = 0

"NERDTree
let NERDTreeShowHidden = 1

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
