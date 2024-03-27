# from bob: installs the necessary windows component for AD work
Get-WindowsCapability -Online | Where-Object { $_.Name -like "Rsat.ActiveDirectory.DS-LDS.Tools*" } | Add-WindowsCapability -Online


# Search for group by name
Get-ADGroup -Filter {Name -like 'ES_SADLC_*'}

# Get Groups associated with User
Get-ADPrincipalGroupMembership davisj38 | Select-Object Name
# or
Get-ADUser davisj38 -Properties memberof | Select-Object -Expand memberof