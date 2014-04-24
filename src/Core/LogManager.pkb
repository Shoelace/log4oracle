--prompt create or replace package body LOGMANAGER 

create or replace 
package body LOGMANAGER as


	--essentially who called me at depth
	FUNCTION getClassName(depth NUMBER) RETURN VARCHAR2
	IS
	begin
	--k_logger.entry('getClassName');
	--return k_logger.exit('getClassName',loc.getfqcn);
	return utl_call_stack.owner(depth+1)||'.'|| utl_call_stack.concatenate_subprogram(utl_call_stack.subprogram(depth+1));
	END;

   PROCEDURE insertlogger(l logger)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO allloggers VALUES(l);
      commit;
    exception WHEN others THEN NULL;
    END;
    
	FUNCTION GetLogger(NAME VARCHAR2) RETURN LOGGER IS
   l Logger;
	BEGIN
	--k_logger.entry('GetLogger');
	--needs to come from logger context
    SELECT VALUE(e) INTO l FROM allloggers e WHERE m_name = NAME;
	--K_LOGGER.debug('create simple logger');
	return l;

	--return TREAT( k_logger.exit('GetLogger',m_log) as Logger);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
   -- dbms_output.put_line('creating:'||name);
    l := LOGGER(NAME,999);
    insertlogger(l);

    return l;
    
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
