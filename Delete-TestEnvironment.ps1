### Connect to Azure tenant
#Connect-AzAccount -Tenant "e0c43f0d-a087-4ac7-8d19-86b0110a1289"

Remove-AzResourceGroup 'rg_vnet_testenv' -Force
Remove-AzResourceGroup 'NetworkWatcherRG' -Force