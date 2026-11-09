# Guilde : Clé | Membre : Pierre-Louis

$ErrorActionPreference = "SilentlyContinue"
cls
Write-Host " Script de Pierre-Louis Le Guen-Geffroy"
$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1

$ramTotale = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
$ramLibre  = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
$ramUtilisee = [math]::Round($ramTotale - $ramLibre, 1)

$d = Get-PSDrive -Name C
$disqueTotalGB   = [math]::Round(($d.Used + $d.Free) / 1GB, 1)
$disqueUtiliseGB = [math]::Round($d.Used / 1GB, 1)
$pctUtilise      = [math]::Round(100 * $d.Used / ($d.Used + $d.Free))

Write-Host "  Machine  : $env:COMPUTERNAME ($($os.Caption))"
Write-Host "  CPU      : $($cpu.Name.Trim())"

Write-Host "  RAM      : $ramUtilisee Go / $ramTotale Go (Libre: $ramLibre Go)"
Write-Host "  Disque C : $disqueUtiliseGB Go / $disqueTotalGB Go ($pctUtilise% utilisé)`n"