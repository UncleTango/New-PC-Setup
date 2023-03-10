@echo off

setlocal enabledelayedexpansion

rem Define download paths
set fontsUrl=https://github.com/UncleTango/New-PC-Setup/releases/download/v1.0/Fonts.zip
set chromeUrl=https://github.com/UncleTango/New-PC-Setup/releases/download/v1.0/ChromeSetup.exe
set teamsUrl=https://github.com/UncleTango/New-PC-Setup/releases/download/v1.0/TeamsSetup_c_w_.exe
set displayLinkUrl=https://github.com/UncleTango/New-PC-Setup/releases/download/v1.0/DisplayLink.USB.Graphics.Software.for.Windows11.0.M0-EXE.exe
set printerUrl=https://github.com/UncleTango/New-PC-Setup/releases/download/v1.0/upd-pcl6-x64-6.9.0.24630.exe

rem Define download and installation paths
set downloadsFolder=%cd%\downloads
set installFolder=%cd%\installers

rem Create download and installation folders if they don't exist
if not exist "%downloadsFolder%" mkdir "%downloadsFolder%"
if not exist "%installFolder%" mkdir "%installFolder%"

rem Download and extract fonts
echo Downloading fonts...
powershell -command "& { Invoke-WebRequest '%fontsUrl%' -OutFile '%downloadsFolder%\Fonts.zip' }"
powershell -command "& { Expand-Archive -LiteralPath '%downloadsFolder%\Fonts.zip' -DestinationPath '%installFolder%' }"

rem Download and install Chrome
echo Downloading and installing Chrome...
bitsadmin /transfer "ChromeSetup" /download /priority normal "%chromeUrl%" "%downloadsFolder%\ChromeSetup.exe"
start /wait "%downloadsFolder%\ChromeSetup.exe" /S /install

rem Download and install Teams
echo Downloading and installing Teams...
bitsadmin /transfer "TeamsSetup" /download /priority normal "%teamsUrl%" "%downloadsFolder%\TeamsSetup.exe"
start /wait "%downloadsFolder%\TeamsSetup.exe" /S /install

rem Download and install DisplayLink drivers
echo Downloading and installing DisplayLink drivers...
bitsadmin /transfer "DisplayLinkSetup" /download /priority normal "%displayLinkUrl%" "%downloadsFolder%\DisplayLinkSetup.exe"
start /wait "%downloadsFolder%\DisplayLinkSetup.exe" /v

rem Download and install printer program
echo Downloading and installing printer program...
bitsadmin /transfer "PrinterSetup" /download /priority normal "%printerUrl%" "%downloadsFolder%\PrinterSetup.exe"
%downloadsFolder%\PrinterSetup.exe

rem Remove downloaded files and folders
echo Cleaning up...

rmdir /s /q "%downloadsFolder%"
rmdir /s /q "%installFolder%"


echo Done.
