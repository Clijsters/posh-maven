
[String[]]$goals = @(
    "validate",
    "initialize",
    "generate-sources",
    "process-sources",
    "generate-resources",
    "process-resources",
    "compile",
    "process-classes",
    "generate-test-sources",
    "process-test-sources",
    "generate-test-resources",
    "process-test-resources",
    "test-compile",
    "process-test-classes",
    "test",
    "prepare-package",
    "package",
    "pre-integration-test",
    "integration-test",
    "post-integration-test",
    "verify",
    "install",
    "deploy",
    "pre-clean",
    "clean",
    "post-clean",
    "pre-site",
    "site",
    "post-site",
    "site-deploy",
    "release"
) | Sort-Object

[String[]]$firstLevelProperties = @(
    "project",
    "settings",
    "env",
    "project"
) | Sort-Object

if (Test-Path Function:\TabExpansion) {
    Rename-Item Function:\TabExpansion OldTabExpansion
}

function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()

    if ($lastBlock -match "^(mvn) (.*)") {
        if ($lastWord -match "^-D.+") {
            $currentProperty = $lastWord -split "."
            $lastLvl = $currentProperty[$currentProperty.length - 1]

            if ($lastLvl -eq "") {
                return
            }
        }
        $goals -match "^$($lastWord)"
    }
    else {
        if (Test-Path Function:\OldTabExpansion) {
            OldTabExpansion $line $lastWord
        }
    }
}
