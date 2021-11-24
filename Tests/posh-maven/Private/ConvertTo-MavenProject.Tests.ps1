# Credit to header goes to replicaJunction
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = Split-Path -Leaf $MyInvocation.MyCommand.Path
. ("$here\$sut").Replace("\Tests\", "\").Replace(".Tests.", ".")

InModuleScope posh-maven {
    Describe "ConvertTo-MavenProject" {

        Context "Input parameters" {
            $sampleInput = @"
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1</version>
</project>
"@;

            It "Rejects inputs other than valid xml with project definition" {
                { ConvertTo-MavenProject -InputObject "asd" } | Should Throw
                { [xml]"<p></p>" | ConvertTo-MavenProject } | Should Throw "No project node in input xml"
            }
            It "Accepts XML input and converts it to a PSCustomObject" {
                { [xml]$sampleInput | ConvertTo-MavenProject } | Should Not Throw
                $result = [xml]$sampleInput | ConvertTo-MavenProject
                $result.GetType().Name | Should Be "PSCustomObject"
            }
            It "Returns an object of Type MavenProject" {
                $result = [xml]$sampleInput | ConvertTo-MavenProject
                $result.PSObject.TypeNames[0] | Should Be "posh-maven.MavenProject"
            }
            It "Creates empty properties field, even w/o properties section" {
                $result = [xml]$sampleInput | ConvertTo-MavenProject
                $result.properties.PSObject.TypeNames[0] | Should Be "posh-maven.MavenProject.MavenProperties"
                #$result.properties.PSObject.Members | Where-Object TypeNameOfValue -eq System.String | Should HaveCount 0
                ($result.properties.PSObject.Members | Where-Object TypeNameOfValue -eq System.String).Count | Should Be 0
            }
        }

        Context "Behavior" {

            $sampleInput = @"
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.mycompany.app</groupId>
    <artifactId>my-app</artifactId>
    <version>1</version>
    <properties>
        <first-property>Lorem Ipsum Dolor</first-property>
        <my-dependency.version>1.123.1-SNAPSHOT</my-dependency.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.apache.maven</groupId>
            <artifactId>maven-artifact</artifactId>
            <version>`${mavenVersion}</version>
        </dependency>
        <dependency>
            <groupId>org.apache.maven</groupId>
            <artifactId>maven-project</artifactId>
            <version>`${my-dependency.version}</version>
        </dependency>
    </dependencies>
</project>
"@
            It "Properly adds properties when given" {
                $result = [xml]$sampleInput | Convertto-mavenproject
                #$result.properties.PSObject.Members | Where-Object TypeNameOfValue -eq System.String | Should HaveCount 2
                ($result.properties.PSObject.Members | Where-Object TypeNameOfValue -eq System.String).Count | Should Be 2
                $result.properties.'first-property' | Should Be "Lorem Ipsum Dolor"
                $result.properties.'my-dependency.version' | Should Be "1.123.1-SNAPSHOT"
            }

            It "Properly adds Dependencies when given" {
                $result = [xml]$sampleInput | Convertto-mavenproject
                $result.dependencies.count | Should Be 2
            }
        }

    }
}
