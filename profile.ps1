function fclone {
    C:\Program` Files\ConEmu\ConEmu64.exe /Single -cmd "powershell.exe -NoLogo -NoExit `"cd '${pwd}'`""
}

function RemoveAliasIfExist ($name) {
    # 最初はスクリプトのスコープのエイリアス、次にグローバルのエイリアスを削除する
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
            # 現在のブランチを取得
            $currentBranch = git branch --color=never | where { $_ -match "^\*" } # 現在のブランチを取得
            $currentBranch = [string]::Join("", $currentBranch) -replace "`n", "" # 文字列に変換
            $currentBranch = ($currentBranch -replace "^\*", "").Trim() # アスタリスクを削除
        }

        if ($gitstatus[1] -match "^Your branch is ahead of") {
            $color = "Green"

            # プッシュしていないコミット数を取得
            $notPushedCommits = [regex]::match($gitstatus[1], "by (\d+) commits\.$").Groups[1].Value
            $info += " ↑$notPushedCommits"
        }
        if ($gitstatus[1] -match "have diverged\,$") {
            $color = "Magenta"

            $matches = [regex]::match($gitstatus[2], "(\d+) and (\d+) different commits")
            $commits = $matches.Groups[1].Value
            $differents = $matches.Groups[2].Value
            $info += " ↓$commits ↑$differents"
        }

        Write-Host "$currentBranch$info" -NoNewline -ForegroundColor $color

        Write-Host "]" -NoNewline -ForegroundColor Yellow
    }

    return "# "
}
