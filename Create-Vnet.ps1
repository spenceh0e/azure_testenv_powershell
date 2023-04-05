### Connect to Azure tenant
#Connect-AzAccount -Tenant "e0c43f0d-a087-4ac7-8d19-86b0110a1289"

### VARIABLES ###

. .\TestEnvVariables.ps1

### Subnet Parameters
#VPN Subnet
$vpnSubnetParameters = @{
    Name = 'vpn_subnet'
    AddressPrefix = $testenv_vpn_subnet
}

#Jumpbox Subnet
$jumpboxSubnetParameters = @{
    Name = 'jumpbox_subnet'
    AddressPrefix = $testenv_jumpbox_subnet
}

#Infra Subnet
$infrastructureSubnetParameters = @{
    Name = 'infrastructure_subnet'
    AddressPrefix = $testenv_infra_subnet
}

#App Subnet
$appSubnetParameters = @{
    Name = 'app_subnet'
    AddressPrefix = $testenv_app_subnet
}


###Virtual Network Parameters
$vnet = @{ 
    Name = "testenv_vnet"
    ResourceGroupName = $testenv_rg_name
    Location = $testenv_location
    AddressPrefix = $testenv_vnet_prefix
    Subnet = $vpnSubnet,$jumpboxSubnet,$infraSubnet,$appSubnet
}

#Create Subnets
$vpnSubnet = New-AzVirtualNetworkSubnetConfig @vpnSubnetParameters #Infra Subnet Config
$jumpboxSubnet = New-AzVirtualNetworkSubnetConfig @jumpboxSubnetParameters #Bastion Subnet Config
$infraSubnet = New-AzVirtualNetworkSubnetConfig @infrastructureSubnetParameters #Infra Subnet Config
$appSubnet = New-AzVirtualNetworkSubnetConfig @appSubnetParameters #App Subnet Config

### FUNCTIONS ###
#Create Vnet using created subnets
function New-TestEnvVnet {
    New-AzVirtualNetwork @vnet
}
