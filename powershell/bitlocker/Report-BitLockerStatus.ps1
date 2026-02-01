<#
.SYNOPSIS
Collects BitLocker status for all drives on the endpoint and exports results to a CSV.

.DESCRIPTION
This script queries each drive for BitLocker encryption status, TPM presence, and recovery key escrow status.
It exports the results to a CSV in the current user's Documents folder for auditing or reporting purposes.

#>

# Define output CSV path
$CsvPath = "$env:USERPROFILE\Documents\BitLockerReport.csv"

# Collect BitLocker info for all drives
$Drives = Get-BitLockerVolume | Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionMethod, KeyProtector

# Build output array
$Report = @()

foreach ($Drive in $Drives) {
    $RecoveryKey = $Drive.KeyProtector | Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' } | Select-Object -ExpandProperty RecoveryPassword -ErrorAction SilentlyContinue

    $Report += [PSCustomObject]@{
        Drive             = $Drive.MountPoint
        VolumeStatus      = $Drive.VolumeStatus
        ProtectionStatus  = $Drive.ProtectionStatus
        EncryptionMethod  = $Drive.EncryptionMethod
        TPMPresent        = if ((Get-WmiObject -Namespace "Root\CIMv2\Security\MicrosoftTpm" -Class Win32_Tpm -ErrorAction SilentlyContinue)) { $true } else { $false }
        RecoveryKeyExists = if ($RecoveryKey) { $true } else { $false }
    }
}

# Export to CSV
$Report | Export-Csv -Path $CsvPath -NoTypeInformation -Force

Write-Output "BitLocker report exported to $CsvPath"
