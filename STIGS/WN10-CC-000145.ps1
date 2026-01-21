<#
WN10-CC-000145 — Require password on resume from sleep (ON BATTERY)

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000145)

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>
## WN10-CC-000145 — Require password on resume from sleep (ON BATTERY)
# Requires: Local admin
# Policy writes to:
#   HKLM\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51
#   DCSettingIndex = 1

$psPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
if (-not (Test-Path $psPath)) { New-Item -Path $psPath -Force | Out-Null }

New-ItemProperty -Path $psPath -Name "DCSettingIndex" -PropertyType DWord -Value 1 -Force | Out-Null

# Verify
(Get-ItemProperty -Path $psPath -Name "DCSettingIndex").DCSettingIndex

