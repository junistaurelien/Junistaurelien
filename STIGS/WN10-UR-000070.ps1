<#
.SYNOPSIS
    (Ignore NetBIOS name release requests except from WINS) 

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-UR-000070 )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>

WN10-UR-000070 was remediated by denying network logon access to the BUILTIN\Guests group via local security policy.

# YOUR CODE GOES HERE
#Requires -RunAsAdministrator
$cs = Get-CimInstance Win32_ComputerSystem
$targets = @('Guests')   # all systems

# Domain systems only additions
if ($cs.PartOfDomain) {
    $targets += @('Domain Admins', 'Enterprise Admins', 'LOCAL ACCOUNT')  # "Local account" group
}

function Resolve-SidOrName([string]$acct) {
    try { return (New-Object System.Security.Principal.NTAccount($acct)).Translate([System.Security.Principal.SecurityIdentifier]).Value }
    catch { return $acct } # fall back to name if SID translation fails
}

# Build INF with SeDenyNetworkLogonRight
$sidsOrNames = $targets | ForEach-Object { Resolve-SidOrName $_ }
$denyList  = $sidsOrNames | ForEach-Object { "*$_" }
$rightLine = 'SeDenyNetworkLogonRight = ' + ($denyList -join ',')


$tmp = Join-Path $env:TEMP "WN10-UR-000070.inf"
@"
[Version]
signature=`"`$CHICAGO`"`
Revision=1

[Privilege Rights]
$rightLine
"@ | Set-Content -Path $tmp -Encoding ASCII

secedit /configure /db "$env:TEMP\secedit.sdb" /cfg "$tmp" /areas USER_RIGHTS | Out-Null


secedit /export /cfg "$env:TEMP\secpol.cfg" | Out-Null
(gc "$env:TEMP\secpol.cfg") `
  -replace '^SeDenyNetworkLogonRight.*','SeDenyNetworkLogonRight = *S-1-5-32-546' |
  Out-File "$env:TEMP\secpol_fixed.cfg" -Encoding ASCII

secedit /configure /db "$env:TEMP\secedit.sdb" /cfg "$env:TEMP\secpol_fixed.cfg" /areas USER_RIGHTS | Out-Null
