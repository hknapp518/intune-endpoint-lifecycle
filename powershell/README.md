# PowerShell Automation & Remediation

## Purpose
This section outlines how PowerShell is used to automate endpoint management tasks and enforce security posture through Microsoft Intune.

---

## Proactive Remediation
Proactive Remediation scripts are used to detect and automatically correct configuration issues on endpoints.

### Structure
- Detection Script: Identifies non-compliant states
- Remediation Script: Applies corrective action

### Example Scenario
**BitLocker Enforcement**
- Detection: Check BitLocker protection status
- Remediation: Enable BitLocker if not enabled

---

## Additional Automation Use Cases
- Hardware inventory collection
- Compliance reporting
- Configuration drift remediation

---

## Value
Automation reduces manual intervention, improves consistency, and supports proactive endpoint health management.
