### VARIABLES ###
. .\TestEnvConfig.ps1

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
    NetworkSecurityGroup = $jumpboxNSG
}

#Infra Subnet
$infrastructureSubnetParameters = @{
    Name = 'infrastructure_subnet'
    AddressPrefix = $testenv_infra_subnet
    NetworkSecurityGroup = $infraNSG
}

#App Subnet
$appSubnetParameters = @{
    Name = 'app_subnet'
    AddressPrefix = $testenv_app_subnet
    NetworkSecurityGroup = $appNSG
}

#Create Subnets
$vpnSubnet = New-AzVirtualNetworkSubnetConfig @vpnSubnetParameters #Infra Subnet Config
$jumpboxSubnet = New-AzVirtualNetworkSubnetConfig @jumpboxSubnetParameters #Bastion Subnet Config
$infraSubnet = New-AzVirtualNetworkSubnetConfig @infrastructureSubnetParameters #Infra Subnet Config
$appSubnet = New-AzVirtualNetworkSubnetConfig @appSubnetParameters #App Subnet Config

### FUNCTIONS ###
#Create Vnet using created subnets
function New-TestEnvVnet {
    New-AzVirtualNetwork -Name $testenv_vnet_name -ResourceGroupName $testenv_rg_name -Location $testenv_location `
    -AddressPrefix $testenv_vnet_prefix -Subnet $vpnSubnet,$jumpboxSubnet,$infraSubnet,$appSubnet
}
