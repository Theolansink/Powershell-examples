param(
    [Parameter(Position=0)]
    [string]$Name = "MyRG",

    [Parameter(Position=1)]
    [string]$Location = "westeurope"
)

# Check of de Resource Group bestaat
$rg = Get-AzResourceGroup -Name $Name -ErrorAction SilentlyContinue

if ($rg) {
    Write-Output "Resource group '$Name' gevonden in $($rg.Location). Verwijderen..."
    # Resource Group verwijderen
    Remove-AzResourceGroup -Name $Name -Force -AsJob
    Write-Output "Verwijdering van resource group '$Name' gestart."
} else {
    Write-Output "Resource group '$Name' bestaat niet."
}
