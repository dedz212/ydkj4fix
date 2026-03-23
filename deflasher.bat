@echo off
title YDKJ 4 - Flash Fix
set "FLASHPATH=%~dp0Flash.ocx"
set "NEED_CLEANUP=0"
set "R=/f /reg:32 >nul 2>&1"
set "CLSID=HKCU\Software\Classes\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}"

:: Cleanup from previous crash (if any)
echo Preparing...
reg delete "%CLSID%" %R%
reg delete "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash" %R%
reg delete "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash.32" %R%
reg delete "HKCU\Software\Classes\TypeLib\{D27CDB6B-AE6D-11cf-96B8-444553540000}" %R%
reg delete "HKCU\Software\Classes\Interface\{D27CDB6C-AE6D-11cf-96B8-444553540000}" %R%

:: Check if Flash is already registered system-wide (32-bit view)
reg query "HKCR\WOW6432Node\CLSID\{D27CDB6E-AE6D-11cf-96B8-444553540000}\InprocServer32" /ve >nul 2>&1
if %errorlevel% equ 0 (
    echo Flash is already installed. Launching game...
    goto :launch
)

:: Flash not installed — register local copy in HKCU (32-bit view)
echo Flash not found. Registering local Flash.ocx...
set "NEED_CLEANUP=1"

:: CLSID
reg add "%CLSID%" /ve /d "Shockwave Flash Object" %R%
reg add "%CLSID%\InprocServer32" /ve /d "%FLASHPATH%" %R%
reg add "%CLSID%\InprocServer32" /v "ThreadingModel" /d "Apartment" %R%
reg add "%CLSID%\Control" %R%
reg add "%CLSID%\MiscStatus" /ve /d "0" %R%
reg add "%CLSID%\MiscStatus\1" /ve /d "131473" %R%
reg add "%CLSID%\ProgID" /ve /d "ShockwaveFlash.ShockwaveFlash.32" %R%
reg add "%CLSID%\Programmable" %R%
reg add "%CLSID%\TypeLib" /ve /d "{D27CDB6B-AE6D-11cf-96B8-444553540000}" %R%
reg add "%CLSID%\Version" /ve /d "1.0" %R%
reg add "%CLSID%\VersionIndependentProgID" /ve /d "ShockwaveFlash.ShockwaveFlash" %R%

:: ProgIDs
reg add "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash" /ve /d "Shockwave Flash Object" %R%
reg add "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash\CLSID" /ve /d "{D27CDB6E-AE6D-11cf-96B8-444553540000}" %R%
reg add "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash\CurVer" /ve /d "ShockwaveFlash.ShockwaveFlash.32" %R%
reg add "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash.32" /ve /d "Shockwave Flash Object" %R%
reg add "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash.32\CLSID" /ve /d "{D27CDB6E-AE6D-11cf-96B8-444553540000}" %R%

:: TypeLib
reg add "HKCU\Software\Classes\TypeLib\{D27CDB6B-AE6D-11cf-96B8-444553540000}\1.0" /ve /d "Shockwave Flash" %R%
reg add "HKCU\Software\Classes\TypeLib\{D27CDB6B-AE6D-11cf-96B8-444553540000}\1.0\0\win32" /ve /d "%FLASHPATH%" %R%
reg add "HKCU\Software\Classes\TypeLib\{D27CDB6B-AE6D-11cf-96B8-444553540000}\1.0\FLAGS" /ve /d "0" %R%

:: Interface
reg add "HKCU\Software\Classes\Interface\{D27CDB6C-AE6D-11cf-96B8-444553540000}" /ve /d "IShockwaveFlash" %R%
reg add "HKCU\Software\Classes\Interface\{D27CDB6C-AE6D-11cf-96B8-444553540000}\ProxyStubClsid32" /ve /d "{00020424-0000-0000-C000-000000000046}" %R%
reg add "HKCU\Software\Classes\Interface\{D27CDB6C-AE6D-11cf-96B8-444553540000}\TypeLib" /ve /d "{D27CDB6B-AE6D-11CF-96B8-444553540000}" %R%
reg add "HKCU\Software\Classes\Interface\{D27CDB6C-AE6D-11cf-96B8-444553540000}\TypeLib" /v "Version" /d "1.0" %R%

echo Done. Launching game...

:launch
start /wait "" "%~dp0YDKJ 4.exe"

:: Cleanup only if we registered
if %NEED_CLEANUP% equ 0 goto :eof
echo Cleaning up...
reg delete "%CLSID%" %R%
reg delete "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash" %R%
reg delete "HKCU\Software\Classes\ShockwaveFlash.ShockwaveFlash.32" %R%
reg delete "HKCU\Software\Classes\TypeLib\{D27CDB6B-AE6D-11cf-96B8-444553540000}" %R%
reg delete "HKCU\Software\Classes\Interface\{D27CDB6C-AE6D-11cf-96B8-444553540000}" %R%
