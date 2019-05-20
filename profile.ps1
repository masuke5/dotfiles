$env:GIT_PAGER= "LESSCHARSET=utf-8 less"

Set-PSReadlineOption -BellStyle None

function RemoveAliasIfExist ($name) {
    # 最初はスクリプトのスコープのエイリアス、次にグローバルのエイリアスを削除する
    while (Test-Path alias:$name) {
        Remove-Item -Path alias:$name -Force
    }
}

RemoveAliasIfExist ls
RemoveAliasIfExist gin

Set-Alias -name python2 -value "C:\PL\Python27\python.exe"

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
    $datetime = Get-Date -Format "HH:mm:ss"
    Write-Host $datetime -NoNewLine -ForegroundColor Green
    Write-Host " " -NoNewLine
    $newpwd = $pwd -replace [regex]::escape($env:USERPROFILE), "~"
    Write-Host $newpwd -NoNewLine -ForegroundColor Yellow

    return "# "
}
