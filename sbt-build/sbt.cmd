@setlocal
@echo off

@set SBTHOME=%~dp0.

@echo JAVA_HOME=%JAVA_HOME%
@echo SBTHOME=%SBTHOME%

@set SBT_LAUNCH_JAR=%SBTHOME%\lib\sbt-launch.jar

"%JAVA_HOME%\bin\java.exe" -jar "%SBT_LAUNCH_JAR%" %*
