Remove-Item alias:mp -force

function mp { cd "~\Programming\Projects" }
function mpd { cd "~\Documents\Projects" }
function vi { vim --noplugin $args }

function prompt {
    $idx = $pwd.ProviderPath.LastIndexOf("\") + 1
    $cdn = $pwd.ProviderPath.Remove(0, $idx)

    Write-Host $pwd -NoNewLine -ForegroundColor Magenta
    Write-Host ""-NoNewLine

    # git-posh
    Write-VcsStatus

    return "> "
}
