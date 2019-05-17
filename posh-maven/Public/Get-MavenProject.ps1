function Get-MavenProject {
    [CmdletBinding()]
    param(
        # Parameter help description
        [Parameter(Mandatory = $false)]
        [System.IO.DirectoryInfo[]]
        $InputObject = [System.IO.DirectoryInfo]::new($pwd)
    )

    process {
        foreach ($path in $InputObject) {
            $pom = Get-ChildItem $path -Filter "pom.xml"
            if (-not $pom) {
                throw "No pom.xml in $InputObject"
            }

            [xml](Get-Content $pom.FullName) | ConvertTo-MavenProject
        }
    }
}
