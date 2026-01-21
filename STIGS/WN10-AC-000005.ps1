<#
Account lockout duration must be configured to 15 minutes or greater
   

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-AC-000005  )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>


# WN10-AC-000005 — Account lockout duration must be configured to 15 minutes or greater
# Requires: Local admin
# Notes: This sets the lockout duration only. Ensure your lockout threshold/window are also STIG-compliant.

# 1) Set Account Lockout Duration to 15 minutes
net accounts /lockoutduration:15

# 2) Verify
net accounts | findstr /i "Lockout duration"
