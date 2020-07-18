scriptencoding utf-8

let s:basic_settings = "$HOME/vim-config/basic.vim"
let s:plugins_settings = "$HOME/vim-config/plugins.vim"
let s:preference_settings = "$HOME/vim-config/preference.vim"

execute 'source' s:basic_settings

" --nopluginが指定されたときはプラグインの設定ファイルを読み込まない
if &loadplugins
  execute 'source' s:plugins_settings
endif

if &loadplugins
  execute 'source' s:preference_settings
endif

" 設定ファイルを更新
command! Uv source $HOME/.vimrc

" 設定ファイルを開くエイリアス
command! Ov edit $HOME/.vimrc
command! Omv edit $HOME/vim-config/main.vim
command! Obv execute 'edit' s:basic_settings
command! Olv execute 'edit' s:plugins_settings
command! Opv execute 'edit' s:preference_settings

" シンタックスハイライトを有効にする。
" このコマンドはrutimepathを設定した後に実行しなければならないので
" 念の為最後に記述している。
syntax on
