### Variables
. ./TestEnvConfig.ps1

### RDP Rule Parameters
$allowRdpRule = @{
    Name = 'allow_rdp_rule'
    Description = 'Allow RDP From Workstations Public IP'
    Access = 'Allow'
    Protocol = 'TCP'
    Direction = 'Inbound'
    Priority = 100
    SourceAddressPrefix = $myPublicIP
    SourcePortRange = '*'
    DestinationAddressPrefix = '*'
    DestinationPortRange = '3389'
}

$allowHTTPSRule = @{
    Name = 'allow_https_rule'
    Description = 'Allow HTTPS traffic'
    Access = 'Allow'
    Protocol = 'TCP'
    Direction = 'Inbound'
    Priority = 110
    SourceAddressPrefix = '*'
    SourcePortRange = '*'
    DestinationAddressPrefix = '*'
    DestinationPortRange = '443'
}

$allowHTTPRule = @{
    Name = 'allow_http_rule'
    Description = 'Allow HTTP traffic'
    Access = 'Allow'
    Protocol = 'TCP'
    Direction = 'Inbound'
    Priority = 120
    SourceAddressPrefix = '*'
    SourcePortRange = '*'
    DestinationAddressPrefix = '*'
    DestinationPortRange = '80'
}

### Variables
$jumpboxRule1 = New-AzNetworkSecurityRuleConfig @allowRdpRule
$jumpboxRule2 = New-AzNetworkSecurityRuleConfig @allowHTTPSRule
$jumpboxRule3 = New-AzNetworkSecurityRuleConfig @allowHTTPRule

function Get-MyPublicIP {
    $uri = 'https://api.ipify.org'
    try {
        $invokeRestMethodSplat = @{
            uri = $uri
            ErrorAction = 'Stop'
        }
        $PublicIP = Invoke-RestMethod -uri $uri -ErrorAction 'Stop'
    }
    catch {
        Write-Error $_
    }
    return $publicIP
}

function New-NSGs {
    #Create Jumpbox Subnet NSG
    New-AzNetworkSecurityGroup -Name 'jumpboxNSG' -Location $testenv_location -ResourceGroupName $testenv_rg_name `
    -SecurityRules $allowRdpRule,$allowHTTPSRule,$allowHTTPRule
    # Create Infra Subnet NSG
    New-AznetworkSecurityGroup -Name 'infraNSG' -Location $testenv_location -ResourceGroupName $testenv_rg_name
    # Create App Subnet NSG
    New-AznetworkSecurityGroup -Name 'appNSG' -Location $testenv_location -ResourceGroupName $testenv_rg_name
}