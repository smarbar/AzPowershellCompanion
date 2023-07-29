[cmdletbinding()]
param(
    [string[]]$Task = 'ModuleBuild',
    [version]$Version
)

# $parameters = @{
#     Name               = "PSGallery"
#     SourceLocation     = "https://www.powershellgallery.com/api/v2"
#     PublishLocation    = "https://www.powershellgallery.com/api/v2"
#     InstallationPolicy = 'Untrusted'
# }
# Register-PSRepository @parameters

$DependentModules = @('PSDeploy', 'InvokeBuild', 'PlatyPS')
Foreach ($Module in $DependentModules) {
    If (-not (Get-Module $module -ListAvailable)) {
        Install-Module -name $Module -Scope CurrentUser -Force
    }
    Import-Module $module -ErrorAction SilentlyContinue
}
Invoke-Build "$PSScriptRoot\SbModuleBuilder.build.ps1" -Task $Task -Version $Version