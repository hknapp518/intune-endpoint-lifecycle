# Uninstall Google Chrome on all endpoints

# Checks if Google Chrome is installed via MSI.
# If found, it silently uninstalls the app so Intune can track success/failure.
# If not found, it exits cleanly to avoid false errors.

$App = Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -like "Google Chrome*"
}

if ($App) {
    $App.Uninstall()
} else {
    Write-Output "Google Chrome not found."
}
