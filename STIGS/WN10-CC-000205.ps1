#
.SYNOPSIS
    (Some features may communicate with the vendor, sending system information or downloading data or components for the feature. Limiting this capability will prevent potentially sensitive information from being sent outside the enterprise) 

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000205)

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
Remediation: WN10-CC-000205
Rule: Windows Telemetry must not be configured to Full
Registry: HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry (DWORD)

Allowed STIG values:
0 = Security (Enterprise only)
1 = Basic
2 = Enhanced (allowed only in specific cases with additional STIG setting)
#>

#Requires -RunAsAdministrator

param(
    [ValidateSet(0,1,2)]
    [int]$AllowTelemetry = 1
)

$RegPath   = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
$ValueName = 'AllowTelemetry'

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
        New-ItemProperty -Path $RegPath -Name $ValueName -PropertyType DWord -Value $AllowTelemetry -Force | Out-Null
        Write-Host "[FIXED] Created $ValueName and set to $AllowTelemetry at $RegPath"
    }
    elseif ($current -ne $AllowTelemetry) {
        Set-ItemProperty -Path $RegPath -Name $ValueName -Value $AllowTelemetry -Force
        Write-Host "[FIXED] Updated $ValueName from $current to $AllowTelemetry at $RegPath"
    }
    else {
        Write-Host "[OK] $ValueName already set to $AllowTelemetry at $RegPath"
    }

    # Verify
    $verify = Get-RegDwordValue -Path $RegPath -Name $ValueName
    if ($verify -in 0,1,2) {
        Write-Host "[VERIFIED] STIG-acceptable: $ValueName = $verify"
        exit 0
    } else {
        throw "Verification failed. Value is not STIG-acceptable (0/1/2). Current value: $verify"
    }
}
catch {
    Write-Error $_
    exit 1
}


