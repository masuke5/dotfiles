" このファイルにはプラグインのインストールや、それぞれのプラグインの設定を記述する。

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

if empty(glob(s:vim_plug_path))
  echoerr 'vim-plug をインストールしていません'
  finish
endif

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-sandwich'
Plug 'mattn/emmet-vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/goyo.vim'
Plug 'kshenoy/vim-signature'
Plug 'nicwest/vim-http'
Plug 'machakann/vim-swap'
Plug 'masuke5/doisa-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wakatime/vim-wakatime'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lambdalisue/fern.vim'
Plug 'kana/vim-textobj-user'
Plug 'sgur/vim-textobj-parameter'
Plug 'michaeljsmith/vim-indent-object'
Plug 'cohama/lexima.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'liuchengxu/vista.vim'
Plug 'lighttiger2505/deoplete-vim-lsp'
Plug 'ncm2/float-preview.nvim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Language
Plug 'jez/vim-better-sml', { 'for': 'sml' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'iamcco/markdown-preview.nvim', { 'for': 'markdown', 'do': { -> mkdp#util#install() } }
Plug 'godlygeek/tabular' " vim-markdownが依存
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'fatih/vim-go', { 'for': 'go' }

" Syntax highlight
" STLの型名がハイライトされるのが嫌
" Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'JulesWang/css.vim', { 'for': ['css', 'scss'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'PProvost/vim-ps1', { 'for': 'ps1' }
Plug 'justinmk/vim-syntax-extra'
Plug 'Glench/Vim-Jinja2-Syntax', { 'for': 'jinja' }
Plug 'masuke5/lang2.vim', { 'for': 'lang2' }
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'aklt/plantuml-syntax'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'Shirk/vim-gas', { 'for': 'gas' }

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
Plug 'whatyouhide/vim-gotham'
Plug 'NLKNguyen/papercolor-theme'
Plug 'fcpg/vim-orbital'
Plug 'cocopon/iceberg.vim'

call plug#end()

" Python3 executable
if has('win32')
let g:python3_host_prog = $USERPROFILE . '/Anaconda3/python.exe'
else
let g:python3_host_prog = '/usr/bin/python3'
endif

" プラグインごとの設定
" ----------------------------------

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

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

nnoremap <silent> <space>ue :UltiSnipsEdit<CR>

" fzf.vim
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
nnoremap <leader>h :History<CR>
nnoremap <leader>k :History:<CR>
nnoremap <leader>l :GFiles<CR>

" popup windowでfzfを開く
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Normal', 'border': 'sharp' } }

" gitgutter-vim

" デフォルトのキーバインドを無効にする
let g:gitgutter_map_keys = 0

nnoremap <silent> <leader>go :GitGutter<CR>
nnoremap <silent> <leader>gn :GitGutterNextHunk<CR>
nnoremap <silent> <leader>gp :GitGutterPrevHunk<CR>
nnoremap <silent> <leader>gu :GitGutterUndoHunk<CR>

" rust.vim
let g:rustfmt_autosave = 1

" easymotion
map <leader>e <Plug>(easymotion-w)
map <leader>s <Plug>(easymotion-s)

" markdown-preview
nnoremap <leader>mp :MarkdownPreview<CR>

" markdown.vim
nnoremap <leader>mt :TableFormat<CR>

" fern.vim
function s:init_fern() abort
  nmap <buffer> u <Plug>(fern-action-expand)
endfunction

augroup Fern
  autocmd!
  autocmd FileType fern call s:init_fern()
augroup END

nnoremap <leader>f :Fern . -reveal=% -drawer -toggle<CR>

" vim-vue

" 軽くするため
let g:vue_pre_processors = 'detect_on_enter'

" vim-lsp
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
     \ 'name': 'rust-analyzer',
     \ 'cmd': {server_info->['rust-analyzer']},
     \ 'whitelist': ['rust'],
     \ })
endif

let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 200
let g:lsp_virtual_text_enabled = 0
let g:lsp_semantic_enabled = 1

nnoremap <F2> :LspRename<CR>
nnoremap <silent> <leader>an :LspNextDiagnostic<CR>
nnoremap <silent> <leader>ap :LspPrevDiagnostic<CR>

nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>

nnoremap <silent> K :LspHover<CR>
nnoremap <silent> <leader>ad :LspDocumentDiagnostics<CR>
nnoremap <silent> <space>ao  :LspDocumentSymbols<cr>
nnoremap <silent> <leader>al :LspCodeLens<CR>

if !has('nvim')
  autocmd User lsp_float_opened
    \ call popup_setoptions(lsp#ui#vim#output#getpreviewwinid(),
    \              {'border': [0, 0, 0, 0],
    \               'padding': [1, 1, 1, 1]})
end

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\ 'refresh_always': v:false,
\ })

inoremap <silent><expr> <C-s> deoplete#manual_complete()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#close_popup() . "\<CR>"
endfunction

" float_preview
let g:float_preview#docked = 0
