CREATE OR REPLACE TYPE Extendedlogger 
under Logger
(
	 MEMBER FUNCTION  isEnabled(lvl LogLevel, marker Marker,msg Message, throwable GenericException) return BOOLEAN
	,MEMBER FUNCTION  isEnabled(lvl LogLevel, marker Marker,msg Varchar2) return BOOLEAN
	,MEMBER FUNCTION  isEnabled(lvl LogLevel, marker Marker,msg Varchar2, throwable GenericException) return BOOLEAN

	,MEMBER PROCEDURE  logIfEnabled(fqcn VARCHAR2,lvl LogLevel, marker Marker,msg Message, throwable GenericException) 
	,MEMBER PROCEDURE  logIfEnabled(fqcn VARCHAR2,lvl LogLevel, marker Marker,msg Varchar2) 
	,MEMBER PROCEDURE  logIfEnabled(fqcn VARCHAR2,lvl LogLevel, marker Marker,msg Varchar2, throwable GenericException)

	,MEMBER PROCEDURE logMessage(fqcn Varchar2, lvl LogLevel, marker Marker, msg Message, throwable GenericException)


) not instantiable not final
;
/
show errors
