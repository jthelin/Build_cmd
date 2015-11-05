@setlocal
@echo off

SET CMDHOME=%~dp0
@REM Remove trailing backslash \
set CMDHOME=%CMDHOME:~0,-1%

@echo List Environment Variables
@echo ==========================
set

@echo Locate shells and programs
@echo ==========================
@for %%p in (cmd bash java javac scala python ant mvn sbt nuget choco scoop curl wget) do (
  @echo %%p
  where %%p
)

if "%AGENT_HOMEDIRECTORY%" == "" (
  @echo ==== Not running on VSO worker node ====
) else (
  @echo Show VSO Worker Tools
  @echo =====================
  dir /s "%AGENT_HOMEDIRECTORY%\agent\worker\tools"
)

exit /B 0
