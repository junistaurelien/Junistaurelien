<#
WN10-CC-000050 — Hardened UNC Paths must be defined for NETLOGON and SYSVOL
   

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000050  )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>
# WN10-CC-000050 — Hardened UNC Paths must be defined for NETLOGON and SYSVOL
# Requires: Local admin
# Sets:
#   HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths
#   \\*\NETLOGON and \\*\SYSVOL => RequireMutualAuthentication=1; RequireIntegrity=1

$basePath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths"
if (-not (Test-Path $basePath)) { New-Item -Path $basePath -Force | Out-Null }

New-ItemProperty -Path $basePath -Name "\\*\NETLOGON" -PropertyType String -Value "RequireMutualAuthentication=1, RequireIntegrity=1" -Force | Out-Null
New-ItemProperty -Path $basePath -Name "\\*\SYSVOL"   -PropertyType String -Value "RequireMutualAuthentication=1, RequireIntegrity=1" -Force | Out-Null

# Verify
Get-ItemProperty -Path $basePath | Select-Object "\\*\NETLOGON","\\*\SYSVOL"

