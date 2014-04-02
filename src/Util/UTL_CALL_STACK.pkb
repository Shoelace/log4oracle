CREATE OR REPLACE PACKAGE BODY UTL_CALL_STACK AS

/*
TYPE stackline IS record  (
handle VARCHAR2(30),
line NUMBER,
object_name VARCHAR2(255),
caller_type varchar2(50));

TYPE callstack IS TABLE OF stackline;
*/

function getCallStack return callstack
IS
  call_stack  VARCHAR2(4096) DEFAULT dbms_utility.format_call_stack;
  n           NUMBER;
  found_stack BOOLEAN DEFAULT FALSE;
  line        VARCHAR2(255);
  cnt         NUMBER := 0;
  
  retval callstack := callstack();
BEGIN
  --dbms_output.put_line(call_stack);
  --
  LOOP
    n := instr( call_stack, chr(10) );
    EXIT
  WHEN ( n IS NULL OR n = 0 );
    --
    line       := SUBSTR( call_stack, 1, n-1 );
    call_stack := SUBSTR( call_stack, n   +1 );
    --
    IF ( NOT found_stack ) THEN
      IF ( line LIKE '%handle%number%name%' ) THEN
        found_stack := TRUE;
      END IF;
    ELSE
      cnt := cnt + 1;
      -- cnt = 1 is ME
      -- cnt = 2 is MY Caller
      -- cnt = 3 is Their Caller
      IF ( cnt >2 ) THEN --start with 1 to ignore this fake getCallStack call.
      
         retval.extend;
       
      
        --dbms_output.put_line('         1         2         3');
        --dbms_output.put_line('123456789012345678901234567890');
        --dbms_output.put_line(line);
        --format '0x70165ba0       104  package body S06DP3.LOGMANAGER'
        retval(retval.last).handle := SUBSTR( line, 1, 13 );
        retval(retval.last).line := to_number(SUBSTR( line, 13, 8 ));
        line   := SUBSTR( line, 23 ); --set to rest of line .. change from 21 to 23
        IF ( line LIKE 'pr%' ) THEN
          n := LENGTH( 'procedure ' );
        elsif ( line LIKE 'fun%' ) THEN
          n := LENGTH( 'function ' );
        elsif ( line LIKE 'package body%' ) THEN
          n := LENGTH( 'package body ' );
        elsif ( line LIKE 'pack%' ) THEN
          n := LENGTH( 'package ' );
        elsif ( line LIKE 'anonymous%' ) THEN
          n := LENGTH( 'anonymous block ' );
        ELSE
          n := NULL;
        END IF;
        IF ( n     IS NOT NULL ) THEN
          retval(retval.last).caller_type := ltrim(rtrim(upper(SUBSTR( line, 1, n-1 ))));
        ELSE
          retval(retval.last).caller_type := 'TRIGGER';
        END IF;
        line  := SUBSTR( line, NVL(n,1) );
        retval(retval.last).object_name := ltrim(line);
        --n     := instr( line, '.' );
        --owner := ltrim(rtrim(SUBSTR( line, 1, n-1 )));
        --name  := LTRIM(RTRIM(SUBSTR( LINE, N   +1 )));

      END IF;
    END IF;
  END LOOP;
  return retval;
END getCallStack;


  FUNCTION subprogram(dynamic_depth IN PLS_INTEGER) RETURN UNIT_QUALIFIED_NAME AS
    cs callstack;
  BEGIN
    cs := getcallstack;
    --RETURN UNIT_QUALIFIED_NAME(
    --substr(cs(dynamic_depth).object_name,1, instr(cs(dynamic_depth).object_name,'.'))
    --,nvl( substr(cs(dynamic_depth).object_name,instr(cs(dynamic_depth).object_name,'.')), '__anonymous_block')
    --);
    RETURN UNIT_QUALIFIED_NAME(nvl( substr(cs(dynamic_depth).object_name,instr(cs(dynamic_depth).object_name,'.')), '__anonymous_block'));
  END subprogram;

  FUNCTION concatenate_subprogram(qualified_name IN UNIT_QUALIFIED_NAME)
           RETURN VARCHAR2 AS
    retval varchar2(2000);
  BEGIN
    for i in qualified_name.first .. qualified_name.last LOOP
      retval := retval||'.'||qualified_name(i);
    end loop;
    RETURN LTRIM(retval,'.');
  END concatenate_subprogram;

  FUNCTION owner(dynamic_depth IN PLS_INTEGER) RETURN VARCHAR2 AS
    cs callstack;
  BEGIN
    cs := getcallstack;
    --RETURN subprogram(dynamic_depth)(0);
    RETURN substr(cs(dynamic_depth).object_name,1,instr(cs(dynamic_depth).object_name,'.')-1);
  END owner;

  FUNCTION unit_line(dynamic_depth IN PLS_INTEGER) RETURN PLS_INTEGER AS
 
    cs callstack;
  BEGIN
    cs := getcallstack;
    RETURN cs(dynamic_depth).line;
  END unit_line;



  FUNCTION dynamic_depth RETURN PLS_INTEGER AS
      cs callstack;
  BEGIN
    cs := getcallstack;
    RETURN cs.count;
  END dynamic_depth;
  
  
  
-- --------------------------------
-- --------------------------------------

  FUNCTION current_edition(dynamic_depth IN PLS_INTEGER) RETURN VARCHAR2 AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.current_edition
    RETURN NULL;
  END current_edition;

  FUNCTION lexical_depth(dynamic_depth IN PLS_INTEGER) RETURN PLS_INTEGER AS
      cs callstack;
  BEGIN
    cs := getcallstack;
    return LENGTH(cs(dynamic_depth).object_name) - LENGTH(REPLACE(cs(dynamic_depth).object_name, '.'));
    --RETURN regexp_count(cs(dynamic_depth).object_name,'\.');
    --RETURN length(translate(cs(dynamic_depth).object_name,'.abcdefghijk', '.'));
  END lexical_depth;

  FUNCTION error_depth RETURN PLS_INTEGER AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.error_depth
    RETURN NULL;
  END error_depth;

  FUNCTION error_number(error_depth IN PLS_INTEGER) RETURN PLS_INTEGER AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.error_number
    RETURN NULL;
  END error_number;

  FUNCTION error_msg(error_depth IN PLS_INTEGER) RETURN VARCHAR2 AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.error_msg
    RETURN NULL;
  END error_msg;

  FUNCTION backtrace_depth RETURN PLS_INTEGER AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.backtrace_depth
    RETURN NULL;
  END backtrace_depth;

  FUNCTION backtrace_unit(backtrace_depth IN PLS_INTEGER) RETURN VARCHAR2 AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.backtrace_unit
    RETURN NULL;
  END backtrace_unit;

  FUNCTION backtrace_line(backtrace_depth IN PLS_INTEGER) RETURN PLS_INTEGER AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.backtrace_line
    RETURN NULL;
  END backtrace_line;

END UTL_CALL_STACK;
/
show errors
