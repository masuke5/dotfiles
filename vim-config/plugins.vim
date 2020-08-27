" プラグインの設定

" Python3 executable
if has('win32')
  " TODO:
  " let g:python3_host_prog = $USERPROFILE . '/Anaconda3/python.exe'
else
  let g:python3_host_prog = trim(system('which python3'))
endif

" vim-plugのパスを生成
if has('nvim') && has('win32')
  let s:vim_plug_path = $LOCALAPPDATA . '/nvim/autoload/plug.vim'
elseif has('nvim') && has('unix')
  let s:vim_plug_path = '~/.local/share/nvim/site/autoload/plug.vim'
elseif has('win32')
  let s:vim_plug_path = $USERPROFILE . '\vimfiles\autoload\plug.vim'
elseif has('unix')
  let s:vim_plug_path = '~/.vim/autoload/plug.vim'
endif

" vim-plugの自動インストール
if empty(glob(s:vim_plug_path))
  if !executable('curl')
    echoerr 'curlをインストールしてください'
    set noloadplugins
    finish
  endif

  execute ('!curl -fLo ' . s:vim_plug_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  autocmd VimEnter * PlugInstall --sync
endif

" プラグイン {{{

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim', { 'for': ['vue', 'html', 'jinja'] }
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/goyo.vim'
Plug 'kshenoy/vim-signature'
Plug 'machakann/vim-swap'
Plug 'masuke5/doisa-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wakatime/vim-wakatime'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-altr'

" Snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Text object
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'michaeljsmith/vim-indent-object'

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" 言語プラグイン
Plug 'jez/vim-better-sml', { 'for': 'sml' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': { -> mkdp#util#install() } }
Plug 'godlygeek/tabular' " vim-markdownが依存
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'JulesWang/css.vim', { 'for': ['css', 'scss'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'PProvost/vim-ps1', { 'for': 'ps1' }
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
Plug 'masuke5/lang2.vim', { 'for': 'lang2' }
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'aklt/plantuml-syntax', { 'for': 'plantuml' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'Shirk/vim-gas', { 'for': 'gas' }
Plug 'jackguo380/vim-lsp-cxx-highlight', { 'for': ['c', 'cpp'] }

" カラースキーム
Plug 'masuke5/masuc'
Plug 'Haron-Prime/Antares'
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'morhetz/gruvbox'
Plug 'JaySandhu/xcode-vim'
Plug 'joshdick/onedark.vim'
Plug 'jonathanfilip/vim-lucius'
Plug 'cormacrelf/vim-colors-github'
Plug 'dracula/vim'
Plug 'Rigellute/rigel'
Plug 'sainnhe/gruvbox-material'
Plug 'arcticicestudio/nord-vim'
Plug 'sjl/badwolf'
Plug 'ayu-theme/ayu-vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'fcpg/vim-orbital'
Plug 'cocopon/iceberg.vim'

call plug#end()

" }}}

" プラグインごとの設定
" ----------------------------------

" emmet-vim {{{

let g:user_emmet_settings = {
\ 'variables': {
    \ 'lang': 'ja',
\ },
\ }

" }}}

" vim-go {{{

let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" }}}

" lightline.vim {{{

let g:lightline = {
\ 'active': {
\   'left': [['mode', 'paste'],
\            ['gitbranch', 'lspstatus', 'readonly', 'filename', 'modified']],
\   'right': [['lineinfo'],
\             ['percent'],
\             ['charvaluehex', 'fileformat', 'fileencoding', 'filetype']]
\ },
\ 'component': {
\   'charvaluehex': '0x%B'
\ },
\ 'component_function': {
\   'lspstatus': 'LspStatus',
\   'gitbranch': 'gitbranch#name'
\ },
\ 'enable': {
\   'statusline': 1,
\   'tabline': 0
\ }
\ }

function LspStatus()
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:result = ''

  let l:count = l:counts['information']
  if l:count > 0
    let l:result = l:result . ' I' . l:count
  endif

  let l:count = l:counts['hint']
  if l:count > 0
    let l:result = l:result . ' H' . l:count
  endif

  let l:count = l:counts['warning']
  if l:count > 0
    let l:result = l:result . ' W' . l:count
  endif

  let l:count = l:counts['error']
  if l:count > 0
    let l:result = l:result . ' E' . l:count
  endif

  return l:result[1:]
endfunction

" }}}

" sandwich.vim {{{

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

" }}}

" python-syntax {{{

let g:python_highlight_all = 1

" }}}

" Ultisnips {{{

let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

nnoremap <silent> <space>ue :UltiSnipsEdit<CR>

" }}}

" fzf.vim {{{

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -g "!package-lock.json"  %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <leader>j :Files<CR>
nnoremap <leader>w :RG<CR>
nnoremap <leader>k :History:<CR>
nnoremap <leader>l :GFiles<CR>
inoremap <C-d> <ESC>:Snippets<CR>

nnoremap <leader>fk :History<CR>
nnoremap <leader>fh :Helptags<CR>

" popup windowでfzfを開く
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Normal', 'border': 'sharp' } }

" }}}

" gitgutter-vim {{{

" デフォルトのキーバインドを無効にする
let g:gitgutter_map_keys = 0

nnoremap <silent> <leader>go :GitGutter<CR>
nnoremap <silent> <leader>gn :GitGutterNextHunk<CR>
nnoremap <silent> <leader>gp :GitGutterPrevHunk<CR>
nnoremap <silent> <leader>gu :GitGutterUndoHunk<CR>

" }}}

" rust.vim {{{

" 保存時にrustfmtする
let g:rustfmt_autosave = 1

" }}}

" markdown-preview {{{

nnoremap <leader>mp :MarkdownPreview<CR>

" }}}

" markdown.vim {{{

nnoremap <leader>mt :TableFormat<CR>

" }}}

" vim-vue {{{

" 軽くするため
let g:vue_pre_processors = 'detect_on_enter'

" }}}

" vim-lsp {{{

let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 200
let g:lsp_virtual_text_enabled = 0
let g:lsp_semantic_enabled = 1

nnoremap <F2> :LspRename<CR>
nnoremap <silent> <leader>an :LspNextDiagnostic<CR>
nnoremap <silent> <leader>ap :LspPreviousDiagnostic<CR>

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>

nnoremap <silent> K :LspHover<CR>
nnoremap <silent> <leader>ad :LspDocumentDiagnostics<CR>
nnoremap <silent> <space>ao  :LspDocumentSymbols<cr>
nnoremap <silent> <leader>al :LspCodeLens<CR>
nnoremap <silent> <leader>af :LspDocumentFormat<CR>

if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {
      \   'highlight': { 'lsRanges' : v:true },
      \ },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

if !has('nvim')
  autocmd User lsp_float_opened
    \ call popup_setoptions(lsp#ui#vim#output#getpreviewwinid(),
    \              {'border': [0, 0, 0, 0],
    \               'padding': [1, 1, 1, 1]})
end

" }}}

" asyncomplete.vim {{{

imap <C-g> <Plug>(asyncomplete_force_refresh)

" }}}

" vim-textobj-parameter {{{

let g:vim_textobj_parameter_mapping = 'h'

" }}}

" vim-altr {{{ 

nmap <leader>h <Plug>(altr-forward)
call altr#define('include/%.hpp', 'src/%.cpp')

" }}}

" vim-prettier {{{

function! s:execute_prettier()
  if !empty(glob('.prettierrc.json'))
    PrettierAsync
  endif
endfunction

augroup PrettierAutoFormat
  autocmd BufWritePre *.ts call s:execute_prettier()
augroup END

" }}}
