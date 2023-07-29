param(
    $Version = "0.0.1" #Defualt only used for local build testing
)

$srcPath = "$PSScriptRoot\src"
$buildPath = "$PSScriptRoot\build"
$docPath = "$PSScriptRoot\docs"
$moduleName = "AzPowershellCompanion"
$moduleDescription = 'Functions to help navigating Azure Powershell'
$modulePath = "$buildPath\$moduleName"
$author = 'Scott Barrett'
$githubRepo = 'smarbar'

task Clean {
    If (Get-Module $moduleName) {
        Remove-Module $moduleName
    }
    If (Test-Path $modulePath) {
        $null = Remove-Item $modulePath -Recurse -ErrorAction Ignore
    }
}

task DocBuild {
    New-ExternalHelp $docPath -OutputPath "$modulePath\EN-US"
}

task ModuleBuild Clean, DocBuild, {
    $pubFiles = Get-ChildItem "$srcPath\public" -Filter *.ps1 -File -recurse
    $privFiles = Get-ChildItem "$srcPath\private" -Filter *.ps1 -File -recurse
    If (-not(Test-Path $modulePath)) {
        New-Item $modulePath -ItemType Directory
    }
    ForEach ($file in ($pubFiles + $privFiles)) {
        Get-Content $file.FullName | Out-File "$modulePath\$moduleName.psm1" -Append -Encoding utf8
    }
    Copy-Item "$srcPath\$moduleName.psd1" -Destination $modulePath

    $moduleManifestData = @{
        Author            = $author
        Copyright         = "(c) $((get-date).Year) $author. All rights reserved."
        Path              = "$modulePath\$moduleName.psd1"
        FunctionsToExport = $pubFiles.BaseName
        RootModule        = "$moduleName.psm1"
        ModuleVersion     = $Version
        Description       = $moduleDescription
        ProjectUri        = "https://github.com/$githubRepo/$modulename"
    }
    Update-ModuleManifest @moduleManifestData
    Import-Module $modulePath -RequiredVersion $Version
}

task Publish {
    Invoke-PSDeploy -Path $PSScriptRoot -Force
}

task All ModuleBuild, Publish
