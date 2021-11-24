function Get-MavenProjectVersion {
    [CmdletBinding()]
    param(
        # The maven project root
        [Parameter( Mandatory = $false, Position = 0, ValueFromPipeline = $true )]
        [System.IO.DirectoryInfo[]]
        $InputObject = [System.IO.DirectoryInfo]::new($pwd)
    )

    Write-Output (Get-MavenProject $InputObject).Version
}
