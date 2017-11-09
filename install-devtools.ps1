## Install common system admin and development tools using chocolatey.

# Function to determine if the current session has administrator privledges.
Function IsUserAdministrator
{
    $user = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $userPrincipal = new-object System.Security.Principal.WindowsPrincipal($user)
    $isAdmin = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    return $userPrincipal.IsInRole($isAdmin)
}

# Must run in elevated (admin) powershell session.
if (IsUserAdministrator)
{
    Write-Host -ForegroundColor:"green" "Running with Administrator permissions - proceeding to install dev tools on this machine."
}
else
{
    Write-Host -ForegroundColor:"red" "Must run this script with Administrator permissions."
    return
}

choco install sysinternals 7zip curl git notepadplusplus putty

choco install -ia "INSTALLDIR=""C:\java\jdk8""" jdk8
# Install Maven after JDK so that is finds JAVA_HOME correctly.
choco install maven

refreshenv

choco list -lo
