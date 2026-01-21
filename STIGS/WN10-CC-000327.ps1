<#

.NOTES
    Author          : Junist Aurelien
    LinkedIn        : www.linkedin.com/in/junist-aurelien-cysa-0b96141ab
    GitHub          : https://github.com/junistaurelien/
    Date Created    : 2026-1-21
    Last Modified   : 2026-1-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : (WN10-CC-000327)

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run Using PowerShell!
   
#># WN10-CC-000327 — PowerShell Transcription must be enabled


$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
$dir = "C:\PS_Transcripts"

# Create registry path
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Create transcript directory
if (-not (Test-Path $dir)) {
    New-Item -Path $dir -ItemType Directory -Force | Out-Null
}

# Set STIG-required values
New-ItemProperty -Path $regPath -Name "EnableTranscripting" `
    -PropertyType DWORD -Value 1 -Force | Out-Null

New-ItemProperty -Path $regPath -Name "EnableInvocationHeader" `
    -PropertyType DWORD -Value 1 -Force | Out-Null

New-ItemProperty -Path $regPath -Name "OutputDirectory" `
    -PropertyType String -Value $dir -Force | Out-Null

Write-Host "WN10-CC-000327 remediation applied successfully."
