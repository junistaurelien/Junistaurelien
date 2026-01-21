<#
.SYNOPSIS
    (The Kerberos v5 authentication protocol is the default for authentication of users who are logging on to domain accounts. NTLM, which is less secure, is retained in later Windows versions for compatibility with clients and servers that are running earlier versions of Windows or applications that still use it. ) 

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-SO-000205)

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
Remediation: WN10-SO-000205
Setting: LAN Manager authentication level
Registry: HKLM\SYSTEM\CurrentControlSet\Control\Lsa\LmCompatibilityLevel (DWORD) = 5
#>

#Requires -RunAsAdministrator

$RegPath   = 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa'
$ValueName = 'LmCompatibilityLevel'
$Desired   = 5

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
        Write-Host "[NOTE] A reboot is not usually required, but a restart of affected services or a reboot ensures policy is fully applied."
        exit 0
    } else {
        throw "Verification failed. Current value: $verify"
    }
}
catch {
    Write-Error $_
    exit 1
}
