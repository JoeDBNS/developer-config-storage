# Add tools for AD work in PS
Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online

# To verify install
Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property DisplayName, State