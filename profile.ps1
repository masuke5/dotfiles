Remove-Item alias:mp -force

function mp { cd "~\Programming\Projects" }
function mpd { cd "~\Documents\Projects" }
function vi { vim --noplugin $args }

function prompt {
    $datetime = Get-Date -Format "HH:mm:ss"

    Write-Host $datetime -NoNewLine -ForegroundColor Green
    Write-Host " " -NoNewLine
    Write-Host $pwd -NoNewLine -ForegroundColor Magenta

    # git-posh
    Write-VcsStatus

    return "> "
}
