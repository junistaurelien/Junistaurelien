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
    STIG-ID         : (WN10-SO-000100)

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
# WN10-SO-000100 — SMB client must always digitally sign communications
# Requires: Local admin
# Sets:
#   HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters
#   RequireSecuritySignature = 1
#   EnableSecuritySignature  = 1

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
New-ItemProperty -Path $regPath -Name "RequireSecuritySignature" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $regPath -Name "EnableSecuritySignature"  -PropertyType DWord -Value 1 -Force | Out-Null

# Verify
Get-ItemProperty -Path $regPath | Select-Object RequireSecuritySignature,EnableSecuritySignature
