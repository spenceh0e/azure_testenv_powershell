<# 
Initializes ancillary scripts to create a new azure environment 

Steps:
1) Create a new resource group
2) Create Network Security Groups
3) Create VNet
#>

### Variables ###
#$cred = Get-Credential


### Source Scripts
. .\testEnvVariables.ps1
. .\Create-Vnet.ps1

### Process ###
# Step 1 - Create a new resource group
New-AzResourceGroup -Name $testenv_rg_name -Location $testenv_location

# Step 2 - Create Vnet - Function Sourced from \Create-Vnet.ps1
New-TestEnvVnet