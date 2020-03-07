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
Plug 'fatih/vim-go', { 'for': 'go' }
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
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'antoinemadec/coc-fzf'

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
Plug 'whatyouhide/vim-gotham'

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

inoremap <silent><expr> <C-s> coc#refresh()

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
nmap <silent> <leader>al <Plug>(coc-codelens-action)

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
imap <C-k> <Plug>(coc-snippets-expand)
vmap <C-l> <Plug>(coc-snippets-select)

let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'

imap <C-l> <Plug>(coc-snippets-expand-jump)

" fzf.vim
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -g "!package-lock.json"  %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
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
nnoremap <leader>go :GitGutter<CR>
nnoremap <leader>gn :GitGutterNextHunk<CR>
nnoremap <leader>gp :GitGutterPrevHunk<CR>

" rust.vim
let g:rustfmt_autosave = 1
