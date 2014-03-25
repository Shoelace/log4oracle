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

define line1='------------------------------------------------------------------------'
define line2='========================================================================'
define finished='.                            Finished'

prompt [ I N S T A L L A T I O N ]

set termout on



prompt &line1
prompt Predeclare object types
prompt &line1


--predeclare
--select 'create type '||type_name||';' from user_types where typecode = 'OBJECT';
create type SIMPLELAYOUT;
/
create type PATTERNLAYOUT;
/
create type LAYOUT;
/
create type TABLEAPPENDER;
/
create type DBMSOUTPUTAPPENDER;
/
create type LOG4ORACLELOGEVENT;
/
create type LOGEVENT;
/
create type OBJECTMESSAGE;
/
create type SIMPLEMESSAGE;
/
create type MESSAGE;
/
--create type SYSTEM_INFO;
--/
--create type SESSION_INFO;
--/
create type PATTERNCONVERTER;
/
create type GENERICEXCEPTION;
/
create type APPENDER;
/
create type LOG4_SQL_OBJECT;
/
create type LOG4_OBJECT;
/
--create type LOCATIONINFO;
--/
create type LOGLEVEL;
/
create type MARKER;
/
create type MARKERIMPL;
/
create type LOGGER;
/


prompt &line1
prompt Object Types
prompt &line1

@@Core/ThreadContextObjects.sql
@@Util/StackTraceElement.type.pls

@@Util/log4_object.sql

@@Util/GenericException.type.pls
@@Core/Marker.type.pls

@@Message/Message.type.pls
@@Core/LogLevel.type.pls

@@Core/LogEvent.type.pls
@@Layout/Layout.pls


@@Appender/Appender.type.pls

@@Core/Log4oracleLogEvent.type.pls
@@Util/PatternConverter.sql
@@Util/PatternConverterArray.sql
@@Util/EIPatternConverter.sql
@@Util/EIPatternConverterBody.sql
@@Util/NDCPatternConverter.sql
@@Util/PatternParser.sql
@@Util/PatternParserBody.sql

@@Message/MessageFactory.pks
@@Message/ObjectMessage.type.pls
@@Message/SimpleMessage.type.pls

@@Layout/PatternLayout.pls
@@Layout/SimpleLayout.pls


@@Util/UTL_CALL_STACK.pks
@@Util/Log4Util.sql


--logger must be last
@@Core/Logger.type.pls


--

prompt &line1
prompt Tables
prompt &line1

@@Config/log_levels.sql

@@Appender/DBMSOutputAppender.type.pls

@@Appender/log_table_plain.sql
@@Appender/TableAppender.type.pls

prompt &line1
prompt Package Specs
prompt &line1

@@Core/LogImpl.pks
@@Core/LogManager.pks
@@Core/MarkerManager.pks
@@Core/ThreadContext.pks

prompt &line1
prompt Object Bodies
prompt &line1

--@@Types\system_info.type.plb
--@@Types\session_info.type.plb
--@@Types\Marker.type.plb
--@@Types\LogLevel.type.plb
--@@Types\GenericException.type.plb
--@@Types\LocationInfo.type.plb
--@@Types\Logger.type.plb
@@Message/SimpleMessage.type.plb
@@Message/ObjectMessage.type.plb
@@Core/Log4oracleLogEvent.type.plb
@@Util/StackTraceElement.type.plb

prompt &line1
prompt package Bodies
prompt &line1

@@Util/UTL_CALL_STACK.pkb

--@@Functions\get_log_level.fnc.plb
--@@Functions\who_called_me.prc.plb

--@@Packages\LogImpl.pkb
--@@Packages\MarkerManager.pkb
--@@Packages\LogManager.pkb

@@Util/get_log_level.fnc.plb

@@Message/MessageFactory.pkb


@@Core/Logger.type.plb
@@Core/LogLevel.type.plb

@@Core/LogManager.pkb
@@Core/MarkerManager.pkb
@@Core/Marker.type.plb
@@Core/LogImpl.pkb
@@Core/ThreadContext.pkb


@@Layout/LayoutBody.pls
@@Layout/PatternLayoutBody.pls
@@Layout/SimpleLayoutBody.pls

@@Util/GenericException.type.plb
--@@Util/system_info.type.plb
--@@Util/session_info.type.plb
@@Util/Log4UtilBody.sql
--@@Util/LocationInfo.type.plb

--@@grants.sql

prompt &finished
set feedback on

