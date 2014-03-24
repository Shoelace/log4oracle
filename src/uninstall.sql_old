/** 
* Copyright 2011 Juergen Lipp
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
set define on

define line1='------------------------------------------------------------------------'
define line2='========================================================================'
define finished='.                            Finished'

column col noprint new_value ut_owner
select user col from dual;

column col noprint new_value txt_prompt
select 'I N S T A L L A T I O N' col from dual;

set termout on
prompt &line2
prompt Copyright 2011 Juergen Lipp
prompt 
prompt Licensed under the Apache License, Version 2.0 (the "License");
prompt you may not use this file except in compliance with the License.
prompt You may obtain a copy of the License at
prompt 
prompt     http://www.apache.org/licenses/LICENSE-2.0
prompt 
prompt Unless required by applicable law or agreed to in writing, software
prompt distributed under the License is distributed on an "AS IS" BASIS,
prompt WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
prompt See the License for the specific language governing permissions and
prompt limitations under the License.
prompt &line2
prompt 

prompt [ &txt_prompt ]

set termout off
set echo off
set verify off
set feedback off
set ttitle off
set define on
set serveroutput on size 1000000 format wrapped
set termout on

prompt &line1
prompt Droping existing log4oracle-plsql objects
prompt &line1

execute dbms_aqadm.stop_queue ( queue_name        => 'log_queue' ); 
execute dbms_aqadm.drop_queue ( queue_name        => 'log_queue' );
execute dbms_aqadm.drop_queue_table ( queue_table        => 'log_queue_table' , force =>true);

drop package BasicConfigurator;
drop package LogManager;
drop package Hierarchy;
drop package LogUtil;
drop package LogLog;
drop package PatternParser;
drop type ConsoleAppender FORCE;
drop type AQAppender FORCE;
drop type LoggerImpl FORCE;
drop type LoggerArray FORCE;
drop type Logger FORCE;
drop type AppenderArray FORCE;
drop type AppenderSkeleton FORCE;
drop type SimpleLayout FORCE;
drop type PatternLayout FORCE;
drop type PatternConverterArray FORCE;
drop type PatternConverter FORCE;
drop type ExceptionLayout FORCE;
drop type LayoutSkeleton FORCE;
drop type LocationInfo FORCE;
drop type LoggingEvent FORCE;
drop type LogLevel FORCE;
drop type GenericException FORCE;


prompt &finished
set feedback on
