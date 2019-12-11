Param(
    [switch]$Force)

function Dotfile($path, $value) {
    if (Test-Path $path) {
        if ($Force) {
            Remove-Item $path
            New-Item -ItemType SymbolicLink -Path $path -Value $value > $null
            Write-Warning "Replaced $path"
        } else {
            Write-Output "$path already exists"
        }
    } else {
        New-Item -ItemType SymbolicLink -Path $path -Value $value > $null
        Write-Output "Created $path"
    }
}

function Default($dest, $path) {
    if (Test-Path $dest) {
        Write-Output "$dest already exists"
    } else {
        Copy-Item -Path $path -Destination $dest
        Write-Output "Copied $path"
    }
}

Dotfile $env:HOME\.gitconfig .gitconfig
Dotfile $env:HOME\.gitconfig.os .gitconfig.win
Dotfile $env:HOME\.gvimrc .gvimrc
Dotfile $env:HOME\.vimrc .vimrc
Dotfile $env:LOCALAPPDATA\nvim\init.vim .vimrc
Dotfile $env:LOCALAPPDATA\nvim\ginit.vim ginit.vim
Dotfile $env:HOME\vimfiles\coc-settings.json coc-settings.json
Dotfile $profile profile.ps1

Default $env:HOME\.vim-preference .vim-preference
