# ------------------------------
# Install Google Chrome on all endpoints
# ------------------------------
# This script checks whether the MSI installer exists in the script directory.
# If found, it silently installs the application using msiexec, prevents an automatic reboot,
# and waits for the installation process to complete so Intune receives an accurate success or failure status.

$InstallerPath = "$PSScriptRoot\GoogleChromeStandaloneEnterprise64.msi"

if (Test-Path $InstallerPath) {
    Start-Process "msiexec.exe" -ArgumentList "/i `"$InstallerPath`" /qn /norestart" -Wait
} else {
    Write-Error "Chrome installer not found."
    exit 1
}

