--types
create or replace public synonym log4_object for log4.log4_object;
create or replace public synonym Logger for log4.Logger;
create or replace public synonym Marker for log4.Marker;
create or replace public synonym Result for log4.Result;
create or replace public synonym LogLevel for log4.LogLevel;
create or replace public synonym GenericException for log4.GenericException;

create or replace public synonym LogEvent for log4.LogEvent;
create or replace public synonym Log4oracleLogEvent for log4.Log4oracleLogEvent;

--layouts
create or replace public synonym Layout for log4.Layout;
create or replace public synonym PatternLayout for log4.PatternLayout;
create or replace public synonym SimpleLayout for log4.SimpleLayout;

--Message
create or replace public synonym Message for log4.Message;
create or replace public synonym ObjectMessage for log4.ObjectMessage;
create or replace public synonym ParameterizedMessage for log4.ParameterizedMessage;
create or replace public synonym SimpleMessage for log4.SimpleMessage;

--appender types
create or replace public synonym DBMSOutputAppender for log4.DBMSOutputAppender;
create or replace public synonym SMTPAppender for log4.SMTPAppender;
create or replace public synonym TableAppender for log4.TableAppender;

--Filters
create or replace public synonym Filter for log4.Filter;
create or replace public synonym ThresholdFilter for log4.ThresholdFilter;

--tables
create or replace public synonym log_table for log4.log_table;
create or replace public synonym log_levels for log4.log_levels;

--packages
create or replace public synonym LogManager for log4.LogManager;
create or replace public synonym MarkerManager for log4.MarkerManager;
create or replace public synonym ThreadContext for log4.ThreadContext;

