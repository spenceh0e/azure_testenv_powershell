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