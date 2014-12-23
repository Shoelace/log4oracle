CREATE OR REPLACE PACKAGE BODY UTL_CALL_STACK AS

/*
TYPE stackline IS record  (
handle VARCHAR2(30),
line NUMBER,
object_name VARCHAR2(255),
caller_type varchar2(50));

TYPE callstack IS TABLE OF stackline;
*/

function getCallStack(pskip number default 0) return callstack
IS
	--orcle docs say format_call stack only returns 2000.. but might as well be safe
  call_stack  VARCHAR2(4096) DEFAULT dbms_utility.format_call_stack;
  n           NUMBER;
  found_stack BOOLEAN DEFAULT FALSE;
  line        VARCHAR2(255);
  cnt         NUMBER := 0;
  idx         NUMBER := 0;

  retval callstack := callstack();
BEGIN
--  dbms_output.put_line('in getCallstack');
--  dbms_output.put_line('###################################################');
--  dbms_output.put_line(call_stack);
--  dbms_output.put_line('###################################################');
  --
  LOOP

    n := instr( call_stack, chr(10) );
    EXIT  WHEN ( n IS NULL OR n = 0 );
    --
    line       := SUBSTR( call_stack, 1, n-1 );
    call_stack := SUBSTR( call_stack, n   +1 );
    --
    IF ( NOT found_stack ) THEN
      IF ( line LIKE '%handle%number%name%' ) THEN
--  dbms_output.put_line('found stack');
--        dbms_output.put_line('         1         2         3         4');
--        dbms_output.put_line('1234567890123456789012345678901234567890');
        found_stack := TRUE;
      END IF;
    ELSE
      cnt := cnt + 1;
      -- cnt = 1 is ME
      -- cnt = 2 is MY Caller
      -- cnt = 3 is Their Caller
      IF ( cnt > 1+pskip ) THEN --start with 1 to ignore this fake getCallStack call.

         retval.EXTEND;

         BEGIN

        --format '0x70165ba0       104  package body S06DP3.LOGMANAGER'
        idx := instr(line,' ');
--        dbms_output.put_line('handle:'||SUBSTR( line, 1, idx-1 )||'#');
        retval(retval.LAST).handle := SUBSTR( line, 1, idx-1 );
        
        line := trim(substr(line,idx+1));
        idx := instr(line,' ');

--        dbms_output.put_line('lineno:'||trim(SUBSTR( line, 1,idx-1 ))||'#');
        retval(retval.LAST).line := TO_NUMBER(trim(SUBSTR( line, 1, idx-1 )));

        line := trim(substr(line,idx+1)); --set to rest of line
--        dbms_output.put_line('prog:'|| line||'#');

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

      EXCEPTION
          WHEN OTHERS THEN
          --we cant deal with errors in this package..so just set values to something
            retval(retval.LAST).handle        := NVL(retval(retval.LAST).handle,' ');
            retval(retval.LAST).line          := nvl(retval(retval.LAST).line  , -1);
            retval(retval.LAST).caller_type   := nvl(retval(retval.LAST).caller_type  , 'unknown');
            retval(retval.LAST).object_name   := nvl(retval(retval.LAST).object_name  , 'unknown');
      END;
      END IF;
    END IF;
  END LOOP;
  return retval;
END getCallStack;


  FUNCTION subprogram(dynamic_depth IN PLS_INTEGER) RETURN UNIT_QUALIFIED_NAME AS
    cs callstack;
  BEGIN
    cs := getcallstack(1);
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
    IF qualified_name.FIRST IS NOT NULL THEN
    for i in qualified_name.first .. qualified_name.last LOOP
      retval := retval||'.'||qualified_name(i);
    END loop;
    END IF;
    RETURN LTRIM(retval,'.');
  END concatenate_subprogram;

  FUNCTION owner(dynamic_depth IN PLS_INTEGER) RETURN VARCHAR2 AS
    cs callstack;
  BEGIN
    cs := getcallstack(1);
    --RETURN subprogram(dynamic_depth)(0);
    RETURN substr(cs(dynamic_depth).object_name,1,instr(cs(dynamic_depth).object_name,'.')-1);
  END owner;

  FUNCTION unit_line(dynamic_depth IN PLS_INTEGER) RETURN PLS_INTEGER AS
    cs callstack;
  BEGIN
    cs := getcallstack(1);
    RETURN cs(dynamic_depth).line;
  END unit_line;



  FUNCTION dynamic_depth RETURN PLS_INTEGER AS
      cs callstack;
  BEGIN
    cs := getcallstack(1);
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
    cs := getcallstack(1);
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
