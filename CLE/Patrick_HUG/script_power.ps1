Write-Host "bienvenue dans le script de vérification"
Write-Host "-_-Information de l'host-_-"


$bit = "Bitwarden"
if (winget list --name $bit --exact | Select-String -SimpleMatch $bit){
    Write-Host "BitWarden est installé"
}
else {
    Write-Host "Bitwarden absent"
    }

Write-Host "Vérification de Bitwarden sur Firefox"
$profil = "$env:APPDATA\Mozilla\Firefox\Profiles"

Get-ChildItem $profil -Recurse -Filter "extensions.json" |
Select-String -Pattern "bitwarden"