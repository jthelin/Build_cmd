@setlocal
@ECHO off

set PROJ_NAME=MyProj

@REM Note: Alternate values for TEST_CATEGORIES may have been passed in through 
@REM       environment variable (due to some limitations of Windows cmd script),
@REM       otherwise we default to TestCategory = BVT (Build Verification Tests)

if .%TEST_CATEGORIES%. == .. set TEST_CATEGORIES=BVT

SET CONFIGURATION=Release

set USE_BINARIES_DIR=True

SET CMDHOME=%~dp0
@REM Remove trailing backslash \
set CMDHOME=%CMDHOME:~0,-1%

if "%FrameworkDir%" == "" set FrameworkDir=%WINDIR%\Microsoft.NET\Framework
if "%FrameworkVersion%" == "" set FrameworkVersion=v4.0.30319

SET VS_IDE_DIR=%VS120COMNTOOLS%..\IDE
SET VSTEST_EXE_DIR=%VS_IDE_DIR%\CommonExtensions\Microsoft\TestWindow
SET VSTEST_EXE=%VSTEST_EXE_DIR%\VSTest.console.exe
set VSTEST_ARGS=

set XUNIT_VER=2.1.0
SET XUNIT_EXE_DIR=%CMDHOME%\packages\xunit.runner.console.%XUNIT_VER%\tools
SET XUNIT_EXE=%XUNIT_EXE_DIR%\xunit.console.exe
set XUNIT_ARGS=

cd "%CMDHOME%"
@cd

@if "%USE_BINARIES_DIR%" == "True" SET OutDir=Binaries\%CONFIGURATION%

set TEST_RESULTS_DIR=TestResults
@if NOT EXIST %TEST_RESULTS_DIR% mkdir %TEST_RESULTS_DIR%

@echo ==== Test %PROJ% %CONFIGURATION% ====

@if "%USE_BINARIES_DIR%" == "True" (
  set TESTS=%OutDir%\Tests.dll
) else (
  set TESTS=Tests\bin\%CONFIGURATION%\Tests.dll
)
@Echo Test assemblies = %TESTS%

@Echo ON

@if "%USE_XUNIT%" == "True" (
  set XUNIT_ARGS=%XUNIT_ARGS% -xml %TEST_RESULTS_DIR%\TestResults.xml
  
  "%XUNIT_EXE%" %TESTS% %XUNIT_ARGS%
) else (
  set VSTEST_ARGS= %VSTEST_ARGS% /Framework:Framework45
  set VSTEST_ARGS= %VSTEST_ARGS% /TestCaseFilter:TestCategory=%TEST_CATEGORIES%

  "%VSTESTEXE%" %VSTEST_ARGS% %TESTS%
)

@if ERRORLEVEL 1 GOTO :ErrorStop
@echo Test ok for %CONFIGURATION% %PROJ%

@echo ======= Test succeeded for %PROJ% =======
@GOTO :EOF

:ErrorStop
set RC=%ERRORLEVEL%
@if "%STEP%" == "" set STEP=%CONFIGURATION%
@echo ===== Test FAILED for %PROJ% -- %STEP% with error %RC% - EXITING =====
exit /B %RC%

:EOF
