### Connect to Azure tenant
#Connect-AzAccount -Tenant "e0c43f0d-a087-4ac7-8d19-86b0110a1289"

### VARIABLES ###
$testenv_rg_name = 'rg_vnet_testenv' # Test Environment Resource Group Name
$testenv_location = 'westus3' # Test Environment Location
$testenv_vnet_prefix = '10.0.0.0/16' # Test Environment VNet Prefix
$testenv_bastion_subnet = '10.0.1.0/24' # Test Environment Bastion Subnet
$testenv_infra_subnet = '10.0.2.0/24' # Test Environment Infra Subnet


#Resource Group Config
$rg = @{
    Name = $testenv_rg_name #vnet resource group name
    Location = $testenv_location #vnet location
}

#Subnet Parameters
#Infra Subnet
$infrastructureSubnetParameters = @{
    Name = 'infrastructure_subnet'
    AddressPrefix = $testenv_infra_subnet
}

#Bastion Subnet
$bastionSubnetParameters = @{
    Name = 'bastion_subnet'
    AddressPrefix = $testenv_bastion_subnet
}

#Virtual Network Parameters
$vnet = @{ 
    Name = "testenv_vnet"
    ResourceGroupName = $testenv_rg_name
    Location = $testenv_location
    AddressPrefix = $testenv_vnet_prefix
    Subnet = $infraSubnet,$bastionSubnet
}

#Network Security Group Parameters
$rdpRule = @{
    Name = 'rdp_rule'
    Description = 'Allow RDP From Workstations Public IP'
    Access = 'Allow'
    Protocol = 'TCP'
    Direction = 'Inbound'
    Priority = 100
    SourceAddressPrefix = $myPublicIP
    SourcePortRange = '*'
    DestinationAddressPrefix = '*'
    DestinationAddressPort = 3389
}


### FUNCTIONS ###
#Function to retrieve Public IP for Network Security Group RDP Allowance
function Get-MyPublicIP {
    $uri = 'https://api.ipify.org'
    try {
        $invokeRestMethodSplat = @{
            uri = $uri
            ErrorAction = 'Stop'
        }
        $PublicIP = Invoke-RestMethod @invokeRestMethodSplat
    }
    catch {
        Write-Error $_
    }
    return $publicIP
}

### PROCESS ###
#Create Resource Group for Vnet
$myPublicIP = Get-MyPublicIP
New-AzResourceGroup @rg
$infraSubnet = New-AzVirtualNetworkSubnetConfig @infrastructureSubnetParameters #Infra Subnet Config
$bastionSubnet = New-AzVirtualNetworkSubnetConfig @bastionSubnetParameters #Bastion Subnet Config
New-AzVirtualNetwork @vnet

