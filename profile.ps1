$env:GIT_PAGER= "LESSCHARSET=utf-8 less"

Set-PSReadlineOption -BellStyle None

function RemoveAliasIfExist ($name) {
    # 最初はスクリプトのスコープのエイリアス、次にグローバルのエイリアスを削除する
    while (Test-Path alias:$name) {
        Remove-Item -Path alias:$name -Force
    }
}

RemoveAliasIfExist ls

Set-Alias -name python2 -value "C:\PL\Python27\python.exe"

function ls {
    foreach ($dir in (Get-ChildItem -Name -Directory) -split "`n") {
        Write-Host "$dir" -NoNewLine -ForegroundColor Blue
        Write-Host "  " -NoNewLine
    }
    (Get-ChildItem -Name -File) -split "`n" -join "  "
}

function prompt {
    $datetime = Get-Date -Format "HH:mm:ss"
    Write-Host $datetime -NoNewLine -ForegroundColor Green
    Write-Host " " -NoNewLine
    $newpwd = $pwd -replace [regex]::escape($env:USERPROFILE), "~"
    Write-Host $newpwd -NoNewLine -ForegroundColor Yellow

    return "# "
}
