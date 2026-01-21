<#
.SYNOPSIS
    (WinRM service must NOT store RunAs credentials (DisableRunAs=1)

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000355)

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>


# YOUR CODE GOES HERE WN10-CC-000355
#Requires -RunAsAdministrator
$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'
$name = 'DisableRunAs'
$value = 1
if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
New-ItemProperty -Path $path -Name $name -PropertyType DWord -Value $value -Force | Out-Null
$val = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -Name DisableRunAs -ErrorAction SilentlyContinue).DisableRunAs
if ($val -eq 1) { "PASS: DisableRunAs = 1" } else { "FAIL: DisableRunAs is $val (or missing)" }

