--types
grant execute on log4_object to public;
grant execute on Logger to public;
grant execute on Marker to public;
grant execute on Result to public;
grant execute on LogLevel to public;
grant execute on GenericException to public;

grant execute on LogEvent to public;
grant execute on Log4oracleLogEvent to public;

--layouts
grant execute on Layout to public;
grant execute on PatternLayout to public;
grant execute on SimpleLayout to public;

--Message
grant execute on Message to public;
grant execute on ObjectMessage to public;
grant execute on ParameterizedMessage to public;
grant execute on SimpleMessage to public;

--appender types
grant execute on DBMSOutputAppender to public;
grant execute on SMTPAppender to public;
grant execute on TableAppender to public;

--Filters
grant execute on Filter to public;
grant execute on ThresholdFilter to public;

--tables
grant select,delete  on log_table to public;
grant select,insert,update,delete on log_levels to public;

--packages
grant execute on LogManager to public;
grant execute on MarkerManager to public;
grant execute on ThreadContext to public;

