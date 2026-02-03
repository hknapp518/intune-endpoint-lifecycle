<#
.SYNOPSIS
Validates BitLocker configuration against expected Intune policy settings (report-only).

.DESCRIPTION
This script checks BitLocker encryption status, protection state, encryption method,
TPM availability, and recovery key presence. It reports findings but does not enforce
or fail compliance.

Designed for auditing, validation, and reporting use cases.
#>

$Volume = Get-BitLockerVolume -MountPoint "C:" -ErrorAction SilentlyContinue
$TPM = Get-WmiObject -Namespace "Root\CIMv2\Security\MicrosoftTpm" -Class Win32_Tpm -ErrorAction SilentlyContinue

if (-not $Volume) {
    Write-Output "BitLocker volume not found on C: drive."
    exit 0
}

$RecoveryKeyExists = $Volume.KeyProtector |
    Where-Object { $_.KeyProtectorType -eq "RecoveryPassword" }

$Report = [PSCustomObject]@{
    Drive              = "C:"
    VolumeStatus       = $Volume.VolumeStatus
    ProtectionStatus   = $Volume.ProtectionStatus
    EncryptionMethod   = $Volume.EncryptionMethod
    TPMPresent         = if ($TPM) { $true } else { $false }
    RecoveryKeyPresent = if ($RecoveryKeyExists) { $true } else { $false }
}

$Report | Format-List

Write-Output "BitLocker policy validation completed (report-only)."
exit 0
