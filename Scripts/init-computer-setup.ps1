# Add tools for AD work in PS
Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online

# To verify install
# Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property DisplayName, State


# Windows 11 - Remove default right-click menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve