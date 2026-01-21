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
    STIG-ID         : (WN10-CC-000360 )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
# WN10-CC-000360 — WinRM client must not use Digest authentication
# Requires: Local admin
# Sets:
#   HKLM\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client
#   AllowDigest (REG_DWORD) = 0

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }

New-ItemProperty -Path $regPath -Name "AllowDigest" -PropertyType DWord -Value 0 -Force | Out-Null

# Verify
(Get-ItemProperty -Path $regPath -Name "AllowDigest").AllowDigest
