--drop TABLE log_level;

prompt CREATE TABLE log_levels
CREATE TABLE log_levels
(
  logger_name   VARCHAR2(65) CONSTRAINT name_NN NOT NULL ,
  trace         NUMBER DEFAULT 0 CONSTRAINT TRACE_NN NOT NULL, 
  debug         NUMBER DEFAULT 0 CONSTRAINT DEBUG_NN NOT NULL ,
  info          NUMBER DEFAULT 0 CONSTRAINT INFO_NN  NOT NULL,
  warn          NUMBER DEFAULT 0 CONSTRAINT WARN_NN  NOT NULL,
  error         NUMBER DEFAULT 0 CONSTRAINT ERROR_NN NOT NULL,
  fatal         NUMBER DEFAULT 0 CONSTRAINT FATAL_NN NOT NULL
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
NOMONITORING;

alter table LOG_LEVELs add constraint log_level_pk primary key("LOGGER_NAME") ;

COMMENT ON TABLE log_levels IS 'Table to hold logging level for various modules';

COMMENT ON COLUMN log_levels.logger_name IS 'name of logger. normally schema.object';

COMMENT ON COLUMN log_levels.trace IS 'Log Level 0=disabled, >0 min number of days retention';
COMMENT ON COLUMN log_levels.debug IS 'Log Level 0=disabled, >0 min number of days retention';
COMMENT ON COLUMN log_levels.info  IS 'Log Level 0=disabled, >0 min number of days retention';
COMMENT ON COLUMN log_levels.warn  IS 'Log Level 0=disabled, >0 min number of days retention';
COMMENT ON COLUMN log_levels.error IS 'Log Level 0=disabled, >0 min number of days retention';
COMMENT ON COLUMN log_levels.fatal IS 'Log Level 0=disabled, >0 min number of days retention';



--default values
MERGE INTO log_levels ll
USING (SELECT 
'.' logger_name,
0 trace,
0 debug,
9999 info,
9999 warn,
9999 error,
9999 fatal 
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
