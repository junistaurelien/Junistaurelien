<#
.SYNOPSIS
    (Allowing ICMP redirect of routes can lead to traffic not being routed properly. When disabled, this forces ICMP to be routed via shortest path first. ) 

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000030 )

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#>

# WN10-CC-000030 
<#
Remediation: WN10-CC-000030
Requirement: Prevent ICMP redirects from overriding routes
Registry: HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\EnableICMPRedirect (DWORD) = 0
#>

#Requires -RunAsAdministrator

$RegPath  = 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters'
$ValueName = 'EnableICMPRedirect'
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
    if (-not (Test-Path -Path $RegPath)) {
        throw "Registry path not found: $RegPath"
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
        exit 0
    } else {
        throw "Verification failed. Current value: $verify"
    }
}
catch {
    Write-Error $_
    exit 1
}
