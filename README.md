# Intune Endpoint Management Lab

**Purpose**  
This project demonstrates an end-to-end Microsoft Intune endpoint management workflow, covering endpoint compliance, Win32 application deployment, proactive remediation, hardware lifecycle tracking, versioning, and reporting automation. It is designed to showcase real-world Intune skills, PowerShell automation, Autopilot integration, and enterprise endpoint management best practices.

---

## Project Structure

intune-workflow/  
 bitlocker/  
  `Detect-BitLocker.ps1`  
  `Remediate-BitLocker.ps1`  
 app-deployment/  
  chrome-win32/  
   `install.ps1`  
   `uninstall.ps1`  
   `detection.ps1`  
   `README.md`  
 hardware-audit/  
  `Collect-HardwareInfo.ps1`  
  `Report-HardwareLifecycle.ps1`  
 versioning/  
  `Collect-AppVersions.ps1`  
 reports/  
  Sample CSVs and Power BI dashboards  



##  Workflow Overview

### 1. BitLocker Compliance
- **Detection Script:** Checks if BitLocker is enabled on the C: drive.  
  - Exit codes:
    - `0` → Compliant  
    - `1` → Non-compliant
- **Remediation Script:** Enables BitLocker using TPM, encrypts only used space, and generates a recovery password.
- **Intune Execution:** Runs via **Proactive Remediations**.
- **Outcome:** Ensures automated compliance with endpoint security policies, fully logged for auditing.

---

### 2. Win32 Application Deployment (Google Chrome Example)
- **Install Script (`install.ps1`)** – Silently installs Chrome via MSI; prevents reboot and waits for completion.  
- **Detection Script (`detection.ps1`)** – Checks if Chrome executable exists; exit codes:
  - `0` → Installed  
  - `1` → Needs install
- **Uninstall Script (`uninstall.ps1`)** – Removes Chrome silently if present.
- **Version Awareness:** Detects outdated versions and triggers update if needed.
- **Intune Role:** Demonstrates **Install → Detection → Uninstall cycle** for enterprise app deployment.

---

### 3. Hardware Lifecycle & Audit
- **Collect-HardwareInfo.ps1** – Gathers manufacturer, model, BIOS version, serial number, CPU, RAM, storage, and TPM status.
- **Report-HardwareLifecycle.ps1** – Generates centralized CSV for tracking hardware, evaluating refresh needs, and monitoring EOL timelines.
- **Benefit:** Supports enterprise hardware lifecycle planning and vendor management.

---

### 4. Application Versioning
- **Collect-AppVersions.ps1** – Tracks versions of key enterprise apps (Chrome, Edge, Office, etc.).
- **Benefit:** Supports proactive updates and compliance reporting.
- **Integration:** CSVs can be fed into Power BI dashboards for visual reporting.

---

### 5. Proactive Remediation & Automation
- Combines detection, remediation, and reporting across endpoints.
- Demonstrates:
  - Compliance enforcement
  - App lifecycle management
  - Hardware and software lifecycle tracking
- Automates tasks with PowerShell, ensuring **idempotency, reliability, and SYSTEM-context execution**.

---

### 6. Visual Workflow Diagram

```text
      +----------------+
      | Device Endpoint|
      +----------------+
              |
       [Detection Script]
              |
       +-------------+
       | Is Compliant?|
       +-------------+
        |           |
       Yes          No
        |           |
    No Action   [Remediation Script]
        |
[App Deployment Workflow]
  Install → Detection → Uninstall
        |
[Hardware & Version Audit]
        |
   Reporting & Logs → CSV / Power BI

