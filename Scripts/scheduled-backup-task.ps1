
# ----- NOTES -----

# Open PowerShell as Admin
# powershell.exe -noexit -ExecutionPolicy Bypass -File '___path to file____\scheduled-backup-task.ps1'


# ----- INPUTS & VARIABLES -----

[string] $SourcePath = Read-Host "Enter Full Path Of Folder to Backup"
[string] $SourceName = $SourcePath.Split("\") | Select-Object -Last 1

[string] $BackupsPath = "$env:USERPROFILE\Backups"
[string] $TargetPath = "$BackupsPath\$SourceName\$UnixTimeStamp"

[string] $TaskScriptsPath = "$env:USERPROFILE\ScheduledTaskScripts\"
[string] $TaskScriptsFileName = "FolderBackupScript-$SourceName.ps1"


# ----- Backup Code -----

$BackupCodeAsText = @"
    [int] `$UnixTimeStamp = (Get-Date -UFormat %s -Millisecond 0)
    [string] `$TargetPath = "$BackupsPath\$SourceName\`$UnixTimeStamp"

    New-Item -Path "`$TargetPath" -ItemType Directory
    Copy-item -Force -Recurse "$SourcePath" -Destination "`$TargetPath"
"@


# ----- Create Backup Script File -----

New-Item -Force -ItemType File `
    -Path $TaskScriptsPath `
    -Name $TaskScriptsFileName `
    -Value $BackupCodeAsText


# ----- Create Task -----

# Requires execute as Admin to set principal below
$Actions = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File `"$TaskScriptsPath$TaskScriptsFileName`""
$Trigger = New-ScheduledTaskTrigger -Daily -At "12:00 PM"
$Principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$Settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -WakeToRun -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$Task = New-ScheduledTask -Action $Actions -Trigger $Trigger -Principal $Principal -Settings $Settings

Register-ScheduledTask "Personal\FolderBackupScript-$SourceName" -InputObject $Task