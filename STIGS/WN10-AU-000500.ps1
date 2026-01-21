<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : linkedin.com/in/Junistaurelien/
    GitHub          : github.com/joshmadakor1
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE

# Sets:
# HKLM\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Application
#   MaxSize (DWORD) = 0x00008000

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Eventlog\Application"
$name    = "MaxSize"
$value   = 0x00008000  # 32768 decimal

# Create the key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Create/update the DWORD value
New-ItemProperty -Path $regPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

# Verify
(Get-ItemProperty -Path $regPath -Name $name).$name | ForEach-Object {
    [pscustomobject]@{
        RegistryPath = $regPath
        Name         = $name
        ValueDecimal = $_
        ValueHex     = ('0x{0:X8}' -f $_)
    }
}
