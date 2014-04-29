--types
grant execute on log4_object to public;
grant execute on Logger to public;
grant execute on Marker to public;
grant execute on LogLevel to public;

--tables
grant select  on log_table to public;
grant select,insert,update,delete on log_levels to public;

--packages
grant execute on LogManager to public;
grant execute on MarkerManager to public;
grant execute on ThreadContext to public;
