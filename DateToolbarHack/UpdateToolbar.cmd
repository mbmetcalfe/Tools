@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0\Date"
call :getShortDate
ren *.lnk "%dayofweek% %month%-%day%.lnk"
exit /b

:getShortDate
for /f "skip=1 tokens=1-3" %%A in ('wmic path Win32_LocalTime get day^,dayofweek^,month^,year /value /format:table') do (
  set day=00%%A
  set day=!day:~-2!
  set month=00%%C
  set month=!month:~-2!
  set year=%%D
  set year=!year:~-2!

  if "%%B"=="0" set dayofweek="0"
  if "%%B"=="1" set dayofweek="Mon"
  if "%%B"=="2" set dayofweek="Tue"
  if "%%B"=="3" set dayofweek="Wed"
  if "%%B"=="4" set dayofweek="Thu"
  if "%%B"=="5" set dayofweek="Fri"
  if "%%B"=="6" set dayofweek="Sat"
  if "%%B"=="7" set dayofweek="7"

  if "%%C"=="1"  set monthText="Jan"
  if "%%C"=="2"  set monthText="Feb"
  if "%%C"=="3"  set monthText="Mar"
  if "%%C"=="4"  set monthText="Apr"
  if "%%C"=="5"  set monthText="May"
  if "%%C"=="6"  set monthText="Jun"
  if "%%C"=="7"  set monthText="Jul"
  if "%%C"=="8"  set monthText="Aug"
  if "%%C"=="9"  set monthText="Sep"
  if "%%C"=="10" set monthText="Oct"
  if "%%C"=="11" set monthText="Nov"
  if "%%C"=="12" set monthText="Dec"
  exit /b
)