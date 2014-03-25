prompt create or replace package body LOGMANAGER 

create or replace 
package body LOGMANAGER as


	--essentially who called me at depth
	FUNCTION getClassName(depth NUMBER) RETURN VARCHAR2
	IS
	--loc LocationInfo := LocationInfo();
	begin
	--k_logger.entry('getClassName');
	--log4util.who_called_me( loc.owner, loc.name, loc.lineno, loc.caller_type ,depth );
	--dbms_output.put_line($$PLSQL_UNIT ||':'||loc.lineno);
	--dbms_output.put_line($$PLSQL_UNIT ||':'||loc.toString());
	--return k_logger.exit('getClassName',loc.getfqcn);
	return utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(depth));
	END;


	function GetLogger(name varchar2) return LOGGER is
	begin
	--k_logger.entry('GetLogger');
	--needs to come from logger context
	--K_LOGGER.debug('create simple logger');
	return LOGGER(name,999);

	--return TREAT( k_logger.exit('GetLogger',m_log) as Logger);
	end;

	function GetLogger return LOGGER is
	begin
	return getLogger(getClassName(2));
	end;

	function GetRootLogger return LOGGER is
	begin
	return getLogger(ROOT_LOGGER_NAME);
	end;

end;
/
show errors
