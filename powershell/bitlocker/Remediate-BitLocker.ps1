#This remediation script enables BitLocker on non-compliant devices using TPM and a recovery password, and skips devices that are already protected. 
#Paired with a detection script, it automates endpoint compliance in Intune.

# Remediate-BitLocker.ps1
# Enables BitLocker on the system drive if it is not already enabled

$BitLockerStatus = Get-BitLockerVolume -MountPoint "C:"

if ($BitLockerStatus.ProtectionStatus -eq 0) {
    Write-Output "BitLocker is not enabled. Enabling now..."

    # Enable BitLocker with TPM and default recovery key
    Enable-BitLocker -MountPoint "C:" -TpmProtector -UsedSpaceOnly -RecoveryPasswordProtector

    Write-Output "BitLocker has been enabled."
}
else {
    Write-Output "BitLocker is already enabled. No action needed."
}
