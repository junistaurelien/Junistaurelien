<#
# WN10-CC-000185 — Default behavior for AutoRun must be set to "Do not execute any autorun commands" 

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000185)

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>
# WN10-CC-000185 — Default behavior for AutoRun must be set to "Do not execute any autorun commands"
# Requires: Local admin
# Sets:
#   HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer
#   NoAutorun (REG_DWORD) = 1  (Do not execute any autorun commands)

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }

New-ItemProperty -Path $regPath -Name "NoAutorun" -PropertyType DWord -Value 1 -Force | Out-Null

# Verify
(Get-ItemProperty -Path $regPath -Name "NoAutorun").NoAutorun
