$env:GIT_PAGER= "LESSCHARSET=utf-8 less"

#Import-Module posh-git
#$GitPromptSettings.DefaultPromptPrefix = '$(Get-Date -f "HH:mm:ss") '
#$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
#$GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Yellow
#$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true

Set-PSReadlineOption -BellStyle None

Set-Alias -name python2 -value "C:\PL\Python27\python.exe"

function RemoveAliasIfExist ($name) {
    # 最初はスクリプトのスコープのエイリアス、次にグローバルのエイリアスを削除する
    while (Test-Path alias:$name) {
        Remove-Item -Path alias:$name -Force
    }
}

function prompt {
    $datetime = Get-Date -Format "HH:mm:ss"
    Write-Host $datetime -NoNewLine -ForegroundColor Green
    Write-Host " " -NoNewLine
    $newpwd = $pwd -replace [regex]::escape($env:USERPROFILE), "~"
    Write-Host $newpwd -NoNewLine -ForegroundColor Yellow

    return "# "
}
