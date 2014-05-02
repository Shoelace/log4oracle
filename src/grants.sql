--types
grant execute on log4_object to public;
grant execute on Logger to public;
grant execute on Marker to public;
grant execute on LogLevel to public;

--tables
grant select,delete  on log_table to public;
grant select,insert,update,delete on log_levels to public;

--packages
grant execute on LogManager to public;
grant execute on MarkerManager to public;
grant execute on ThreadContext to public;


create public synonym Logger for log4.Logger;
create public synonym LogManager for log4.LogManager;
create public synonym MarkerManager for log4.MarkerManager;
create public synonym ThreadContext for log4.ThreadContext;

create public synonym log_table for log4.log_table;
create public synonym log_levels for log4.log_levels;

