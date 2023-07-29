function Set-AZPCSubscriptionBoth {
  [CmdletBinding()]
  param (
    [Parameter()]
    [Switch]
    $Default
  )
  If ($Default) {
    Confirm-AZPCDefault
    $settings = Get-AZPCDefault
    $subId = $settings.SubscriptionId
  }
  Else {
    $tenant = Get-AzTenant | Out-GridView -PassThru -Title 'Select the Tenant' 
    $subscription = $tenant | get-azsubscription | Out-GridView -PassThru -Title 'Select the subscription'
    If (!$subscription) {
      $tenantId = $tenant.id
      Write-Error "Something Went wrong: You will probably have to re-authenticate to the tenant first. Try running the following command before setting it again"
      Write-Error "Connect-AzAccount -TenantId $tenantId"
      break
    }
    $subId = $subscription.id
  }
  Select-AzSubscription -SubscriptionId $subId
  az account set --subscription $subId
}