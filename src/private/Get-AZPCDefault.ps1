function Get-AZPCDefault {
  $settings = Get-Content -Path "$env:appdata\AzPowershellCompanion\Settings.json" | ConvertFrom-Json
  return $settings
}