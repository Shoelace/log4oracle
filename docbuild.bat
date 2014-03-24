@echo off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

set ORACLE_HOME=c:\oracle\instantclient_11_2

..\pldoc\pldoc.bat -d doc -doctitle log4plsql src/Appender/*.* src/Core/*.* src/Repository/*.* src/Util/*.* src/Config/*.* src/Layout/*.*


ENDLOCAL
