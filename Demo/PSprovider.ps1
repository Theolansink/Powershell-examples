
# 1
Cd C:\

# 2
Set-Location C:\Windows

# 3
New-PSDrive –Name WINDIR –Root C:\Windows –PSProvider FileSystem

# 4
Dir WINDIR:

#5
Get-ChildItem WINDIR:

#6
New-Item E:\Mod04\Temp -ItemType Folder