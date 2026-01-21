<#
.SYNOPSIS
    (Prevent users from changing Windows Installer options (EnableUserControl=0) 

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000310)

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>


# YOUR CODE GOES HERE WN10-CC-000310
#Requires -RunAsAdministrator
$path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'
$name = 'EnableUserControl'
$value = 0
if (-not (Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
New-ItemProperty -Path $path -Name $name -PropertyType DWord -Value $value -Force | Out-Null
