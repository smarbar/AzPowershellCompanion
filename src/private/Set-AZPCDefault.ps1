function Set-AZPCDefault {
  $tenantDetails = Get-AzTenant | Out-GridView -PassThru -Title 'Select the Tenant'
  $subscriptionDetails = $tenantDetails | get-azsubscription | Out-GridView -PassThru -Title 'Select the subscription'
  $tenantId = $tenantDetails.Id
  $tenantName = $tenantDetails.Name
  $subscriptionId = $subscriptionDetails.Id
  $subscriptionName = $subscriptionDetails.Name
  $fileContents = @{
    TenantId         = $tenantId
    TenantName       = $tenantName
    SubscriptionId   = $subscriptionId
    SubscriptionName = $subscriptionName
  }
  Set-Content -Path "$env:appdata\AzPowershellCompanion\Settings.json" -Value ($fileContents | ConvertTo-Json) -Force
}