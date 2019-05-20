# ![alt](doc/logo.png) posh-maven

A PowerShell helper module for mvn.

[![Build status for master][AppVeyorMasterImage]][AppVeyorMasterLink]
[![Build status for develop][AppVeyorDevelopImage]][AppVeyorDevelopLink]
[![codecov Code Coverage][CodecovImage]][CodecovLink]

posh-maven adds autocomplete features and several helper functions for your day2day usage of maven to your PowerShell environment.

It automatically scans your `$pwd` for pom files and lists its name and version.

Along with [posh-git][posh-git] it may look as follows:

![PS ~/Dev/repos/powershell-tipps-de \[de.clijsters.powershell-tipps-de 0.1.999-SNAPSHOT\] \[F-CMS ≡ +1 ~2 -0 !\]>](doc/prompt-preview.png)

## Project status

This project is in an early beta stadium. It currently supports:

* Tab completion on mvn goals
* Showing the current maven project and version in prompt
* Getting some basic information from POM.xml

[AppVeyorMasterImage]: https://ci.appveyor.com/api/projects/status/c6u0f4gk3ibxwa46/branch/master?svg=true&passingText=master%20-%20OK&pendingText=master%20-%20Pending&failingText=master%20-%20Failing
[AppVeyorMasterLink]: https://ci.appveyor.com/project/Clijsters/posh-maven/branch/master
[AppVeyorDevelopImage]: https://ci.appveyor.com/api/projects/status/c6u0f4gk3ibxwa46/branch/develop?svg=true&passingText=develop%20-%20OK&pendingText=develop%20-%20Pending&failingText=develop%20-%20Failing
[AppVeyorDevelopLink]: https://ci.appveyor.com/project/Clijsters/posh-maven/branch/develop
[CodecovImage]: https://codecov.io/gh/Clijsters/posh-maven/branch/develop/graph/badge.svg
[CodecovLink]: https://codecov.io/gh/Clijsters/posh-maven
[posh-git]: https://github.com/dahlbyk/posh-git
