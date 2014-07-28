accept grantname default "PUBLIC" prompt "Enter username to assign grants[PUBLIC]:"

set verify on

--types
grant execute on log4_object to &grantname;
grant execute on Logger to &grantname;
grant execute on Marker to &grantname;
grant execute on Result to &grantname;
grant execute on LogLevel to &grantname;
grant execute on GenericException to &grantname;

grant execute on LogEvent to &grantname;
grant execute on Log4oracleLogEvent to &grantname;

--layouts
grant execute on Layout to &grantname;
grant execute on PatternLayout to &grantname;
grant execute on SimpleLayout to &grantname;

--Message
grant execute on Message to &grantname;
grant execute on ObjectMessage to &grantname;
grant execute on ParameterizedMessage to &grantname;
grant execute on SimpleMessage to &grantname;

--appender types
grant execute on DBMSOutputAppender to &grantname;
--grant execute on SMTPAppender to &grantname;
grant execute on TableAppender to &grantname;

--Filters
grant execute on Filter to &grantname;
grant execute on ThresholdFilter to &grantname;

--tables
grant select,delete  on log_table to &grantname;
grant select,insert,update,delete on log_levels to &grantname;

--packages
grant execute on LogManager to &grantname;
grant execute on MarkerManager to &grantname;
grant execute on ThreadContext to &grantname;

