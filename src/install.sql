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
create type APPENDER;
/
create type   DBMSOUTPUTAPPENDER;
/
create type   TABLEAPPENDER;
/
create type FORMATTINGINFO;
/
create type LAYOUT;
/
create type   PATTERNLAYOUT;
/
create type   SIMPLELAYOUT;
/
create type LOG4_OBJECT;
/
create type   GENERICEXCEPTION;
/
create type   LOG4_SQL_OBJECT;
/
create type   LOGEVENT;
/
create type     LOG4ORACLELOGEVENT;
/
create type   LOGLEVEL;
/
create type   MARKER;
/
create type     MARKERIMPL;
/
create type   MESSAGE;
/
create type     OBJECTMESSAGE;
/
create type     PARAMETERIZEDMESSAGE;
/
create type     SIMPLEMESSAGE;
/
create type LOGGER;
/
create type PATTERNCONVERTER;
/
create type   LOGEVENTPATTERNCONVERTER;
/
create type     DATEPATTERNCONVERTER;
/
create type     FULLLOCATIONPATTERNCONVERTER;
/
create type     LEVELPATTERNCONVERTER;
/
create type     LINESEPARATORPATTERNCONVERTER;
/
create type     LITERALPATTERNCONVERTER;
/
create type     LOGGERPATTERNCONVERTER;
/
create type     MARKERPATTERNCONVERTER;
/
create type     MDCPATTERNCONVERTER;
/
create type     MESSAGEPATTERNCONVERTER;
/
create type     NDCPATTERNCONVERTER;
/
create type     THROWABLEPATTERNCONVERTER;
/
create type PATTERNFORMATTER;
/
create type STACKTRACEELEMENT;
/
create type THREADCONTEXTCONTEXTMAP;
/
create type THREADCONTEXTCONTEXTSTACK;
/
create type THREADCONTEXTMAPENTRY;
/
create type LOGGERCONTEXT;
/

prompt &line1
prompt Collections
prompt &line1
--collections
--prompt create type THREADCONTEXTCONTEXTMAPINDEX;
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


@@Util/Log4Util.sql
@@Util/UtlfileURITYPE.sql

prompt &line1
prompt Object Types
prompt &line1

@@Core/ThreadContextStack.sql
@@Core/ThreadContextContextStack.sql

@@Core/ThreadContextMap.sql
@@Util/StackTraceElement.type.pls

@@Util/log4_object.sql

@@Util/GenericException.type.pls
@@Core/Marker.type.pls
@@Core/MarkerImpl.type.pls

@@Message/Message.type.pls
@@Message/SimpleMessage.type.pls
@@Message/ObjectMessage.type.pls
@@Message/ParameterizedMessage.type.pls
@@Core/LogLevel.type.pls

@@Core/LogEvent.type.pls
@@Layout/Layout.pls


@@Core/Log4oracleLogEvent.type.pls

prompt &line1
prompt Converters
prompt &line1

@@Core/Pattern/PatternConverter.pls
@@Core/Pattern/FormattingInfo.sql
@@Core/Pattern/LogEventPatternConverter.pls
@@Core/Pattern/PatternFormatter.pls
@@Core/Pattern/PatternConverterArray.pls

@@Core/Pattern/DatePatternConverter.pls
@@Core/Pattern/FullLocationPatternConverter.pls
@@Core/Pattern/LevelPatternConverter.pls
@@Core/Pattern/LineSeparatorPatternConverter.pls
@@Core/Pattern/LiteralPatternConverter.pls
@@Core/Pattern/LoggerPatternConverter.pls
@@Core/Pattern/MarkerPatternConverter.pls
@@Core/Pattern/MDCPatternConverter.pls
@@Core/Pattern/MessagePatternConverter.pls
@@Core/Pattern/NDCPatternConverter.pls
@@Core/Pattern/ThrowablePatternConverter.pls

prompt &line1
prompt parser
prompt &line1

@@Core/Pattern/PatternParser.pls
@@Core/Pattern/PatternParserBody.pls

@@Message/MessageFactory.pks
--@@Message/ObjectMessage.type.pls
--@@Message/SimpleMessage.type.pls
--@@Message/ParameterizedMessage.type.pls

@@Layout/PatternLayout.pls
@@Layout/SimpleLayout.pls


@@Util/UTL_CALL_STACK.pks


--logger must be last
@@Core/Logger.type.pls
@@Core/loggerimpl.type.pls

@@Core/Result.type.pls
@@Core/Filter.type.pls
@@Core/ThresholdFilter.type.pls
@@Core/CompositeFilter.type.pls

@@Appender/Appender.type.pls

@@Config/Configuration.sql
@@Core/LoggerContext.type.pls

--

prompt &line1
prompt Tables
prompt &line1

@@Config/log_levels.sql

prompt &line1
prompt Appenders
prompt &line1

@@Appender/DBMSOutputAppender.type.pls
--@@Appender/SMTPAppender.type.pls

@@Appender/log_table_plain.sql
@@Appender/TableAppender.type.pls
@@Appender/TableAppender.type.plb

prompt &line1
prompt Package Specs
prompt &line1

@@Core/LogImpl.pks
@@Core/LogManager.pks
@@Core/MarkerManager.pks
@@Core/ThreadContext.pks

@@Util/get_log_level.fnc.plb

prompt &line1
prompt Object Bodies
prompt &line1
@@Core/LoggerContext.type.plb

@@Message/SimpleMessage.type.plb
@@Message/ObjectMessage.type.plb
@@Message/ParameterizedMessage.type.plb
@@Core/Log4oracleLogEvent.type.plb
@@Util/StackTraceElement.type.plb

@@Core/Logger.type.plb
@@Core/LogLevel.type.plb

@@Core/LogManager.pkb
@@Core/MarkerManager.pkb
@@Core/Marker.type.plb
@@Core/MarkerImpl.type.plb


@@Core/LogImpl.pkb
@@Core/ThreadContext.pkb

@@Appender/Appender.type.plb

@@Layout/LayoutBody.pls
@@Layout/PatternLayoutBody.pls
@@Layout/SimpleLayoutBody.pls

@@Util/GenericException.type.plb

prompt &line1
prompt package Bodies
prompt &line1

@@Util/UTL_CALL_STACK.pkb


@@Message/MessageFactory.pkb

@@Util/Log4UtilBody.sql

--other stuff
@@Appender/log_table_trim.prc

begin
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

