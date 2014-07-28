accept syntype default '' prompt "type 'public' to create public synonyms or press enter for private:"

--types
create or replace &syntype synonym log4_object for log4.log4_object;
create or replace &syntype synonym Logger for log4.Logger;
create or replace &syntype synonym Marker for log4.Marker;
create or replace &syntype synonym Result for log4.Result;
create or replace &syntype synonym LogLevel for log4.LogLevel;
create or replace &syntype synonym GenericException for log4.GenericException;

create or replace &syntype synonym LogEvent for log4.LogEvent;
create or replace &syntype synonym Log4oracleLogEvent for log4.Log4oracleLogEvent;

--layouts
create or replace &syntype synonym Layout for log4.Layout;
create or replace &syntype synonym PatternLayout for log4.PatternLayout;
create or replace &syntype synonym SimpleLayout for log4.SimpleLayout;

--Message
create or replace &syntype synonym Message for log4.Message;
create or replace &syntype synonym ObjectMessage for log4.ObjectMessage;
create or replace &syntype synonym ParameterizedMessage for log4.ParameterizedMessage;
create or replace &syntype synonym SimpleMessage for log4.SimpleMessage;

--appender types
create or replace &syntype synonym DBMSOutputAppender for log4.DBMSOutputAppender;
create or replace &syntype synonym SMTPAppender for log4.SMTPAppender;
create or replace &syntype synonym TableAppender for log4.TableAppender;

--Filters
create or replace &syntype synonym Filter for log4.Filter;
create or replace &syntype synonym ThresholdFilter for log4.ThresholdFilter;

--tables
create or replace &syntype synonym log_table for log4.log_table;
create or replace &syntype synonym log_levels for log4.log_levels;

--packages
create or replace &syntype synonym LogManager for log4.LogManager;
create or replace &syntype synonym MarkerManager for log4.MarkerManager;
create or replace &syntype synonym ThreadContext for log4.ThreadContext;

