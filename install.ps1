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

Dotfile ~\.bash_profile             .bash_profile
Dotfile ~\.bashrc                   .bashrc
Dotfile ~\.gitconfig                .gitconfig
Dotfile ~\.gvimrc                   .gvimrc
Dotfile ~\.vimrc                    .vimrc
Dotfile ~\.vrapperrc                .vrapperrc
Dotfile ~\_vsvimrc                  _vsvimrc
Dotfile ~\.vim\rc\dein.toml         dein.toml
Dotfile ~\.vim\rc\dein_nvim.toml    dein_nvim.toml
Dotfile ~\.vim\rc\dein_lazy.toml    dein_lazy.toml
Dotfile ~\.vim\ginit.vim            ginit.vim
Dotfile $profile                    profile.ps1
