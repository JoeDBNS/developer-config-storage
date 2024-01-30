
# ----- SEARCH -----

# Get-ScheduledTask

# Get-ScheduledTask | Where-Object state -eq 'Running'

# Get-ScheduledTask -TaskName 'windows*'

# Get-ScheduledTask -TaskPath '\Microsoft*'


# ----- Create App File -----

$Path = "c:\temp\test1.txt"
# Create the folder is the path doesn't exist
If (-not(test-path -Path $Path)) {
    New-Item -Path $Path -ItemType File
}

New-Item -Path "c:\temp" -Name "test01.txt" -ItemType File -Force

# Create a file and set the content
Set-Content -Path c:\temp\newFile.txt -Value "New file with Content"
# Or use New-Item to create the file with content
New-Item -Path c:\temp\ -name "newFile.txt" -Value "New file with Content"


# ----- Create Task -----


$action = New-ScheduledTaskAction -Execute 'app-path'




# [string]$sourceDirectory = "C:\Temp\Random_Folder"

# [string]$destinationDirectory = "C:\Users\anyuser\Documents"
# Copy-item -Force -Recurse -Verbose $sourceDirectory -Destination $destinationDirectory