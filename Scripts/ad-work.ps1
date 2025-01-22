# from bob: installs the necessary windows component for AD work
Get-WindowsCapability -Online | Where-Object { $_.Name -like "Rsat.ActiveDirectory.DS-LDS.Tools*" } | Add-WindowsCapability -Online


# Search for User by SOM name
Get-ADUser -Filter 'SamAccountName -like "*__username__*"' -Properties *
Get-ADUser -Filter 'SamAccountName -like "*__username__*"' -Properties memberof,Created
Get-ADUser -Filter 'SamAccountName -like "*__username__*"' -Properties memberof,Created | Select-Object Enabled,SamAccountName,Created,DistinguishedName

# Search for group by name
Get-ADGroup -Filter {Name -like 'ES_SADLC_*'}

# Get Groups associated with User
Get-ADPrincipalGroupMembership __username__ | Select-Object Name
# or
Get-ADUser __username__ -Properties memberof | Select-Object -Expand memberof

# Get Accounts that are part of a Group
Get-ADGroupMember -Identity __group__ | Select-Object SamAccountName