function Get-MavenProject {
    [CmdletBinding()]
    param(
        # The maven project root
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
            Write-Warning "No pom.xml in $InputObject"
            return
        }
        $result = [xml](Get-Content $pom.FullName) | ConvertTo-MavenProject
        $result.Path = $path

        $moduleList = New-Object -TypeName System.Collections.ArrayList
        foreach ($subModule in $result.modules) {
            $fp = $path + "\" + $subModule
            Write-Debug $fp
            $moduleList.Add((Get-MavenProject $fp)) | Out-Null
        }
        #Write-Verbose $moduleList
        $result.modules = $moduleList

        Write-Output $result
    }
}

