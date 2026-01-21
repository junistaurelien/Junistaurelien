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
    STIG-ID         : (WN10-00-000032)

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
# WN10-00-000032 — BitLocker must be configured to require a PIN (pre-boot) with minimum length 6
# Requires: Local admin + BitLocker feature available
# Sets policy keys:
#   HKLM\SOFTWARE\Policies\Microsoft\FVE
#   UseAdvancedStartup (REG_DWORD) = 1
#   UseTPMPIN (REG_DWORD)          = 1
#   MinimumPIN (REG_DWORD)         = 6
#
# Notes:
# - This configures policy requirements; it does NOT automatically encrypt the OS drive.
# - To actually enable BitLocker with a TPM+PIN protector, use Enable-BitLocker after policy is applied.

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\FVE"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }

New-ItemProperty -Path $regPath -Name "UseAdvancedStartup" -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $regPath -Name "UseTPMPIN"          -PropertyType DWord -Value 1 -Force | Out-Null
New-ItemProperty -Path $regPath -Name "MinimumPIN"         -PropertyType DWord -Value 6 -Force | Out-Null

# Verify
Get-ItemProperty -Path $regPath | Select-Object UseAdvancedStartup,UseTPMPIN,MinimumPIN
