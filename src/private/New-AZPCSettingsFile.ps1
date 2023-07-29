function New-AZPCSettingsFile {
  New-Item -Path "$env:appdata\AzPowershellCompanion" -Name "Settings.json" -ItemType File
}