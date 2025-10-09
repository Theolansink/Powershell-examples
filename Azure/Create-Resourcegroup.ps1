param(
    [Parameter(position=0)]
    [string]$Name = "MyRG",
    [Parameter(position=1)]
    [string]$Location = "westeurope"
)

# Check of de Resource Group al bestaat
if (Get-AzResourceGroup -Name $Name -ErrorAction SilentlyContinue) {
    Write-Output "Resource group '$Name' bestaat al in $Location."
} else {
    # Resource Group aanmaken
    New-AzResourceGroup -Name $Name -Location $Location
    Write-Output "Resource group '$Name' aangemaakt in $Location."
}

