function ConvertTo-MavenProject {
    [CmdletBinding()]
    [OutputType("posh-maven.MavenProject")]
    param(
        # A (set of) xml documents to convert
        [Parameter( Mandatory = $true, Position = 0, ValueFromPipeline = $true )]
        [xml[]]
        $InputObject
    )

    begin {
        New-Item function::local:Write-Verbose -Value (
            New-Module -ScriptBlock { param($verb, $fixedName, $verbose) } -ArgumentList @((Get-Command Write-Verbose), $PSCmdlet.MyInvocation.InvocationName, $PSCmdlet.MyInvocation.BoundParameters["Verbose"].IsPresent)
        ).NewBoundScriptBlock{
            param($Message)
            if ($verbose) {
                & $verb -Message "=>$fixedName $Message" -Verbose
            }
            else {
                & $verb -Message "=>$fixedName $Message"
            }
        } | Write-Verbose
    }

    process {
        $pom = $InputObject.project

        if (-not $pom) {
            Throw "No project node in input xml"
        }
        if ($pom.groupId) {
            $groupId = $pom.groupId
        } elseif ($pom.parent.groupId){
            $groupId = $pom.parent.groupId
        } else {
            $groupId = "UNKNOWN"
        }

        $result = [PSCustomObject]@{
            Name                 = $groupId + ":" + $pom.artifactId;
            GroupId              = $groupId;
            ArtifactId           = $pom.artifactId;
            Version              = $pom.version;
            Parent               = $pom.parent;
            Properties           = $pom.properties;
            DependencyManagement = $pom.dependencyManagement;
            Dependencies         = [psobject[]]@($pom.dependencies.dependency);
            Build                = @{
                plugins = $pom.plugins.plugin;
            };
            Path                 = "";
            Modules              = $pom.modules.module;
            originalObject       = $InputObject
        }

        $properties = @{ }
        if ($pom.properties) {
            foreach ($property in ($pom.properties | Get-member | Where-Object MemberType -eq Property)) {
                $properties[$property.name] = $pom.properties[$property.name].'#text'
            }
        }
        $result.properties = New-Object -TypeName psobject -Property $properties

        $result.properties.PSObject.TypeNames.Insert(0, "posh-maven.MavenProject.MavenProperties")
        $result.PSObject.TypeNames.Insert(0, "posh-maven.MavenProject")

        $result | Add-Member -MemberType ScriptMethod -Name "ToString" -Force -Value {
            "$($this.Name) $($this.Version)"
        }

        Write-Output $result
    }
}
