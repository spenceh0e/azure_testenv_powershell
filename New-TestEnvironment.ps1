<# 
Initializes ancillary scripts to create a new azure environment 

Steps:
1) Create a new resource group
2) Create Network Security Groups
3) Create VNet
4) Create VPN
5) Create 1 Jumpbox VM
6) Create 3 Infra VMs - Windows
7) Create 3 App vms - Ubuntu

#>

### Variables ###

### Source Scripts
. .\testEnvConfig.ps1
. .\Create-NetworkSecurityGroups.ps1
. .\Create-Vnet.ps1

### Process ###
# Step 1 - Create a new resource group
New-AzResourceGroup -Name $testenv_rg_name -Location $testenv_location

# Step 2 - Create Vnet - Function Sourced from .\Create-Vnet.ps1
New-TestEnvVnet

#Step 3 - Create NSGs - Function sourced from .\Create-NetworkSecurityGroups.ps1
New-NSGs

