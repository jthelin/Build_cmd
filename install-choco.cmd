@REM install-choco.cmd
@REM
@REM See also:
@REM https://chocolatey.org/install
@REM https://chocolatey.org/docs/installation

setx ChocolateyInstall C:\DevTools\Chocolatey
setx ChocolateyToolsLocation C:\DevTools

%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://chocolatey.org/install.ps1','%ChocolateyToolsLocation%\install-choco.ps1'))"

%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%ChocolateyToolsLocation%\install-choco.ps1' %*"

SET PATH=%ChocolateyInstall%\bin;%PATH%
