alter session set ddl_lock_timeout = 5;
/**
* Copyright 2011
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

clear screen
set termout off
set echo off
set verify off
set feedback off
set ttitle off
set serveroutput on size 1000000 format wrapped
set serveroutput on size unlimited format wrapped
set define on
set timing off
whenever sqlerror exit

define line1='------------------------------------------------------------------------'
define line2='========================================================================'
define finished='.                            Finished'

prompt [ I N S T A L L A T I O N ]

set timing off
set termout on



prompt &line1
prompt Predeclare object types
prompt &line1


--predeclare
/*
SELECT 'create type '||LPAD(' ',(level-1)*2,' ')||type_name||';'||chr(10)||'/' --LPAD(' ',(level-1)*2,' ') ||type_name
FROM user_types
where typecode = 'OBJECT'
CONNECT BY  supertype_name = PRIOR type_name --and supertype_owner = PRIOR owner
START WITH supertype_name IS NULL
;
*/
create type LOG4_OBJECT;
/                                                                           

create type   LOGEVENT;
/                                                                            

create type     LOG4ORACLELOGEVENT;
/                                                                

create type   LOG4_SQL_OBJECT;
/                                                                     

create type   GENERICEXCEPTION;
/                                                                    

create type   MESSAGE;
/                                                                             

create type     MULTIFORMATMESSAGE;
/                                                                


create type     SIMPLEMESSAGE;
/                                                                     

create type     PARAMETERIZEDMESSAGE;
/                                                              

create type     OBJECTMESSAGE;
/                                                                     

create type   MARKER;
/                                                                              

create type     MARKERIMPL;
/                                                                        

create type   LOGLEVEL;
/                                                                            


create type   CONFIGURATION;
/                                                                       

create type   FILTER;
/                                                                              

create type     COMPOSITEFILTER;
/                                                                   

create type     THRESHOLDFILTER;
/                                                                   

create type LAYOUT;
/                                                                                

create type   SIMPLELAYOUT;
/                                                                        

create type   PATTERNLAYOUT;
/                                                                       


create type FORMATTINGINFO;
/                                                                        

create type APPENDER;
/                                                                              

create type   TABLEAPPENDER;
/                                                                       

create type   DBMSOUTPUTAPPENDER;
/                                                                  

create type LOGGERCONTEXT;
/                                                                         

create type   SIMPLELOGGERCONTEXT;
/                                                                 


create type   LOGGERCONTEXTIMPL;
/                                                                   

create type THREADCONTEXTMAPENTRY;
/                                                                 

create type THREADCONTEXTCONTEXTSTACK;
/                                                             

create type THREADCONTEXTCONTEXTMAP;
/                                                               

create type STACKTRACEELEMENT;
/                                                                     

create type PATTERNFORMATTER;
/                                                                      

create type PATTERNCONVERTER;
/                                                                      


create type   LOGEVENTPATTERNCONVERTER;
/                                                            

create type     THROWABLEPATTERNCONVERTER;
/                                                         

create type     NDCPATTERNCONVERTER;
/                                                               

create type     MESSAGEPATTERNCONVERTER;
/                                                           

create type     MDCPATTERNCONVERTER;
/                                                               

create type     MARKERPATTERNCONVERTER;
/                                                            


create type     LOGGERPATTERNCONVERTER;
/                                                            

create type     LITERALPATTERNCONVERTER;
/                                                           

create type     LINESEPARATORPATTERNCONVERTER;
/                                                     

create type     LEVELPATTERNCONVERTER;
/                                                             

create type     FULLLOCATIONPATTERNCONVERTER;
/                                                      

create type     DATEPATTERNCONVERTER;
/                                                              

create type LOGGER;
/                                                                                


create type   EXTENDEDLOGGER;
/                                                                      

create type     ABSTRACTLOGGER;
/                                                                    

create type       SIMPLELOGGER;
/                                                                    

create type RESULT;
/                                                                                


prompt &line1
prompt Collections
prompt &line1
--collections
Prompt create type THREADCONTEXTCONTEXTMAPINDEX;
--create type THREADCONTEXTCONTEXTMAPINDEX;
--/
--create type LOG4_ARRAY;
--/
--create type PATTERNCONVERTERARRAY;
--/
--create type FORMATTINGINFOARRAY;
--/
--create type PATTERNFORMATTERARRAY;
--/


prompt &line1
prompt Generic Stuff
prompt &line1


@@log4/Util/Log4Util.sql
--@@log4/Util/UtlfileURITYPE.sql

-- -------------------------------------------------------------------------
prompt &line1
prompt Object Types
prompt &line1

@@log4/Spi/ThreadContextStack.sql
@@log4/Spi/ThreadContextContextStack.sql

@@log4/Spi/ThreadContextMap.sql
@@log4/Util/StackTraceElement.type.pls

@@log4/Util/log4_object.sql

@@log4/Util/GenericException.type.pls
@@log4/Marker.type.pls
@@log4/Core/MarkerImpl.type.pls

@@log4/Message/Message.type.pls
@@log4/Message/SimpleMessage.type.pls
@@log4/Message/ObjectMessage.type.pls
@@log4/Message/ParameterizedMessage.type.pls
@@log4/Core/LogLevel.type.pls

@@log4/Core/LogEvent.type.pls
@@log4/Core/Layout/Layout.pls


@@log4/Core/Log4oracleLogEvent.type.pls

-- -------------------------------------------------------------------------
prompt &line1
prompt Converters
prompt &line1

@@log4/Core/Pattern/PatternConverter.pls
@@log4/Core/Pattern/FormattingInfo.sql
@@log4/Core/Pattern/LogEventPatternConverter.pls
@@log4/Core/Pattern/PatternFormatter.pls
@@log4/Core/Pattern/PatternConverterArray.pls

@@log4/Core/Pattern/DatePatternConverter.pls
@@log4/Core/Pattern/FullLocationPatternConverter.pls
@@log4/Core/Pattern/LevelPatternConverter.pls
@@log4/Core/Pattern/LineSeparatorPatternConverter.pls
@@log4/Core/Pattern/LiteralPatternConverter.pls
@@log4/Core/Pattern/LoggerPatternConverter.pls
@@log4/Core/Pattern/MarkerPatternConverter.pls
@@log4/Core/Pattern/MDCPatternConverter.pls
@@log4/Core/Pattern/MessagePatternConverter.pls
@@log4/Core/Pattern/NDCPatternConverter.pls
@@log4/Core/Pattern/ThrowablePatternConverter.pls

-- -------------------------------------------------------------------------
prompt &line1
prompt parser
prompt &line1

@@log4/Core/Pattern/PatternParser.pls
@@log4/Core/Pattern/PatternParserBody.pls

@@log4/Message/MessageFactory.pks
--@@Message/ObjectMessage.type.pls
--@@Message/SimpleMessage.type.pls
--@@Message/ParameterizedMessage.type.pls

@@log4/Core/Layout/PatternLayout.pls
@@log4/Core/Layout/SimpleLayout.pls


@@log4/Util/UTL_CALL_STACK.pks


--logger must be last
@@log4/Logger.type.pls
@@log4/spi/ExtendedLogger.sql
@@log4/spi/AbstractLogger.type.pls
@@log4/Simple/SimpleLogger.type.pls

@@log4/Core/Result.type.pls
@@log4/Core/Filter/Filter.type.pls
@@log4/Core/Filter/ThresholdFilter.type.pls
@@log4/Core/Filter/CompositeFilter.type.pls

@@log4/Core/Appender/Appender.type.pls

@@log4/Core/Config/Configuration.sql
@@log4/Spi/LoggerContext.type.pls
@@log4/Simple/SimpleLoggerContext.type.pls

--
-- -------------------------------------------------------------------------
prompt &line1
prompt Tables
prompt &line1

@@log4/Core/Config/log_levels.sql

-- -------------------------------------------------------------------------
prompt &line1
prompt Appenders
prompt &line1

@@log4/Core/Appender/DBMSOutputAppender.type.pls
--@@Appender/SMTPAppender.type.pls

@@log4/Core/Appender/log_table_plain.sql
@@log4/Core/Appender/TableAppender.type.pls
@@log4/Core/Appender/TableAppender.type.plb

-- -------------------------------------------------------------------------
prompt &line1
prompt Package Specs
prompt &line1

@@log4/Core/Logger_Impl.pks
@@log4/LogManager.pks
@@log4/MarkerManager.pks
@@log4/Spi/ThreadContext.pks

@@log4/Util/get_log_level.fnc.plb
@@log4/spi/LoggerContext_impl.sql

prompt &line1
prompt Object Bodies
prompt &line1

@@log4/Spi/LoggerContext.type.plb
@@log4/Simple/SimpleLoggerContext.type.plb

@@log4/Message/SimpleMessage.type.plb
@@log4/Message/ObjectMessage.type.plb
@@log4/Message/ParameterizedMessage.type.plb
@@log4/Core/Log4oracleLogEvent.type.plb
@@log4/Util/StackTraceElement.type.plb

@@log4/Core/LogLevel.type.plb

@@log4/Spi/AbstractLogger.type.plb
@@log4/Simple/SimpleLogger.type.plb

@@log4/LogManager.pkb
@@log4/MarkerManager.pkb
@@log4/Marker.type.plb
@@log4/Core/MarkerImpl.type.plb


@@log4/Core/Logger_Impl.pkb
@@log4/Spi/ThreadContext.pkb

@@log4/Core/Appender/Appender.type.plb

@@log4/Core/Layout/LayoutBody.pls
@@log4/Core/Layout/PatternLayoutBody.pls
@@log4/Core/Layout/SimpleLayoutBody.pls

@@log4/Util/GenericException.type.plb

prompt &line1
prompt package Bodies
prompt &line1

@@log4/Util/UTL_CALL_STACK.pkb


@@log4/Message/MessageFactory.pkb

@@log4/Util/Log4UtilBody.sql

--other stuff
@@log4/Core/Appender/log_table_trim.prc

begin
NULL;
$IF dbms_db_version.ver_le_10 $THEN
$ELSIF dbms_db_version.ver_le_11 $THEN
$ELSE
execute immediate 'drop package UTL_CALL_STACK';
$END
end;
/

-- @@grants.sql

prompt &line1
prompt &finished
prompt &line2
@tst
set feedback on

