
drop type log4_array force;
drop type logger force;
drop type Marker force;
drop type MarkerImpl force;
drop type loglevel force;
drop type GenericException force;

drop package logimpl;

drop package logmanager;

drop package markermanager;

drop function get_log_level;

drop PACKAGE UTL_CALL_STACK;
drop PACKAGE BODY PATTERNPARSER;
drop PACKAGE PATTERNPARSER;
<<<<<<< HEAD
=======
drop TYPE BODY PATTERNCONVERTER;
drop TYPE PATTERNCONVERTERARRAY force;
drop TYPE PATTERNCONVERTER force;
drop PACKAGE BODY LOG4UTIL;
>>>>>>> 6b591b54793d1683f31d9c70a756e0a80f2bd8bd
drop PACKAGE LOG4UTIL;
drop TYPE LOG4_SQL_OBJECT;
drop PACKAGE MESSAGEFACTORY;
drop TYPE SIMPLELAYOUT;
drop TYPE PATTERNLAYOUT;
drop TYPE LAYOUT;
drop PACKAGE THREADCONTEXT;
drop TYPE LOG4ORACLELOGEVENT;
drop TYPE LOGEVENT;
drop TYPE TABLEAPPENDER;
drop TYPE DBMSOUTPUTAPPENDER;
--drop TYPE SMTPAPPENDER;
drop TYPE APPENDER;

drop TYPE THRESHOLDFILTER;
drop TYPE COMPOSITEFILTER;
drop TYPE FILTERARRAY;
drop TYPE FILTER;
drop TYPE RESULT;

drop type THREADCONTEXTCONTEXTMAP;
drop type THREADCONTEXTCONTEXTSTACK;
drop type ThreadContextStack;
drop type ThreadContextContextMapIndex;
drop type STACKTRACEELEMENT;

drop type NDCPATTERNCONVERTER;

drop TYPE PATTERNCONVERTERARRAY;

drop type PATTERNFORMATTERARRAY;
drop type LOGGERPATTERNCONVERTER;
drop type THROWABLEPATTERNCONVERTER;
drop type MESSAGEPATTERNCONVERTER;
drop type MDCPATTERNCONVERTER;
drop type MARKERPATTERNCONVERTER;
drop type LITERALPATTERNCONVERTER;
drop type LINESEPARATORPATTERNCONVERTER;
drop type LEVELPATTERNCONVERTER;
drop type FULLLOCATIONPATTERNCONVERTER;
drop type DATEPATTERNCONVERTER;
drop type LOGEVENTPATTERNCONVERTER;
drop type THREADCONTEXTMAPENTRY;

drop type FORMATTINGINFOARRAY;

drop type PARAMETERIZEDMESSAGE;
drop TYPE OBJECTMESSAGE;
drop TYPE SIMPLEMESSAGE;
drop TYPE MESSAGE;

drop type PATTERNFORMATTER;

drop type FORMATTINGINFO;
drop TYPE PATTERNCONVERTER;
drop type log4_object;

prompt if you want to remove your data
prompt drop table log_table;
prompt drop table log_levels;

prompt you can now run: 
prompt purge recyclebin;;
