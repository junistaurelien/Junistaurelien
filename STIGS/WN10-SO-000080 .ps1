<#
.SYNOPSIS (Set legal banner title (LegalNoticeCaption = your title)
   

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-SO-000080 )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>


# WN10-SO-000080  
#Requires -RunAsAdministrator
$caption = 'DoD Notice and Consent Banner'   # <-- change if your org requires different title text
$path = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
$name = 'LegalNoticeCaption'
New-ItemProperty -Path $path -Name $name -PropertyType String -Value $caption -Force | Out-Null

