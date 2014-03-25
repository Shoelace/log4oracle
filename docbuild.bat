@echo off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

set ORACLE_HOME=c:\oracle\instantclient_11_2

..\pldoc\pldoc.bat -d doc -doctitle log4plsql src/Appender/*.p* src/Config/*.p* src/Core/*.p* src/Message/*.p* src/Util/*.p* src/Layout/*.p*


ENDLOCAL
