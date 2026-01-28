#This script uses PowerShell and Common Information Model CIM to collect standardized hardware metadata device name, 
#manufacturer, model, and serial number which can be used for asset tracking, lifecycle planning, and reporting within Intune.

# Get-HardwareInventory.ps1
# Collects basic hardware information for lifecycle tracking

$ComputerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
$BIOS = Get-CimInstance -ClassName Win32_BIOS

$HardwareInventory = [PSCustomObject]@{
    DeviceName    = $env:COMPUTERNAME
    Manufacturer  = $ComputerSystem.Manufacturer
    Model         = $ComputerSystem.Model
    SerialNumber  = $BIOS.SerialNumber
    CollectedDate = (Get-Date).ToString("yyyy-MM-dd")
}

$HardwareInventory

 
