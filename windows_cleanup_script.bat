@echo off
:: Author: Sumit Singh Chhonker
:: Project: https://github.com/chhonker
echo ===============================================
echo     Author: Sumit Singh Chhonker | Project: https://github.com/chhonker 
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

:: Step 3: Restart Services | Comment this if you want to explicitly restart system
echo Restarting Windows Update Services...
net start wuauserv
net start bits
net start cryptsvc

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
