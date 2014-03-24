prompt create or replace package LogManager 
create or replace package LogManager 
AUTHID DEFINER
as
    ROOT_LOGGER_NAME CONSTANT VARCHAR2(30) := '.';

	function GETLOGGER return LOGGER;
	function GETLOGGER(name varchar2) return LOGGER;
	function GETCLASSNAME(DEPTH number) return varchar2;

end ;
/
SHOW ERRORS

