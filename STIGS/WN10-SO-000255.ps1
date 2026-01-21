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
    STIG-ID         : (WN10-SO-000255

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
# WN10-SO-000255 — UAC must automatically deny elevation requests for standard users
# Requires: Local admin
# Sets:
#   HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
#   ConsentPromptBehaviorUser (REG_DWORD) = 0  (Automatically deny elevation requests)

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
New-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorUser" -PropertyType DWord -Value 0 -Force | Out-Null

# Verify
(Get-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorUser").ConsentPromptBehaviorUser
