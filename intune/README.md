# Intune Configuration Overview

## Purpose
This section documents the Microsoft Intune configurations used to manage, secure, and monitor enterprise Windows endpoints.

---

## Core Responsibilities
- Device enrollment and onboarding
- Security compliance enforcement
- Configuration profile management
- Application deployment
- Endpoint troubleshooting

---

## Enrollment
- Windows Autopilot (User-Driven)
- Azure AD Join with automatic MDM enrollment
- Enrollment Status Page (ESP) for required apps

---

## Compliance Policies
Devices must meet security requirements to be considered compliant.

### Controls
- BitLocker enabled
- Microsoft Defender Antivirus enabled
- Supported OS version
- Secure Boot enabled

Compliance state is integrated with Conditional Access policies.

---

## Configuration Profiles
- Windows security baselines
- BitLocker configuration profiles
- Defender Antivirus configuration
