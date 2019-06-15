Param(
    [switch]$Force)

function Dotfile($path, $value) {
    if (Test-Path $path) {
        if ($Force) {
            Remove-Item $path
            New-Item -ItemType SymbolicLink -Path $path -Value $value > $null
            Write-Warning "Replaced $path"
        } else {
            Write-Output "$path exists already"
        }
    } else {
        New-Item -ItemType SymbolicLink -Path $path -Value $value > $null
        Write-Output "Created $path"
    }
}

Dotfile $env:HOME\.gitconfig .gitconfig
Dotfile $env:HOME\.gvimrc .gvimrc
Dotfile $env:HOME\.vimrc .vimrc
Dotfile $env:LOCALAPPDATA\nvim\init.vim .vimrc
Dotfile $env:LOCALAPPDATA\nvim\ginit.vim ginit.vim
Dotfile $env:HOME\vimfiles\coc-settings.json coc-settings.json
Dotfile $profile profile.ps1
