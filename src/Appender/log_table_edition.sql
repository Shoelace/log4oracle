prompt CREATE TABLE log_table 
CREATE TABLE log_table_rt 
(	
	logtimestamp TIMESTAMP WITH TIME ZONE NOT NULL,  
	loggername VARCHAR2(50 CHAR) NOT NULL,
	loglevel  VARCHAR2(10 CHAR) NOT NULL , 
	logmarker VARCHAR2(200 CHAR) ,
	loglocation VARCHAR2(200 CHAR) ,
	logmessage VARCHAR2(4000  CHAR),
	loguser VARCHAR2(32 CHAR),
	logid NUMBER,
	logthrowable VARCHAR2(4000 CHAR),
	logstacktrace  VARCHAR2(4000 CHAR),
	logcallstack VARCHAR2(4000 CHAR),
	logcontext clob
,   partition_column DATE GENERATED ALWAYS AS (cast(logtimestamp as date)) VIRTUAL --11g workaround
)
PARTITION BY RANGE (partition_column)  INTERVAL( NUMTODSINTERVAL(1,'DAY') )
SUBPARTITION BY LIST (LOGLEVEL) SUBPARTITION TEMPLATE 
(
  SUBPARTITION TRACE VALUES ('TRACE')  
, SUBPARTITION DEBUG VALUES ('DEBUG')  
, SUBPARTITION WARN VALUES ('WARN')  
, SUBPARTITION INFO VALUES ('INFO')  
, SUBPARTITION ERROR VALUES ('ERROR')  
, SUBPARTITION FATAL VALUES (DEFAULT)  
) 
(
  PARTITION TP_LOG_TABLE_20140904 VALUES LESS THAN (timestamp '2014-09-05 00:00:00 +00:00')  
);


create index I_LOG_LI on log_table_rt(logid) ;	
create index I_LOG_LL on log_table_rt(loglevel) ;	
create index I_LOG_LN on log_table_rt(loggername) ;
create index I_LOG_LU ON log_table_rt(loguser) ;	
create index I_LOG_LT on log_table_rt(logtimestamp) ;	
create index I_LOG_LM on log_table_rt(logmarker) ;	

create or replace editioning view log_table
as
select
logtimestamp,
	loggername,
	loglevel,
	logmarker,
	loglocation,
	logmessage,
	loguser,
	logid,
	logthrowable,
	logstacktrace,
	logcallstack,
	logcontext
from log_table_rt
/


