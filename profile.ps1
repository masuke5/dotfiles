function fclone {
    C:\Program` Files\ConEmu\ConEmu64.exe /Single -cmd "powershell.exe -NoLogo -NoExit `"cd '${pwd}'`""
}

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

    # git
    if (Test-Path ".git") {
        Write-Host " [" -NoNewline -ForegroundColor Yellow

        $gitstatus = git status --long

        $color = "DarkCyan"
        $info = ""

        $currentBranch = ""
        if ($gitstatus[2] -match "No commits yet") {
            $currentBranch = "no branch"
        } else {
            # ���݂̃u�����`���擾
            $currentBranch = git branch --color=never | where { $_ -match "^\*" } # ���݂̃u�����`���擾
            $currentBranch = [string]::Join("", $currentBranch) -replace "`n", "" # ������ɕϊ�
            $currentBranch = ($currentBranch -replace "^\*", "").Trim() # �A�X�^���X�N���폜
        }

        if ($gitstatus[1] -match "^Your branch is ahead of") {
            $color = "Green"

            # �v�b�V�����Ă��Ȃ��R�~�b�g�����擾
            $notPushedCommits = [regex]::match($gitstatus[1], "by (\d+) commits\.$").Groups[1].Value
            $info += " ��$notPushedCommits"
        }
        if ($gitstatus[1] -match "have diverged\,$") {
            $color = "Magenta"

            $matches = [regex]::match($gitstatus[2], "(\d+) and (\d+) different commits")
            $commits = $matches.Groups[1].Value
            $differents = $matches.Groups[2].Value
            $info += " ��$commits ��$differents"
        }

        Write-Host "$currentBranch$info" -NoNewline -ForegroundColor $color

        Write-Host "]" -NoNewline -ForegroundColor Yellow
    }

    return "# "
}
