@echo off
setlocal enabledelayedexpansion

set filename=setting.cfg



REM Prepare the config folder
if not exist "%~dp0cfg\uavxp" mkdir "%~dp0cfg\uavxp"
cd  /D "%~dp0cfg\uavxp"

REM Clear the config file
REM call :write //
echo. 2>!filename!



:menu1
cls
set /p buff=Is your CPU good (Y/N): 
if "!buff!"=="Y" call :append uavxp_highend_cpu && goto menu2
if "!buff!"=="y" call :append uavxp_highend_cpu && goto menu2
if "!buff!"=="N" call :append uavxp_lowend_cpu && goto menu2
if "!buff!"=="n" call :append uavxp_lowend_cpu && goto menu2
goto menu1

:menu2
cls
set /p buff=Is your GPU good (Y/N): 
if "!buff!"=="Y" call :append uavxp_highend_gpu && goto menu3
if "!buff!"=="y" call :append uavxp_highend_gpu && goto menu3
if "!buff!"=="N" call :append uavxp_lowend_gpu && goto menu3
if "!buff!"=="n" call :append uavxp_lowend_gpu && goto menu3
goto menu2

:menu3
cls
set /p buff=What is your lowest FPS in-game: 
call :append cl_cmdrate !buff!
call :append cl_updaterate !buff!
call :append cl_interp 0
goto menu4


:menu4
cls
echo Check your custom config here:
echo.
type !filename!
echo.
pause
exit





:append
REM echo %* >>!filename!
>>!filename! echo %*
goto :EOF

:write
REM echo %* >!filename!
>!filename! echo %*
goto :EOF
