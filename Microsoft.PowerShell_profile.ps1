# lies for me in C:\Users\{username}\Documents\WindowsPowerShell

# set helpful aliases
set-alias vim "C:\Vim\vim80\gvim.exe"
set-alias v "C:\Vim\vim80\gvim.exe"
set-alias .. "Set-Location \.."

# import history backwards upwards module
# see https://github.com/lzybkr/PSReadLine
Import-Module PSReadLine  
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# To edit the Powershell Profile
# (Not that I'll remember this)
Function Edit-Profile
{
    vim $profile
}

# To edit Vim settings
Function Edit-Vimrc
{
    vim $HOME\_vimrc
}
