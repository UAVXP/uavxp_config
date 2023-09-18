@echo off
setlocal enabledelayedexpansion

set filename=setting.cfg



REM Prepare the config folder
if not exist "%~dp0cfg\uavxp" mkdir "%~dp0cfg\uavxp"
cd  /D "%~dp0cfg\uavxp"

REM Clear the config file
REM call :write //
echo. 2>!filename!



set cpu=
set gpu=
set minfps=
set network=



:menu1
cls
set /p buff=Is your CPU good (Y/N): 
if "!buff!"=="Y" set cpu=highend&& goto menu2
if "!buff!"=="y" set cpu=highend&& goto menu2
if "!buff!"=="N" set cpu=lowend&& goto menu2
if "!buff!"=="n" set cpu=lowend&& goto menu2
goto menu1

:menu2
cls
set /p buff=Is your GPU good (Y/N): 
if "!buff!"=="Y" set gpu=highend&& goto menu3
if "!buff!"=="y" set gpu=highend&& goto menu3
if "!buff!"=="N" set gpu=lowend&& goto menu3
if "!buff!"=="n" set gpu=lowend&& goto menu3
goto menu2

:menu3
cls
set /p minfps=What is your average FPS in-game (10-60): 
if !minfps! lss 10 echo Value is too low. Please, try again.&& pause && goto menu3
if !minfps! gtr 60 echo Value is too high. Please, try again.&& pause && goto menu3
REM FIXME: Value can be char or string
goto menu4

:menu4
cls
set /p buff=Is your network good (e.q. wired connection) (Y/N): 
if "!buff!"=="Y" set network=highend&& goto menu5
if "!buff!"=="y" set network=highend&& goto menu5
if "!buff!"=="N" set network=lowend&& goto menu5
if "!buff!"=="n" set network=lowend&& goto menu5
goto menu4

:menu5
if "!cpu!"=="highend" call :append uavxp_highend_cpu
if "!cpu!"=="lowend" call :append uavxp_lowend_cpu
if "!gpu!"=="highend" call :append uavxp_highend_gpu
if "!gpu!"=="lowend" call :append uavxp_lowend_gpu
call :append cl_cmdrate !minfps!
call :append cl_updaterate !minfps!
if "!network!"=="highend" call :append cl_interp_ratio 1
if "!network!"=="lowend" call :append cl_interp_ratio 2
call :append cl_interp 0
goto end

:end
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
