
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

$completeMap = @{
    appengine = @(
        "backends_configure",
        "backends_delete",
        "backends_rollback",
        "backends_start",
        "backends_stop",
        "backends_update",
        "debug",
        "devserver",
        "devserver_start",
        "devserver_stop",
        "endpoints_get_client_lib",
        "endpoints_get_discovery_doc",
        "enhance",
        "rollback",
        "set_default_version",
        "start_module_version",
        "stop_module_version",
        "update",
        "update_cron",
        "update_dos",
        "update_indexes",
        "update_queues",
        "vacuum_indexes"
    );
    dependency = @(
        "analyze",
        "analyze-dep-mgt",
        "analyze-duplicate",
        "analyze-only",
        "analyze-report",
        "build-classpath",
        "copy",
        "copy-dependencies",
        "get",
        "go-offline",
        "help",
        "list",
        "list-repositories",
        "properties",
        "purge-local-repository",
        "resolve",
        "resolve-plugins",
        "sources",
        "tree",
        "unpack",
        "unpack-dependencies"
    )
} | Sort-Object

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
        $lvl = ($completeMap.keys -match "^$($lastWord)")
        if ($lvl.Count -gt 1) {
            $lvl
        }
        else {
            $completeMap."$lvl" | % { "$lvl`:$_" }
        }
        $goals -match "^$($lastWord)"
    }
    else {
        if (Test-Path Function:\OldTabExpansion) {
            OldTabExpansion $line $lastWord
        }
    }
}
