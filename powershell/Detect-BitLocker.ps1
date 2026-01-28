#This PowerShell detection script checks whether BitLocker encryption is enabled on the system drive. 
#It queries the BitLocker status for the C: volume and evaluates the protection state. 
#If BitLocker is enabled, the script exits successfully, indicating the device is compliant. 
#If BitLocker is not enabled, it exits with a non-compliant status, which signals Intune to trigger a remediation action

# Detect-BitLocker.ps1
# Detection script for Intune Proactive Remediation

$BitLockerStatus = Get-BitLockerVolume -MountPoint "C:"

if ($BitLockerStatus.ProtectionStatus -eq 1) {
    Write-Output "BitLocker is enabled"
    exit 0
}
else {
    Write-Output "BitLocker is not enabled"
    exit 1
}
