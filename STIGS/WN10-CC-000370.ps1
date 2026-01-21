<#
.SYNOPSIS
    (This policy controls whether a domain user can sign in using a convenience PIN to prevent enabling (Password Stuffer).
) 

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000370 )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>

# YOUR CODE GOES HERE
<#
<#
<#
Remediation: WN10-CC-000370
Rule: The convenience PIN for Windows 10 must be disabled.
Registry:
  HKLM\Software\Policies\Microsoft\Windows\System
  AllowDomainPINLogon (DWORD) = 0
#>

#Requires -RunAsAdministrator

$RegPath   = 'HKLM:\Software\Policies\Microsoft\Windows\System'
$ValueName = 'AllowDomainPINLogon'
$Desired   = 0

function Get-RegDwordValue {
    param(
        [Parameter(Mandatory)] [string] $Path,
        [Parameter(Mandatory)] [string] $Name
    )
    try {
        $item = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop
        return [int]$item.$Name
    } catch {
        return $null
    }
}

try {
    # Ensure key exists
    if (-not (Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
        Write-Host "[INFO] Created registry path: $RegPath"
    }

    $current = Get-RegDwordValue -Path $RegPath -Name $ValueName

    if ($null -eq $current) {
        New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWord -Value $Desired -Force | Out-Null
        Write-Host "[FIXED] Created $ValueName and set to $Desired at $RegPath"
    }
    elseif ($current -ne $Desired) {
        Set-ItemProperty -Path $RegPath -Name $ValueName -Value $Desired -Force
        Write-Host "[FIXED] Updated $ValueName from $current to $Desired at $RegPath"
    }
    else {
        Write-Host "[OK] $ValueName already set to $Desired at $RegPath"
    }

    # Verify
    $verify = Get-RegDwordValue -Path $RegPath -Name $ValueName
    if ($verify -eq $Desired) {
        Write-Host "[VERIFIED] Compliant: $ValueName = $verify"
        Write-Host "[NOTE] Run 'gpupdate /force' or reboot if your scanner doesn't immediately reflect the change."
        exit 0
    } else {
        throw "Verification failed. Current value: $verify"
    }
}
catch {
    Write-Error $_
    exit 1
}
