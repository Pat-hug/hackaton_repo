# Guilde : Clé | Membre : Pierre-Louis

$ErrorActionPreference = "SilentlyContinue"
cls

function Status([bool]$Ok, [string]$Titre) {
    if ($Ok) { Write-Host "  [ OK ]   $Titre" -ForegroundColor Green }
    else     { Write-Host "  [ FAIL ] $Titre" -ForegroundColor Red }
}

# RAM
$ramTotale = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
$ramLibre  = [math]::Round($os.FreePhysicalMemory / 1MB, 1)
$ramUtilisee = [math]::Round($ramTotale - $ramLibre, 1)

# Disque C:
$d = Get-PSDrive -Name C
$disqueTotalGB   = [math]::Round(($d.Used + $d.Free) / 1GB, 1)
$disqueUtiliseGB = [math]::Round($d.Used / 1GB, 1)
$pctUtilise      = [math]::Round(100 * $d.Used / ($d.Used + $d.Free))


Write-Host "=== INFORMATIONS SYSTÈME ===" -ForegroundColor Cyan
$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$ramTotale = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
$ramLibre  = [math]::Round($os.FreePhysicalMemory / 1MB, 1)

Write-Host "  Machine : $env:COMPUTERNAME ($($os.Caption))"
Write-Host "  CPU     : $($cpu.Name.Trim())"
Write-Host "  RAM      : $ramUtilisee Go / $ramTotale Go (Libre: $ramLibre Go)"
Write-Host "  Disque C : $disqueUtiliseGB Go / $disqueTotalGB Go ($pctUtilise% utilisé)`n"

Write-Host "=== SÉCURITÉ ET SYSTÈME ===" -ForegroundColor Cyan

$hf = Get-HotFix | Where-Object { $_.InstalledOn } | Sort-Object InstalledOn -Descending | Select-Object -First 1
Status ($hf -and ((Get-Date) - $hf.InstalledOn).Days -le 40) "Windows à jour"

$mp = Get-MpComputerStatus
Status ($mp.RealTimeProtectionEnabled -and $mp.AntivirusSignatureAge -le 7) "Antivirus actif et à jour"

$fw = Get-NetFirewallProfile
Status ((@($fw | Where-Object { -not $_.Enabled }).Count) -eq 0) "Pare-feu actif"

Write-Host "=== LOGICIELS REQUIS ===" -ForegroundColor Cyan
Status ([bool](Get-Command git -ErrorAction SilentlyContinue)) "Git"
Status ([bool](Get-Command code -ErrorAction SilentlyContinue)) "VS Code"
Status (Test-Path "$env:LOCALAPPDATA\Programs\Bitwarden") "Bitwarden"
Status (Test-Path "$env:ProgramFiles\Mozilla Firefox\firefox.exe") "Firefox"