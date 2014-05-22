--drop TABLE log_level;

prompt CREATE TABLE log_levels
CREATE TABLE log_levels
(
  logger_name   VARCHAR2(65) CONSTRAINT name_NN NOT NULL ,
  trace         CHAR(1) DEFAULT '0' CONSTRAINT TRACE_NN NOT NULL, 
  debug         CHAR(1) DEFAULT '0' CONSTRAINT DEBUG_NN NOT NULL ,
  info          CHAR(1) DEFAULT '0' CONSTRAINT INFO_NN NOT NULL,
  warn          CHAR(1) DEFAULT '0' CONSTRAINT WARN_NN NOT NULL,
  error         CHAR(1) DEFAULT '0' CONSTRAINT ERROR_NN NOT NULL,
  fatal         CHAR(1) DEFAULT '0' CONSTRAINT FATAL_NN NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
NOMONITORING;

alter table LOG_LEVELs add constraint log_level_pk primary key("LOGGER_NAME") ;

COMMENT ON TABLE log_levels IS 'Table to hold logging level for various modules';

COMMENT ON COLUMN log_levels.logger_name IS 'name of logger. normally schema.object';

COMMENT ON COLUMN log_levels.trace IS 'Log Level 0=disabled, 1=dbms.output only, 2=AQ Only, 3=AQ and DBMS.Output';

COMMENT ON COLUMN log_levels.debug IS 'Log Level 0=disabled, 1=dbms.output only, 2=AQ Only, 3=AQ and DBMS.Output';

COMMENT ON COLUMN log_levels.info IS 'Log Level 0=disabled, 1=dbms.output only, 2=AQ Only, 3=AQ and DBMS.Output';

COMMENT ON COLUMN log_levels.warn IS 'Log Level 0=disabled, 1=dbms.output only, 2=AQ Only, 3=AQ and DBMS.Output';

COMMENT ON COLUMN log_levels.error IS 'Log Level 0=disabled, 1=dbms.output only, 2=AQ Only, 3=AQ and DBMS.Output';

COMMENT ON COLUMN log_levels.fatal IS 'Log Level 0=disabled, 1=dbms.output only, 2=AQ Only, 3=AQ and DBMS.Output';


ALTER TABLE LOG_LEVELs ADD (
  CONSTRAINT check_trace
 CHECK (trace IN ('0', '1', '2', '3')),
  CONSTRAINT check_debug
 CHECK (debug in ('0', '1', '2', '3')),
   CONSTRAINT check_info
 CHECK (info  in ('0', '1', '2', '3')),
   CONSTRAINT check_warn
 CHECK (warn  in ('0', '1', '2', '3')),
   CONSTRAINT check_error
 CHECK (error in ('0', '1', '2', '3')),
   CONSTRAINT check_fatal
 CHECK (fatal in ('0', '1', '2', '3'))
);


--default values
MERGE INTO log_levels ll
USING (SELECT 
'.' logger_name,
0 trace,
0 debug,
1 info,
1 warn,
1 error,
1 fatal 
FROM dual) ll2
ON (ll.logger_name = ll2.logger_name)
WHEN MATCHED THEN UPDATE SET
LL.trace = LL2.trace,
LL.debug = LL2.debug,
LL.WARN  = LL2.WARN,
ll.info  = ll2.info,
LL.error = LL2.error,
ll.fatal = ll2.fatal
WHEN NOT MATCHED THEN INSERT
VALUES(ll2.logger_name,ll2.trace,ll2.debug,ll2.info,ll2.warn,ll2.error,ll2.fatal)
;

COMMIT;
