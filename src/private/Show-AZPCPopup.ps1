function Show-AZPCPopup {
  [CmdletBinding()]
  param (
    [Parameter()]
    [String]
    $Message
  )
  $wshell = New-Object -ComObject Wscript.Shell
  $Output = $wshell.Popup($Message)
}