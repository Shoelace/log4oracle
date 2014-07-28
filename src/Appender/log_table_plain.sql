prompt CREATE TABLE log_table 
CREATE TABLE log_table 
(	
	logtimestamp TIMESTAMP WITH TIME ZONE NOT NULL,
	loggername VARCHAR2(50) NOT NULL,
	loglevel  VARCHAR2(10) NOT NULL , 
	logmarker VARCHAR2(200) ,
	loglocation VARCHAR2(200) ,
	logmessage VARCHAR2(4000 ),
	loguser VARCHAR2(32),
	logid NUMBER,
	logthrowable clob,
	logstacktrace clob,
	logcallstack clob,
	logcontext clob
)
/



