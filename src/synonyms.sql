accept syntype default '' prompt "type 'public' to create public synonyms or press enter for private:"
accept usern default '' prompt "type 's06dp3.' to create privte synonyms specific user:"

--types
create or replace &syntype synonym &usern.log4_object for log4.log4_object;
create or replace &syntype synonym &usern.Logger for log4.Logger;
create or replace &syntype synonym &usern.Marker for log4.Marker;
create or replace &syntype synonym &usern.Result for log4.Result;
create or replace &syntype synonym &usern.LogLevel for log4.LogLevel;
create or replace &syntype synonym &usern.GenericException for log4.GenericException;

create or replace &syntype synonym &usern.LogEvent for log4.LogEvent;
create or replace &syntype synonym &usern.Log4oracleLogEvent for log4.Log4oracleLogEvent;

--layouts
create or replace &syntype synonym &usern.Layout for log4.Layout;
create or replace &syntype synonym &usern.PatternLayout for log4.PatternLayout;
create or replace &syntype synonym &usern.SimpleLayout for log4.SimpleLayout;

--Message
create or replace &syntype synonym &usern.Message for log4.Message;
create or replace &syntype synonym &usern.ObjectMessage for log4.ObjectMessage;
create or replace &syntype synonym &usern.ParameterizedMessage for log4.ParameterizedMessage;
create or replace &syntype synonym &usern.SimpleMessage for log4.SimpleMessage;

--appender types
create or replace &syntype synonym &usern.DBMSOutputAppender for log4.DBMSOutputAppender;
create or replace &syntype synonym &usern.SMTPAppender for log4.SMTPAppender;
create or replace &syntype synonym &usern.TableAppender for log4.TableAppender;

--Filters
create or replace &syntype synonym &usern.Filter for log4.Filter;
create or replace &syntype synonym &usern.ThresholdFilter for log4.ThresholdFilter;

--tables
create or replace &syntype synonym &usern.log_table for log4.log_table;
create or replace &syntype synonym &usern.log_levels for log4.log_levels;

--packages
create or replace &syntype synonym &usern.LogManager for log4.LogManager;
create or replace &syntype synonym &usern.MarkerManager for log4.MarkerManager;
create or replace &syntype synonym &usern.ThreadContext for log4.ThreadContext;

