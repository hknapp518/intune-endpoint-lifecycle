# I modified the script to send BitLocker compliance data to Azure Log Analytics using the HTTP Data Collector API, 
# allowing centralized reporting, KQL queries, and integration with Sentinel instead of storing results locally.

# ==============================
$WorkspaceId = "<YOUR_WORKSPACE_ID>"
$SharedKey   = "<YOUR_SHARED_KEY>"
$LogType     = "BitLockerAudit"

# ==============================
# Function: Build Signature
# ==============================
Function Build-Signature {
    param (
        [string]$WorkspaceId,
        [string]$SharedKey,
        [string]$Date,
        [int]$ContentLength,
        [string]$Method,
        [string]$ContentType,
        [string]$Resource
    )

    $StringToHash = "$Method`n$ContentLength`n$ContentType`n$x-ms-date:$Date`n$Resource"
    $BytesToHash  = [Text.Encoding]::UTF8.GetBytes($StringToHash)
    $KeyBytes     = [Convert]::FromBase64String($SharedKey)

    $HMACSHA256 = New-Object System.Security.Cryptography.HMACSHA256
    $HMACSHA256.Key = $KeyBytes

    $HashedBytes = $HMACSHA256.ComputeHash($BytesToHash)
    $Signature   = [Convert]::ToBase64String($HashedBytes)

    return "SharedKey $WorkspaceId:$Signature"
}

# ==============================
# Collect BitLocker Data
# ==============================
$Drives = Get-BitLockerVolume
$TPMPresent = if (Get-WmiObject -Namespace "Root\CIMv2\Security\MicrosoftTpm" -Class Win32_Tpm -ErrorAction SilentlyContinue) { $true } else { $false }

$Report = foreach ($Drive in $Drives) {

    $RecoveryKey = $Drive.KeyProtector |
        Where-Object { $_.KeyProtectorType -eq 'RecoveryPassword' } |
        Select-Object -ExpandProperty RecoveryPassword -ErrorAction SilentlyContinue

    [PSCustomObject]@{
        ComputerName       = $env:COMPUTERNAME
        Drive              = $Drive.MountPoint
        VolumeStatus       = $Drive.VolumeStatus
        ProtectionStatus   = $Drive.ProtectionStatus
        EncryptionMethod   = $Drive.EncryptionMethod
        TPMPresent         = $TPMPresent
        RecoveryKeyExists  = [bool]$RecoveryKey
        TimeCollected      = (Get-Date).ToUniversalTime()
    }
}

# Convert to JSON
$JsonBody = $Report | ConvertTo-Json -Depth 5

# ==============================
# Send to Log Analytics
# ==============================
$Method = "POST"
$ContentType = "application/json"
$Resource = "/api/logs"
$Date = (Get-Date).ToUniversalTime().ToString("r")
$ContentLength = $JsonBody.Length

$Signature = Build-Signature `
    -WorkspaceId $WorkspaceId `
    -SharedKey $SharedKey `
    -Date $Date `
    -ContentLength $ContentLength `
    -Method $Method `
    -ContentType $ContentType `
    -Resource $Resource

$Headers = @{
    "Authorization" = $Signature
    "Log-Type"      = $LogType
    "x-ms-date"     = $Date
}

$Uri = "https://$WorkspaceId.ods.opinsights.azure.com$Resource?api-version=2016-04-01"

Invoke-RestMethod -Method $Method -Uri $Uri -Headers $Headers -Body $JsonBody -ContentType $ContentType
