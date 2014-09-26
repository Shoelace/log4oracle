prompt CREATE TABLE log_table 
CREATE TABLE log_table_rt 
(	
	logtimestamp TIMESTAMP WITH TIME ZONE NOT NULL,  --set to local if using partitioning
	loggername VARCHAR2(50 CHAR) NOT NULL,
	loglevel  VARCHAR2(10 CHAR) NOT NULL , 
	logmarker VARCHAR2(200 CHAR) ,
	loglocation VARCHAR2(200 CHAR) ,
	logmessage VARCHAR2(4000  CHAR),
	loguser VARCHAR2(32 CHAR),
	logid NUMBER,
	logthrowable clob,
	logstacktrace clob,
	logcallstack clob,
	logcontext clob
)
/
/*
PARTITION BY RANGE (logtimestamp) 
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
*/


create index I_LOG_LI on log_table_rt(logid) ;	
create index I_LOG_LL on log_table_rt(loglevel) ;	
create index I_LOG_LN on log_table_rt(loggername) ;
CREATE INDEX I_LOG_LU ON log_table_rt(loguser) ;	
create index I_LOG_LT on log_table_rt(logtimestamp) ;	
create index I_LOG_LM on log_table_rt(logmarker) ;	

create editioning view log_table
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


