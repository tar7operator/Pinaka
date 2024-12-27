@echo off
set LOCALHOST=%COMPUTERNAME%
if /i "%LOCALHOST%"=="Asus-A15" (taskkill /f /pid 35684)
if /i "%LOCALHOST%"=="Asus-A15" (taskkill /f /pid 21108)
if /i "%LOCALHOST%"=="Asus-A15" (taskkill /f /pid 24044)
if /i "%LOCALHOST%"=="Asus-A15" (taskkill /f /pid 14488)

del /F cleanup-ansys-Asus-A15-14488.bat
