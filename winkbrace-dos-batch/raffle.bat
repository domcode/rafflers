@echo off

rem DOS Batch raffler by Bas de Ruiter
rem
rem Note: This script assumes a list of names without empty lines.

setlocal enableextensions enabledelayedexpansion

set file=%1

rem Get number of names
set /a count=0
for /f %%i in ('type "%file%"^|find "" /v /c') do set /a count=%%i

rem Take random index
set /a index=%random% * %count% / 32767 +1

rem Echo the lucky person
set /a count=0
FOR /F "tokens=*" %%i IN (%file%) DO (
    set /a count+=1
    if !count!==%index% (
        ECHO %%i
    )
)
