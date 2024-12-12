@ECHO OFF 

:: This script uses 7z to backup files, installation is required - http://www.7-zip.org/
:: Set backuppath to the directory you want to store your backups without an ending slash
:: Set scpath to the directory path of your StarCitizen directory without an ending slash
:: The latest version of this script is availabe at https://github.com/kgNatx/sc-maintenance-script

:: ==== SET THESE ==============================================================================
set backuppath="D:\SC-backups"
set scpath="D:\Roberts Space Industries\StarCitizen"
:: ==== SET THESE ==============================================================================

:BEGIN
cls
@ECHO ==========================================================================================
@ECHO =                              Star Citizen Client Maintenance                           =
@ECHO ==========================================================================================
@ECHO =                 1. Clear Star Citizen Shaders Directory                                =
@ECHO =                 2. Backup Star Citizen Keybinds and Custom Characters                  =
@ECHO =                 3. Copy Keybinds from LIVE to PTU and EPTU                             =
@ECHO =                 4. Quit                                                                =
@ECHO ==========================================================================================
@ECHO =  Remember to save your keybinds to a profile ingame, and reload them after copying.    =
@ECHO =  This script uses 7z to backup files, installation is required - http://www.7-zip.org/ =
@ECHO =  Also, you must configure the path variables in the script to your specific locations. =
@ECHO ==========================================================================================
CHOICE /C:1234 %1
goto sub_%ERRORLEVEL%
GOTO END
:sub_1
@ECHO ==========================================================================================
@ECHO Clearing Star Citizen Shaders Directory
@ECHO ==========================================================================================
rd "%localappdata%\Star Citizen\" /S /Q
@ECHO They're gone.
TIMEOUT /t 10
GOTO BEGIN
:sub_2
@ECHO ==========================================================================================
@ECHO Backing Up Star Citizen Keybinds and Custom Characters
@ECHO ==========================================================================================
for /f "tokens=3,2,4 delims=/- " %%x in ("%date%") do set d=%%y%%x%%z
set data=%d%
@ECHO === zipping controls =====================================================================
"C:\Program Files\7-Zip\7z.exe" a -tzip %backuppath%\%d%-controls-backup.zip %scpath%\LIVE\user\client\0\Controls
@ECHO === zipping characters ===================================================================
"C:\Program Files\7-Zip\7z.exe" a -tzip %backuppath%\%d%-characters-backup.zip %scpath%\LIVE\user\client\0\CustomCharacters
@ECHO ==========================================================================================
@ECHO That's done.
TIMEOUT /t 10
GOTO BEGIN
:sub_3
@ECHO ==========================================================================================
@ECHO Copying Keybinds from LIVE to PTU and EPTU if it exists
@ECHO ==========================================================================================
xcopy /s %scpath%\LIVE\user\client\0\Controls\ %scpath%\PTU\user\client\0\Controls\ /y
xcopy /s %scpath%\LIVE\user\client\0\Controls\ %scpath%\EPTU\user\client\0\Controls\ /y
@ECHO That's done...
TIMEOUT /t 10
GOTO BEGIN
:sub_4
:END
ECHO Goodbye.
timeout /t 1 /nobreak >nul
exit