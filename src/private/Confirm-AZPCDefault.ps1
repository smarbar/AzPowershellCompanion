function Confirm-AZPCDefault {
  $baseFolder = "$env:appdata\AzPowershellCompanion"
  $baseFile = Join-Path -Path $baseFolder -ChildPath "Settings.json"
  $folderExists = Test-Path $baseFolder
  $fileExists = Test-Path $baseFile
  If (!$folderExists) {
    Show-AZPCPopup -Message "Default Subscription has not been set"
    New-AZPCSettingsFolder
    New-AZPCSettingsFile
    Set-AZPCDefault
  }
  ElseIf (!$fileExists) {
    Show-AZPCPopup -Message "Default Subscription has not been set"
    New-AZPCSettingsFile
    Set-AZPCDefault
  }
  Else {
    $fileContent = Get-Content -Path $baseFile | ConvertFrom-Json
    If (!$fileContent.SubscriptionId) {
      Show-AZPCPopup -Message "Default Subscription has not been set"
      Set-AZPCDefault
    }
  }
}