--types
grant execute on log4_object to public;
grant execute on Logger to public;
grant execute on Filter to public;
grant execute on Marker to public;
grant execute on LogLevel to public;
grant execute on GenericException to public;
grant execute on DBMSOutputAppender to public;
grant execute on Layout to public;
grant execute on PatternLayout to public;

--tables
grant select,delete  on log_table to public;
grant select,insert,update,delete on log_levels to public;

--packages
grant execute on LogManager to public;
grant execute on MarkerManager to public;
grant execute on ThreadContext to public;


create public synonym Logger for log4.Logger;
create public synonym LogLevel for log4.Logger;
create public synonym GenericException for log4.GenericException;

create public synonym LogManager for log4.LogManager;
create public synonym MarkerManager for log4.MarkerManager;
create public synonym ThreadContext for log4.ThreadContext;

create public synonym log_table for log4.log_table;
create public synonym log_levels for log4.log_levels;

create public synonym DBMSOutputAppender for log4.DBMSOutputAppender ;
create public synonym Layout for log4.Layout ;
create public synonym PatternLayout for log4.PatternLayout ;


