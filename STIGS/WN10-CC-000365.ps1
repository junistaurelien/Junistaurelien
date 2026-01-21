<#

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000365 )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
# WN10-CC-000365 — Prevent Windows apps from being activated by voice while the system is locked
# Requires: Local admin
# Sets:
#   HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy
#   LetAppsActivateWithVoiceAboveLock (REG_DWORD) = 2  (Force Deny)

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }

New-ItemProperty -Path $regPath -Name "LetAppsActivateWithVoiceAboveLock" -PropertyType DWord -Value 2 -Force | Out-Null

# Verify
(Get-ItemProperty -Path $regPath -Name "LetAppsActivateWithVoiceAboveLock").LetAppsActivateWithVoiceAboveLock
