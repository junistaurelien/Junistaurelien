<#
WN10-CC-000052 — ECC curves must be configured to prioritize longer key lengths first

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000052 )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>
# WN10-CC-000052 — ECC curves must be configured to prioritize longer key lengths first
# Requires: Local admin
# Sets:
#   HKLM\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002
#   EccCurves (REG_MULTI_SZ) => NistP384, NistP256

$sslPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
if (-not (Test-Path $sslPath)) { New-Item -Path $sslPath -Force | Out-Null }

$curves = @("NistP384","NistP256")
New-ItemProperty -Path $sslPath -Name "EccCurves" -PropertyType MultiString -Value $curves -Force | Out-Null

# Verify
(Get-ItemProperty -Path $sslPath -Name "EccCurves").EccCurves
