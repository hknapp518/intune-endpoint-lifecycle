# Detect if Google Chrome is installed on all endpoints

# Checks if Chrome is already installed by looking for the main executable.
# Exit code 0 = installed, exit code 1 = not installed.
# Prevents unnecessary reinstalls and helps Intune track app deployment status.

$ChromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"

if (Test-Path $ChromePath) {
    # Chrome is installed
    exit 0
} else {
    # Chrome is not installed
    exit 1
}
