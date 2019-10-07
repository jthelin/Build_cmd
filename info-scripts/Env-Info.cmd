@setlocal
@echo off

SET CMDHOME=%~dp0
@REM Remove trailing backslash \
set CMDHOME=%CMDHOME:~0,-1%

@echo List Environment Variables
@echo ==========================
set

@echo .
@echo Locate shells and programs
@echo ==========================
@for %%p in (cmd bash java javac scala python pip easy_install dnx csc cmake ant mvn sbt msbuild nuget choco scoop curl wget) do (
  @echo %%p
  where %%p
)

@echo .
@echo Show top level directories
@echo ==========================
dir C:\

@echo .
@echo Show Python files
@echo =================
dir C:\python27
dir C:\python27\scripts

@echo .
@echo Show Java tools
@echo ===============
dir C:\java
for /d %%D in (C:\java\*) do (
  dir %%D
)

@echo .
if "%AGENT_HOMEDIRECTORY%" == "" (
  @echo ==== Not running on VSO worker node ====
) else (
  @echo Show VSO Worker Tools
  @echo =====================
  dir /s "%AGENT_HOMEDIRECTORY%\agent\worker\tools"
)

exit /B 0
