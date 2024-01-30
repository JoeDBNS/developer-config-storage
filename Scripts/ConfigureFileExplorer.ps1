# WIP - NEVER RUN OR TESTED


# Is it supposed to be this?
# $key = 'HKEY_LOCAL_MACHINE:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key ShowSuperHidden 1
Set-ItemProperty $key HideDrivesWithNoMedia 0
Set-ItemProperty $key AutoCheckSelect 1
# Include:
# - default path to "This PC"
# - remove all 'insights'
Stop-Process -processname explorer