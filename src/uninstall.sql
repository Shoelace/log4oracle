drop table log_table;
drop view v_log_table;
drop table log_levels;

drop type log4_object force;
drop type log4_array force;
drop type logger force;
drop type Marker force;
drop type MarkerImpl force;
drop type Locationinfo force;
drop type loglevel force;
drop type GenericException force;

drop type session_info force;
drop type system_info force;

drop package body logimpl;
drop package logimpl;

drop package body logmanager;
drop package logmanager;

drop package body markermanager;
drop package markermanager;

drop function get_log_level;
drop procedure who_called_me;

drop PACKAGE UTL_CALL_STACK;
drop PACKAGE BODY PATTERNPARSER;
drop PACKAGE PATTERNPARSER;
drop TYPE BODY PATTERNCONVERTER;
drop TYPE PATTERNCONVERTERARRAY;
drop TYPE PATTERNCONVERTER;
drop PACKAGE BODY LOG4UTIL;
drop PACKAGE LOG4UTIL;
drop TYPE BODY LOG4_SQL_OBJECT;
drop TYPE LOG4_SQL_OBJECT;
drop PACKAGE BODY MESSAGEFACTORY;
drop PACKAGE MESSAGEFACTORY;
drop TYPE BODY OBJECTMESSAGE;
drop TYPE OBJECTMESSAGE;
drop TYPE BODY SIMPLEMESSAGE;
drop TYPE SIMPLEMESSAGE;
drop TYPE MESSAGE;
drop TYPE BODY SIMPLELAYOUT;
drop TYPE SIMPLELAYOUT;
drop TYPE BODY PATTERNLAYOUT;
drop TYPE PATTERNLAYOUT;
drop TYPE BODY LAYOUT;
drop TYPE LAYOUT;
drop PACKAGE THREADCONTEXT;
drop PACKAGE BODY THREADCONTEXT;
drop TYPE BODY LOG4ORACLELOGEVENT;
drop TYPE LOG4ORACLELOGEVENT;
drop TYPE LOGEVENT;
drop TYPE BODY TABLEAPPENDER;
drop TYPE TABLEAPPENDER;
drop TYPE BODY DBMSOUTPUTAPPENDER;
drop TYPE DBMSOUTPUTAPPENDER;
drop TYPE APPENDER;
