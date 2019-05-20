function Get-MavenProject {
    [CmdletBinding()]
    param(
        # The maven project ro
        [Parameter( Mandatory = $false, Position = 0, ValueFromPipeline = $true )]
        [System.IO.DirectoryInfo[]]
        $InputObject = [System.IO.DirectoryInfo]::new($pwd)
    )

    process {
        if (-not (Test-Path $InputObject)) {
            $path = (Get-Item $InputObject.FullName).FullName
        }
        else {
            $path = (Get-Item $InputObject).FullName
        }
        $pom = Get-ChildItem $path -Filter "pom.xml"
        if (-not $pom) {
            Write-Warning "No pom.xml in $path"
            return
        }
        $result = [xml](Get-Content $pom.FullName) | ConvertTo-MavenProject
        $result.Path = $path

        Write-Output $result
    }
}

