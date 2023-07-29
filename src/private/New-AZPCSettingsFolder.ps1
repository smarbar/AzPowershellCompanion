function New-AZPCSettingsFolder {
  New-Item -Path $env:appdata -Name 'AzPowershellCompanion' -ItemType Directory
}