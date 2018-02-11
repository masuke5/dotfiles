function RemoveAliasIfExist ($name) {
    # �ŏ��̓X�N���v�g�̃X�R�[�v�̃G�C���A�X�A���ɃO���[�o���̃G�C���A�X���폜����
    while (Test-Path alias:$name) {
        Remove-Item -Path alias:$name -Force
    }
}

RemoveAliasIfExist "mp"

function mp { cd "~\Programming\Projects" }
function mpd { cd "~\Documents\Projects" }
function vi { vim --noplugin $args }

function prompt {
    $datetime = Get-Date -Format "HH:mm:ss"

    Write-Host $datetime -NoNewLine -ForegroundColor Green
    Write-Host " " -NoNewLine

    $newpwd = $pwd -replace [regex]::escape($env:USERPROFILE), "~"
    Write-Host $newpwd -NoNewLine -ForegroundColor Yellow

    # git-posh
    Write-VcsStatus

    return "# "
}
