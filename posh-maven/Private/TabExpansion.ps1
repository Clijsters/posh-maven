[String[]]$goals = @(
    "-Dmaven.test.skip=true",
    "-DskipTests",
    "-DskipITs",
    "-Dtest",
    "-Dit.test",
    "-DfailIfNoTests",
    "-Dmaven.surefire.debug",
    "-DenableCiProfile",
    "-Dpmd.skip=true",
    "-Dcheckstyle.skip=true",
    "-Dtycho.mode=maven",
    "-Dmaven.javadoc.skip=true",
    "-Dgwt.compiler.skip",
    "-Dcobertura.skip=true",
    "-Dfindbugs.skip=true",
    "-DperformRelease=true",
    "-Dgpg.skip=true",
    "-DforkCount"
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
    "release",
    # # # # # # # # # # # # # #
    "-am",
    "-amd",
    "-B",
    "-C",
    "-c",
    "-cpu",
    "-D",
    "-e",
    "-emp",
    "-ep",
    "-f",
    "-fae",
    "-ff",
    "-fn",
    "-gs",
    "-h",
    "-l",
    "-N",
    "-npr",
    "-npu",
    "-nsu",
    "-o",
    "-P",
    "-pl",
    "-q",
    "-rf",
    "-s",
    "-T",
    "-t",
    "-U",
    "-up",
    "-V",
    "-v",
    "-X"
) | Sort-Object

$completeMap = @{
    android        = @("apk", "apklib", "clean", "deploy", "deploy-dependencies", "dex", "emulator-start", "emulator-stop", "emulator-stop-all", "generate-sources", "help", "instrument", "manifest-update", "pull", "push", "redeploy", "run", "undeploy", "unpack", "version-update", "zipalign", "devices");
    appengine      = @("backends_configure", "backends_delete", "backends_rollback", "backends_start", "backends_stop", "backends_update", "debug", "devserver", "devserver_start", "devserver_stop", "endpoints_get_client_lib", "endpoints_get_discovery_doc", "enhance", "rollback", "set_default_version", "start_module_version", "stop_module_version", "update", "update_cron", "update_dos", "update_indexes", "update_queues", "vacuum_indexes");
    dependency     = @("analyze", "analyze-dep-mgt", "analyze-duplicate", "analyze-only", "analyze-report", "build-classpath", "copy", "copy-dependencies", "get", "go-offline", "help", "list", "list-repositories", "properties", "purge-local-repository", "resolve", "resolve-plugins", "sources", "tree", "unpack", "unpack-dependencies");
    "build-helper" = @("add-resource", "add-source", "add-test-resource", "add-test-source", "attach-artifact", "bsh-property", "cpu-count", "help", "local-ip", "maven-version", "parse-version", "regex-properties", "regex-property", "released-version", "remove-project-artifact", "reserve-network-port", "timestamp-property");
    grails         = @("clean", "config-directories", "console", "create-controller", "create-domain-class", "create-integration-test", "create-pom", "create-script", "create-service", "create-tag-lib", "create-unit-test", "exec", "generate-all", "generate-controller", "generate-views", "help", "init", "init-plugin", "install-templates", "list-plugins", "maven-clean", "maven-compile", "maven-functional-test", "maven-grails-app-war", "maven-test", "maven-war", "package", "package-plugin", "run-app", "run-app-https", "run-war", "set-version", "test-app", "upgrade", "validate", "validate-plugin", "war")
    gwt            = @("browser", "clean", "compile", "compile-report", "css", "debug", "eclipse", "eclipseTest", "generateAsync", "help", "i18n", "mergewebxml", "resources", "run", "run-codeserver", "sdkInstall", "source-jar", "soyc", "test")
    versions       = @("display-dependency-updates", "display-plugin-updates", "display-property-updates", "update-parent", "update-properties", "update-child-modules", "lock-snapshots", "unlock-snapshots", "resolve-ranges", "set", "use-releases", "use-next-releases", "use-latest-releases", "use-next-snapshots", "use-latest-snapshots", "use-next-versions", "use-latest-versions", "commit", "revert")
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
