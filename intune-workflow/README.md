# Intune Proactive Remediation Workflow

## Purpose
This document explains how the BitLocker detection and remediation scripts are implemented in Microsoft Intune Proactive Remediations.

---

## Workflow Steps

1. **Detection Script**
   - `Detect-BitLocker.ps1` checks if BitLocker is enabled on the C: drive.
   - Returns exit code `0` (compliant) or `1` (non-compliant).

2. **Remediation Script**
   - `Remediate-BitLocker.ps1` runs only on non-compliant devices.
   - Enables BitLocker using TPM, encrypting only used space, and adds a recovery password.

3. **Intune Execution**
   # Intune Proactive Remediation Step-by-Step

This document explains how the BitLocker detection and remediation scripts are implemented in Microsoft Intune Proactive Remediations.

---

## Step-by-Step Implementation

### 1. Log in to Microsoft Endpoint Manager
- Go to [https://endpoint.microsoft.com](https://endpoint.microsoft.com)
- Sign in with an account that has **Intune admin** or **Endpoint Analytics** permissions.

### 2️. Navigate to Proactive Remediations
- In the left-hand menu:  
  `Reports → Endpoint Analytics → Proactive Remediations`  
  

### 3️. Create a new Script Package
- Click **+ Create Script Package**
- Fill in:
  - **Name**: `BitLocker Compliance Enforcement`
  - **Description**: `Detection and remediation scripts to ensure all Windows endpoints have BitLocker enabled using TPM and a recovery password.`
  - **Operating System**: Windows 10/11

### 4️. Upload Detection Script
- Upload `Detect-BitLocker.ps1` as the **Detection script**  
- Intune will run this first to check compliance on endpoints.

### 5️. Upload Remediation Script
- Upload `Remediate-BitLocker.ps1` as the **Remediation script**  
- This runs **only on devices flagged as non-compliant**.

### 6️. Assign the Script to Devices
- Click **Assignments**  
- Select the **device group** to target (e.g., test devices or all Windows 10/11 endpoints)  
- Save and apply.

### 7️. Monitor Results
- Go to **Proactive Remediations → Results**
- Intune will show:
  - **Compliant devices** → no action needed  
  - **Non-compliant devices** → remediation ran  
  - **Failures** → troubleshoot as needed

### 8️. Optional: Logging & Reporting
- Export results to CSV for audit purposes  
- Track which devices were remediated  
- Optionally, integrate with Power BI dashboards

---

## Why it matters
- Detection scripts evaluate endpoint compliance automatically  
- Non-compliant devices trigger remediation scripts automatically  
- All actions are logged for reporting and auditing  
- This ensures endpoint security without manual intervention


---

## Benefits
- Automated enforcement of endpoint security policies
- Minimal manual intervention
- Audit-ready reporting
