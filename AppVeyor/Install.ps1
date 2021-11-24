# Some credits of this file go to Javy de Koning

Write-Host 'Installing Dependencies...' -ForegroundColor Yellow

$packageProvider = Install-PackageProvider -Name NuGet -Force
Write-Host " - NuGet version '$($packageProvider.version)'"

Write-Host ' - Pester'
Install-Module -Name Pester -Repository PSGallery -Force

Write-Host ' - PSScriptAnalyzer'
Install-Module PSScriptAnalyzer -Repository PSGallery -Force

Write-Host ' - CodeCov (choco)'
choco install codecov

Write-Host "Done."

Write-Host "Installing posh-maven..." -ForegroundColor Yellow
Get-Location

Import-Module "$PSScriptRoot\..\posh-maven\posh-maven.psm1"
