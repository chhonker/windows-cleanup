Windows Update Cleanup and Pause Script
This repository contains a simple, yet powerful, batch script designed to manage your Windows Update files and services. The script performs three key actions:

Stops core Windows Update services.

Deletes the temporary files and cached updates to free up disk space.

Pauses future Windows Updates for a period of 4 weeks (28 days).

This tool is particularly useful for users who need to quickly reclaim disk space on their system or who want to temporarily delay an update.

⚠️ Important Disclaimers
Administrator Privileges: This script requires administrator privileges to run correctly. The commands to stop services and delete files in system directories will not work otherwise.

Use with Caution: While the script is designed to be safe, it modifies system directories and services. Use it at your own risk. Always ensure you have a backup of your important files.

Windows Update Behavior: The script permanently deletes the Windows Update download cache and the update history. Your update history will be empty after running this script, and Windows will rebuild it over time.

Third-Party Executables: The original batch script is provided. Creating an executable from this script is not recommended due to potential false positives from antivirus software, which may flag the file as malicious due to its system-level actions.

How to Use
Download the Script: Clone or download the entire repository to your local machine, or simply copy the code from cleanup_script.bat into a new file on your computer.

Save the File: Save the file with a .bat extension, for example, windows_cleanup.bat.

Run as Administrator:

Right-click on the windows_cleanup.bat file.

Select "Run as administrator."

Confirm the User Account Control (UAC) prompt to allow the script to make changes to your system.

The script will then run automatically in the Command Prompt window, providing step-by-step feedback.

Script Contents
This is the batch script (cleanup_script.bat) contained within this repository.

@echo off
echo ===============================================
echo     Clearing Downloaded Windows Update Files...
echo ===============================================
echo.

:: Step 1: Stop Windows Update Services
echo Stopping Windows Update Services...
net stop wuauserv
net stop bits
net stop cryptsvc

:: Step 2: Delete Update Cache
echo Deleting cached update files...
rd /s /q %windir%\SoftwareDistribution\Download
rd /s /q %windir%\SoftwareDistribution\DataStore
rd /s /q %windir%\System32\catroot2

:: Step 3: Restart Services (Commented Out)
:: echo Restarting Windows Update Services...
:: net start wuauserv
:: net start bits
:: net start cryptsvc

:: Step 4: Pause Updates for 4 Weeks (28 days)
echo Pausing Windows Updates for 4 weeks...
powershell -Command "Set-Service -Name wuauserv -StartupType Manual"
powershell -Command "(New-Object -ComObject Microsoft.Update.ServiceManager).ClientApplicationID = 'ClearUpdateScript'"
powershell -Command "Invoke-WebRequest -UseBasicParsing 'about:blank' > $null" 2>nul
powershell -Command "(New-Object -ComObject Microsoft.Update.AutoUpdate).PauseAutomaticUpdates([datetime]::Now.AddDays(28))"

echo.
echo ===============================================
echo     Windows Update Cache Cleared
echo     Updates Paused for 4 Weeks
echo     Services Remain Stopped
echo ===============================================
pause
