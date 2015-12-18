--this is a drop in replaceform for a simple version of log4 oracle
--not all logging methods are available
-- it only prints to dbms_output
-- all log levels are always enabled

CREATE OR REPLACE TYPE logger
AS OBJECT
(
  m_name varchar2(255)
  --m_lvl number


	/* log4x 1.x api */

  ,member procedure trace(msg varchar2)
  --,member procedure trace(msg varchar2, throwable)
  ,member procedure debug(msg varchar2)
  --,member procedure debug(msg varchar2, throwable)
  ,member procedure info(msg varchar2)
  --,member procedure info(msg varchar2, throwable)
  ,member procedure warn(msg varchar2)
  --,member procedure warn(msg varchar2, throwable)
  ,member procedure error(msg varchar2)
  --,member procedure error(msg varchar2, throwable)
  ,member procedure fatal(msg varchar2)
  --,member procedure fatal(msg varchar2, throwable)

  ,member function isTraceEnabled return BOOLEAN
  ,member function isDebugEnabled return BOOLEAN
  ,member function isInfoEnabled  return BOOLEAN
  ,member function isWarnEnabled  return BOOLEAN
  ,member function isErrorEnabled return BOOLEAN
  ,member function isFatalEnabled return BOOLEAN

  ,member function getName return VARCHAR2

/*  removed from 2.x
getlevel
getparent
*/

  ,member procedure log(lvl varchar2, msg varchar2)
  --,member procedure log(lvl varchar2, MSG varchar2, throwable)
  --,member procedure log(fqcn varchar2,lvl varchar2, MSG varchar2, throwable)

	/* end log4 1.x api */


	/* log4 2.x api */
  --,member procedure catching(throwable)
  --,member procedure catching(lvl varchar2, throwable)
  ,member procedure debug(m varchar2, msg varchar2)
  --,member procedure debug(m varchar2, msg varchar2, throwable)

  ,member procedure entry
  --,member procedure entry(params varchar2)

  ,member procedure error(m varchar2, msg varchar2)
  --,member procedure error(m varchar2, msg varchar2, throwable)

  ,member procedure exit
--sql overloads
  ,member function exit(result VARCHAR2) return VARCHAR2
  ,member function exit(result NUMBER) return NUMBER
  ,member function exit(result DATE) return DATE
  --,member function exit(result BINARY_FLOAT) return BINARY_FLOAT
  --,member function exit(result BINARY_DOUBLE) return BINARY_DOUBLE
  ,member function exit(result TIMESTAMP WITH TIME ZONE) return TIMESTAMP WITH TIME ZONE
  --,member function exit(result INTERVAL YEAR TO MONTH ) return INTERVAL YEAR TO MONTH
  --,member function exit(result INTERVAL DAY TO SECOND ) return INTERVAL DAY TO SECOND
  --,member function exit(result RAW) return RAW
  --,member function exit(result BFILE) return BFILE
--pl/sql overloads
  ,member function exit(result BOOLEAN) return BOOLEAN
  --,member function exit(result R) return R

  ,member procedure fatal(m varchar2, msg varchar2)
  --,member procedure fatal(m varchar2, msg varchar2, throwable)

  ,member procedure info(m varchar2, msg varchar2)
  --,member procedure info(m varchar2, msg varchar2, throwable)

  ,member function isTraceEnabled(marker varchar2) return BOOLEAN
  ,member function isDebugEnabled(marker varchar2) return BOOLEAN
  ,member function isInfoEnabled(marker varchar2)  return BOOLEAN
  ,member function isWarnEnabled(marker varchar2)  return BOOLEAN
  ,member function isErrorEnabled(marker varchar2) return BOOLEAN
  ,member function isFatalEnabled(marker varchar2) return BOOLEAN

  ,member function isEnabled(lvl varchar2) return BOOLEAN
  ,member function isEnabled(lvl varchar2, marker varchar2) return BOOLEAN

  ,member procedure log(lvl varchar2, marker varchar2, msg varchar2)
  --,member procedure log(lvl varchar2, marker varchar2, msg varchar2, throwable)


  --,member function throwing(lvl varchar2, t throwable) return throwable
  --,member function throwing(t throwable) return throwable

  ,member procedure trace(m varchar2, msg varchar2)
  --,member procedure trace(m varchar2, msg varchar2, throwable)

  ,member procedure warn(m varchar2, msg varchar2)
  --,member procedure warn(m varchar2, msg varchar2, throwable)

	/* end log4 2.x */

)
;
/
show errors


create or replace type body LOGGER AS
  member function getName return VARCHAR2
	is
	begin
		return m_name;
	end;

	member function isEnabled(lvl IN VARCHAR2) return BOOLEAN
	is
	begin
		return isEnabled(lvl,NULL);
	END;
	member function isEnabled(lvl IN VARCHAR2, marker varchar2) return BOOLEAN
  is
  begin
  return LogManager.isenabled(lvl,marker);
  END;



  member function isTraceEnabled return BOOLEAN
  is
  begin
  return logmanager.ll_trace_enabled;
  END;
  member function isDebugEnabled return BOOLEAN
  is
  begin
  return logmanager.ll_debug_enabled;
  END;
  member function isInfoEnabled  return BOOLEAN
  is
  begin
  return logmanager.ll_info_enabled;
  END;
  member function isWarnEnabled  return BOOLEAN
  is
  begin
  return logmanager.ll_warn_enabled;
  END;
  member function isErrorEnabled return BOOLEAN
  is
  begin
  return logmanager.ll_error_enabled;
  END;
  member function isFatalEnabled return BOOLEAN
  is
  begin
  return logmanager.ll_fatal_enabled;
  END;
  member function isTraceEnabled(marker varchar2) return BOOLEAN
  is
  begin
  return logmanager.ll_trace_enabled;
  END;
  member function isDebugEnabled(marker varchar2) return BOOLEAN
  is
  begin
  return logmanager.ll_debug_enabled;
  END;
  member function isInfoEnabled(marker varchar2)  return BOOLEAN
  is
  begin
  return logmanager.ll_info_enabled;
  END;
  member function isWarnEnabled(marker varchar2)  return BOOLEAN
  is
  begin
  return logmanager.ll_warn_enabled;
  END;
  member function isErrorEnabled(marker varchar2) return BOOLEAN
  is
  begin
  return logmanager.ll_error_enabled;
  END;
  member function isFatalEnabled(marker varchar2) return BOOLEAN
  is
  begin
  return logmanager.ll_fatal_enabled;
  END;

  member procedure log(lvl varchar2, msg varchar2)
  is
  begin
	if isenabled(lvl,NULL) THEN
		logmanager.log(lvl,null,msg);
	end if;
  END;

  member procedure log(lvl varchar2, marker varchar2, msg varchar2)
  is
  begin
	if isenabled(lvl,marker) THEN
		LogManager.log(lvl,marker,msg);
	end if;
  END;

  member procedure entry
  is
  begin
    if isenabled(LogManager.ll_TRACE,'ENTRY')  then
			LogManager.log(LogManager.ll_TRACE,'ENTRY',NULL);
    end if;
  END;

	member procedure EXIT
	is
	begin
    if isenabled(LogManager.ll_TRACE,'EXIT')  then
			LogManager.log(LogManager.ll_TRACE,'EXIT',NULL);
		end if;
	end;

  member procedure trace(MSG varchar2)
  is
  begin
    if isenabled(LogManager.ll_TRACE,NULL)  then
			LogManager.log(LogManager.ll_TRACE,NULL,msg);
    end if;
  end;

  member procedure debug(MSG varchar2)
  is
  begin
	if isenabled(LogManager.ll_DEBUG,NULL) THEN
			LogManager.log(LogManager.ll_DEBUG,NULL,msg);
    end if;
  end;


  member procedure INFO(MSG varchar2)
  is
  begin
	if isenabled(LogManager.ll_INFO,NULL) THEN
			LogManager.log(LogManager.ll_INFO,NULL,msg);
    end if;
  end;

  member procedure WARN(MSG varchar2)
  is
  begin
    if isenabled(LogManager.ll_WARN,NULL)  then
			LogManager.log(LogManager.ll_WARN,NULL,msg);
    end if;
  end;

  member procedure error(MSG varchar2)
  is
  begin
    if isenabled(LogManager.ll_ERROR,NULL)  then
			LogManager.log(LogManager.ll_ERROR,NULL,msg);
    end if;
  end;

  member procedure fatal(msg varchar2)
  is
  begin
    if isenabled(LogManager.ll_FATAL,NULL)  then
			LogManager.log(LogManager.ll_FATAL,NULL,msg);
    end if;
  end;

  member procedure trace(m varchar2, msg varchar2)
  is
  begin
    if isenabled(LogManager.ll_TRACE,m)  then
			LogManager.log(LogManager.ll_TRACE,m,msg);
    end if;
  END;
  member procedure debug(m varchar2,MSG varchar2)
  is
  begin
	if isenabled(LogManager.ll_DEBUG,m) THEN
			LogManager.log(LogManager.ll_DEBUG,m,msg);
    end if;
  end;
  member procedure info(m varchar2, msg varchar2)
  is
  begin
    if isenabled(LogManager.ll_INFO,m)  then
			LogManager.log(LogManager.ll_INFO,m,msg);
    end if;
  END;
  member procedure warn(m varchar2, msg varchar2)
  is
  begin
    if isenabled(LogManager.ll_WARN,m)  then
			LogManager.log(LogManager.ll_WARN,m,msg);
    end if;
  END;
  member procedure error(m varchar2, msg varchar2)
  is
  begin
    if isenabled(LogManager.ll_ERROR,m)  then
			LogManager.log(LogManager.ll_ERROR,m,msg);
    end if;
  END;
  member procedure fatal(m varchar2, msg varchar2)
  is
  begin
    if isenabled(LogManager.ll_FATAL,m)  then
			LogManager.log(LogManager.ll_FATAL,m,msg);
    end if;
  END;


  member function exit(result VARCHAR2) return VARCHAR2
	is
	begin
       if isenabled(LogManager.ll_TRACE,'EXIT')  then
			 LogManager.log(LogManager.ll_TRACE,'EXIT',result);
      END IF;
		return result;
	end;
  member function exit(result NUMBER) return NUMBER
	is
	begin
     if isenabled(LogManager.ll_TRACE,'EXIT')  then
			 LogManager.log(LogManager.ll_TRACE,'EXIT',result);
      END IF;

		return result;
	end;
  member function exit(result DATE) return DATE
	is
	begin
     if isenabled(LogManager.ll_TRACE,'EXIT')  then
			 LogManager.log(LogManager.ll_TRACE,'EXIT',result);
      END IF;
		return result;
	end;
  member function exit(result TIMESTAMP WITH TIME ZONE) return TIMESTAMP WITH TIME ZONE
	is
	begin
     if isenabled(LogManager.ll_TRACE,'EXIT')  then
			 LogManager.log(LogManager.ll_TRACE,'EXIT',result);
      END IF;
		return result;
	end;

	member function exit(result BOOLEAN) return BOOLEAN
	is
	begin
   if isenabled(LogManager.ll_TRACE,'EXIT')  then
      IF result IS NULL THEN
			 LogManager.log(LogManager.ll_TRACE,'EXIT','NULL');
      ELSIF result THEN
			 LogManager.log(LogManager.ll_TRACE,'EXIT','TRUE');
       else
			 LogManager.log(LogManager.ll_TRACE,'EXIT','FALSE');
      end if;
		end if;
		return result;
	end;



end;
/
show errors


create or replace
package LogManager
as
	function GETLOGGER return LOGGER;
	function GETLOGGER(name varchar2) return LOGGER;
	function GETCLASSNAME(DEPTH number) return varchar2;


	ll_TRACE VARCHAR2(6) := 'TRACE';
	ll_DEBUG VARCHAR2(6) := 'DEBUG';
	ll_INFO VARCHAR2(6) := 'INFO';
	ll_WARN VARCHAR2(6) := 'WARN';
	ll_ERROR VARCHAR2(6) := 'ERROR';
	ll_FATAL VARCHAR2(6) := 'FATAL';
	ll_ALL VARCHAR2(6) := 'ALL';

	ll_TRACE_enabled BOOLEAN := TRUE;
	ll_DEBUG_enabled BOOLEAN := TRUE;
	ll_INFO_enabled BOOLEAN := TRUE;
	ll_WARN_enabled BOOLEAN := TRUE;
	ll_ERROR_enabled BOOLEAN := TRUE;
	ll_FATAL_enabled BOOLEAN := TRUE;

	procedure log(lvl varchar2, marker varchar2, msg varchar2);
	function isEnabled(lvl varchar2, mkr varchar2) return BOOLEAN;
end ;
/
SHOW ERRORS


create or replace
package body LOGMANAGER as
    ROOT_LOGGER_NAME CONSTANT VARCHAR2(1) := '';


procedure who_called_me( owner      out varchar2,
                        name       out varchar2,
                        lineno     OUT number,
                        caller_t   OUT varchar2 ,
                        depth number default 1)
as
   call_stack  varchar2(4096) default dbms_utility.format_call_stack;
   n           number;
   found_stack BOOLEAN default FALSE;
   line        varchar2(255);
   cnt         number := 0;
begin
--dbms_output.put_line(call_stack);
--
   loop
       n := instr( call_stack, chr(10) );
       exit when ( n is NULL or n = 0 );
--
       line := substr( call_stack, 1, n-1 );
       call_stack := substr( call_stack, n+1 );
--
       if ( NOT found_stack ) then
           if ( line like '%handle%number%name%' ) then
               found_stack := TRUE;
           end if;
       else
           cnt := cnt + 1;
           -- cnt = 1 is ME
           -- cnt = 2 is MY Caller
           -- cnt = 3 is Their Caller
           if ( cnt = (2+depth) ) then
--dbms_output.put_line('         1         2         3');
--dbms_output.put_line('123456789012345678901234567890');
--dbms_output.put_line(line);
				--format '0x70165ba0       104  package body S06DP3.LOGMANAGER'
--dbms_output.put_line('substr:'||substr( line, 14, 8 ));
               lineno := to_number(substr( line, 14, 8 ));
               line   := substr( line, 23 ); --set to rest of line .. change from 21 to 23
               if ( line like 'pr%' ) then
                   n := length( 'procedure ' );
               elsif ( line like 'fun%' ) then
                   n := length( 'function ' );
               elsif ( line like 'package body%' ) then
                   n := length( 'package body ' );
               elsif ( line like 'pack%' ) then
                   n := length( 'package ' );
               elsif ( line like 'anonymous%' ) then
                   n := length( 'anonymous block ' );
               else
                   n := null;
               end if;
               if ( n is not null ) then
                  caller_t := ltrim(rtrim(upper(substr( line, 1, n-1 ))));
               else
                  caller_t := 'TRIGGER';
               end if;

               line := substr( line, nvl(n,1) );
               n := instr( line, '.' );
               owner := ltrim(rtrim(substr( line, 1, n-1 )));
               name  := LTRIM(RTRIM(SUBSTR( LINE, N+1 )));
               exit;
           end if;
       end if;
   end loop;
end;

	function isEnabled(lvl varchar2, mkr varchar2) return BOOLEAN
	IS
	BEGIN
		RETURN (case lvl
            when 'TRACE' THEN logmanager.ll_trace_enabled
            when 'DEBUG' THEN logmanager.ll_debug_enabled
            when 'INFO' THEN logmanager.ll_info_enabled
            when 'WARN' THEN logmanager.ll_warn_enabled
            when 'ERROR' THEN logmanager.ll_error_enabled
            when 'FATAL' THEN logmanager.ll_fatal_enabled
            ELSE FALSE
            end );

	END;

procedure log(lvl varchar2, marker varchar2, msg varchar2)
	is
   owner        varchar2(30);
   NAME      VARCHAR2(30);
   lineno    number;
   caller_type      VARCHAR2(30);
	begin
		WHO_CALLED_ME( OWNER, name, LINENO, CALLER_TYPE  ,2);
	  --DBMS_OUTPUT.PUT_LINE(name||'('||lineno||') '||TO_CHAR(systimestamp,'YYYY-MM-DD"T"HH:MI:SSXFF6')||' '||RPAD(lvl,5)||rtrim(' '||marker)||' '||msg);
	  DBMS_OUTPUT.PUT_LINE(TO_CHAR(systimestamp,'YYYY-MM-DD"T"HH:MI:SSXFF6')||' '||RPAD(lvl,5)||' '||replace(name,' ')||'('||lineno||')'||rtrim(' '||marker)||' - '||msg);
	END;


	--essentially who called me at depth
	FUNCTION getClassName(depth NUMBER) RETURN VARCHAR2
	IS
   owner        varchar2(30);
   NAME      VARCHAR2(30);
   lineno    number;
   caller_type      VARCHAR2(30);
    begin
		--k_logger.entry('getClassName');
        LogManager.who_called_me( owner, name, lineno, caller_type ,depth );
		--dbms_output.put_line($$PLSQL_UNIT ||':'||loc.lineno);
		--dbms_output.put_line($$PLSQL_UNIT ||':'||loc.toString());
		--return k_logger.exit('getClassName',loc.getfqcn);
      return owner||'.'||name;
    END;


	function GetLogger(name varchar2) return LOGGER is
	begin
		--k_logger.entry('GetLogger');
		--needs to come from logger context
		--K_LOGGER.debug('create simple logger');
		return LOGGER(name);

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