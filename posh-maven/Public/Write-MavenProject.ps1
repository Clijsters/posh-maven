function Write-MavenProject {
    [CmdletBinding()]
    param (
        # the maven project root path
        [Parameter(Mandatory = $false)]
        [string]
        $path = $pwd
	)

	try {
		$project = Get-MavenProject -WarningAction SilentlyContinue
	} catch {

	}
    Write-Host "[" -NoNewline -ForegroundColor Yellow
    Write-Host $project.GroupId -ForegroundColor Cyan -NoNewline
    Write-Host "." -NoNewline
	Write-Host $project.artifactId -NoNewline -ForegroundColor Green
	Write-Host " " -NoNewline
	Write-Host $project.version -NoNewline -ForegroundColor Gray
	Write-Host "]" -NoNewline -ForegroundColor Yellow
}
