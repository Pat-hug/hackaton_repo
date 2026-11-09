#Création des variables 
$os = Get-WmiObject Win32_OperatingSystem
$cpu = Get-WmiObject Win32_Processor | Select-Object -First 1
$disk = Get-PSDrive C
$wu = Get-Service wuauserv -ErrorAction SilentlyContinue

#Affichage des statistiques du pc
Write-Host "Date: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')" -
Write-Host "Systeme: $($os.Caption) v$($os.Version)" -ForegroundColor Green
Write-Host "Machine: $env:COMPUTERNAME" -ForegroundColor Green
Write-Host "Processeur: $($cpu.Name) ($($cpu.NumberOfCores) coeurs)" -ForegroundColor Green
Write-Host "RAM: $([math]::Round(($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / 1MB, 0)) GB / $([math]::Round($os.TotalVisibleMemorySize / 1MB, 0)) GB" -ForegroundColor Green
Write-Host "CPU: $(Get-WmiObject Win32_PerfFormattedData_PerfOS_Processor | Where-Object Name -eq "_Total" | Select-Object -ExpandProperty PercentProcessorTime)%" -ForegroundColor Green

#Change de couleur si service ON (green) sinon yellow
Write-Host "Service Windows Update: $($wu.Status)" -ForegroundColor $(if ($wu.Status -eq "Running") { "Green" } else { "Yellow" })
Write-Host ""
Read-Host "Appuyez sur Entree pour fermer"
