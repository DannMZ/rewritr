@echo off
chcp 65001 >NUL
echo Use an algorithm that removes characters 
echo A-through "move", B-through "ren", C-between two parts,
echo L-last space, F-first space
set /p change=
goto %change%
:A
set /p IO="+"
:a1
set /p B="-"
set /a Rern=0
:Ren
  setlocal enabledelayedexpansion
    for /f "delims=" %%i in (
      'dir /a-d /b /s ^| findstr /irc:"%B%"'
    ) do (
      set "n=%%i"
      move /y "!n!" "!n:%B%=%IO%!"
    )
  endlocal
if %Rern%==1 (exit&exit)
goto a1



:B
set /p IO="+"
:b1
set /p B="-"
  setlocal enabledelayedexpansion
for /r %%i in (*%B%*) do (
 set name=%%~ni
 cmd/v/c if not exist "%%~dpi!name:%B%=%IO%!%%~xi" (ren "%%i" "!name:%B%=%IO%!%%~xi")
)
  endlocal
goto b1



:C
set /p F="[="
set /p G="]="
set C=%F%%G%
for %%A IN (*.*) DO (
set aAa=%%~A
set aA=%%~nA
set Aa=%%~xA
 for /f "tokens=1 delims=%C%" %%B IN ("%%~nA") DO (
set A=%%B
 for /f "tokens=3 delims=%C%" %%C IN ("%%~nA") DO (
set B=%%C
call :cC
)
)
)



exit&exit


set IO= 
set B=  
set /a Rern=1
goto Ren
:cC
if "%A:~-1%"==" " (set "A=%A:~0,-1%"& goto cC)
if "%B:~-1%"==" " (set "B=%B:~0,-1%"& goto cC)
if "%B:~0,1%"==" " (set "B=%B:~1%"&goto cC)
if "%A:~0,1%"==" " (set "A=%A:~1%"&goto cC)
ren "%aAa%" "%A% %G% %B%%Aa%"
exit /b
if "%F%"=="%G%" (set C=%F%)
·



:L
set suffix=
for /r %%i in (* *) do (
    set "pth_n=%%~i"
    set "var=%%~ni"
    set "ext=%%~xi"
    call :trim
    )
pause&exit
:trim
if "%var:~-1%"==" " (set "var=%var:~0,-1%"&goto trim)
ren "%pth_n%" "%var%%ext%"
exit /b



:f
set suffix=
for /r %%i in (*- *) do (
    set "pth_n=%%~i"
    set "var=%%~ni"
    set "ext=%%~xi"
    call :trim
    )
pause&exit
:trim
if "%var:~0,2%"=="- " (set "var=%var:~2%"&goto trim)
ren "%pth_n%" "%var%%ext%"
exit /b