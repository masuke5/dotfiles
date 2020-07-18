# gitの文字化けを修正する
$env:GIT_PAGER= "LESSCHARSET=utf-8 less"

# ビープ音を無効にする
Set-PSReadlineOption -BellStyle None

# 全てのエイリアスを削除する
function RemoveAliasIfExist ($name) {
    # 最初はスクリプトのスコープのエイリアス、次にグローバルのエイリアスを削除する
    while (Test-Path alias:$name) {
        Remove-Item -Path alias:$name -Force
    }
}

RemoveAliasIfExist ls
RemoveAliasIfExist gin

Set-Alias -name python2 -value "C:\PL\Python27\python.exe"

# UNIXのls風
function ls($path) {
    if ($path -eq "") {
        $path = Get-Location
    }

    $space = 2
    $width = 70
    $dirs = (Get-ChildItem $path -Name -Directory) -split "`n"
    $files = (Get-ChildItem $path -Name -File) -split "`n"

    $maxCharCount = ($dirs + $files | Measure-Object -Maximum -Property Length).Maximum

    function Show-Entries($entries, $color) {
        $num = 0
        foreach ($entry in $entries) {
            $text = $entry.PadRight($maxCharCount + $space, " ")
            Write-Host $text -NoNewLine -ForegroundColor $color
            $num += $maxCharCount + $space
            if ($num -gt $width) {
                $num = 0
                Write-Host ""
            }
        }
        return $num
    }
    
    $num = Show-Entries $dirs Magenta

    if ($num -ne 0) {
        Write-Host ""
    }

    $num = Show-Entries $files (Get-Host).ui.rawui.ForegroundColor
}

function prompt {
    # 10:20:30 ~/Documents# cd aho
    # みたいにする

    $datetime = Get-Date -Format "HH:mm:ss"
    Write-Host $datetime -NoNewLine -ForegroundColor Green
    Write-Host " " -NoNewLine
    $newpwd = $pwd -replace [regex]::escape($env:USERPROFILE), "~"
    Write-Host $newpwd -NoNewLine -ForegroundColor Yellow

    return "# "
}
