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
    STIG-ID         : (WN10-SO-000245)

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
# WN10-SO-000245 — UAC approval mode for the built-in Administrator must be enabled
# Requires: Local admin
# Sets:
#   HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
#   FilterAdministratorToken (REG_DWORD) = 1

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
New-ItemProperty -Path $regPath -Name "FilterAdministratorToken" -PropertyType DWord -Value 1 -Force | Out-Null

# Verify
(Get-ItemProperty -Path $regPath -Name "FilterAdministratorToken").FilterAdministratorToken
