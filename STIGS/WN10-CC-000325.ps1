<#
.SYNOPSIS(Disable automatic sign-in after restart)
   

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000325 )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>


# YOUR CODE GOES HERE WN10-CC-000325 
#Requires -RunAsAdministrator
$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$name = 'DisableAutomaticRestartSignOn'
$value = 1
New-ItemProperty -Path $path -Name $name -PropertyType DWord -Value $value -Force | Out-Null
