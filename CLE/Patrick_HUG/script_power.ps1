Write-Host "Patrick HU-GUILLET script"
Write-Host "=======Information de l'host======="
Write-Host "`Nom du PC : $env:COMPUTERNAME"
Write-Host "======= Informations du PC ======="
$cpu = Get-CimInstance Win32_Processor
Write-Host "CPU : $($cpu.Name)"
Write-Host "Coeurs : $($cpu.NumberOfCores)"
Write-Host "Threads : $($cpu.NumberOfLogicalProcessors)"
$ram = Get-CimInstance Win32_ComputerSystem
$ramGB = [math]::Round($ram.TotalPhysicalMemory / 1GB, 2)
Write-Host "RAM : $ramGB Go"

Write-Host "======= STOCKAGE ======="
Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
Select-Object DeviceID,
    @{Name="Size_Go";Expression={[math]::Round($_.Size / 1GB, 2)}},
    @{Name="FreeSpace_Go";Expression={[math]::Round($_.FreeSpace / 1GB, 2)}}