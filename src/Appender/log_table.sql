-- options are to log objects or individual columns
prompt CREATE TABLE log_table 
CREATE TABLE log_table 
(	
	log_timestamp TIMESTAMP WITH TIME ZONE,
	log_level loglevel , 
	log_marker marker ,
	log_location locationinfo,
	log_message VARCHAR2(4000 ),
	log_exception genericexception,
	log_session session_info,
	log_system system_info
)
/

prompt CREATE VIEW  v_log_table
CREATE OR REPLACE VIEW v_log_table
AS
SELECT lt.log_timestamp 
,LT.LOG_LEVEL.m_name level_name
,LT.LOG_LEVEL.m_value level_value
,LT.LOG_MARKER.tostring() LMARKER
,LT.log_location.OWNER owner
,LT.log_location.name NAME
,LT.log_location.LINENO LINENO
,LT.log_location.CALLER_TYPE CALLER_TYPE
,lt.log_message message
,lt.log_exception.m_sqlcode ora_sqlcode
,lt.log_exception.m_sqlerrm ora_sqlerrm
,lt.log_exception.message ora_message
,lt.log_exception.errorstack ora_stack
,lt.log_exception.errorbacktrace ora_backtrace
,lt.log_exception.callstack callstack
from LOG_TABLE LT
order by lt.log_timestamp
/

