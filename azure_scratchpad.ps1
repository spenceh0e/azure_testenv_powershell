$cred = Get-Credential
$testenv_rg_name = 'rg_vnet_testenv' # Test Environment Resource Group Name
$testenv_location = 'westus3' # Test Environment Location

$testenv_vnet_name = "testenv_vnet"
$testenv_vnet_prefix = '10.0.0.0/16' # Test Environment VNet Prefix

$testenv_jumpbox_subnet = '10.0.1.0/24' # Test Environment Jumpbox Subnet
$testenv_infra_subnet = '10.0.2.0/24' # Test Environment Infra Subnet
$testenv_app_subnet = '10.0.3.0/24' # Test Environment App Subnet


$jumpboxSubnetParameters = @{
    Name = 'jumpbox_subnet'
    AddressPrefix = $testenv_jumpbox_subnet
}

function New-JumpboxVM {
    New-AzVm `
        -Credential $cred `
        -ResourceGroupName $testenv_rg_name `
        -Name 'jumpboxVM' `
        -Location $testenv_location `
        -VirtualNetworkName $testenv_vnet_name `
        -SubnetName $jumpboxSubnetParameters.Name `
        -SecurityGroupName 'jumpbox_subnet_nsg' `
        -OpenPorts 80,3389,443 `
        -Size 'Standard_B1s' `
        -Image 'Win2016Datacenter'
}






$vnet = @{ 
    Name = "testenv_vnet"
    ResourceGroupName = $testenv_rg_name
    Location = $testenv_location
    AddressPrefix = $testenv_vnet_prefix
    Subnet = $vpnSubnet,$jumpboxSubnet,$infraSubnet,$appSubnet
}