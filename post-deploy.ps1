<#
    .SYNOPSIS
        Downloads and configures VSTS machine for POC
		This script is provided AS-IS and does not reflect recommended practices for secure environments
#>

# Disable IE ESC for Admins and Users
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0

# Enable ability to download files
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "1803" -Value 0

# Disable Protected mode in Internet Explorer
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" -Name "2500" -Value 3

# Create Folders
New-Item -ItemType Directory c:\POC
New-Item -ItemType Directory c:\temp

# Download ContosoExpenses Project
Invoke-WebRequest "https://fasttrackforazure.blob.core.windows.net/sourcecode/Contoso.Expenses.zip" -OutFile c:\temp\Contoso.Expenses.zip
Expand-Archive c:\temp\Contoso.Expenses.zip c:\POC

# Download & Install Storage Explorer
Invoke-WebRequest "https://go.microsoft.com/fwlink/?LinkId=708343&clcid=0x409" -OutFile c:\temp\StorageExplorer.exe
c:\temp\StorageExplorer.exe /VerySilent /Log=c:\temp\StorageExplorer.txt