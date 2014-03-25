create or replace PACKAGE BODY UTL_CALL_STACK AS

PROCEDURE who_called_me
(
    owner OUT VARCHAR2,
    name OUT VARCHAR2,
    lineno OUT NUMBER,
    caller_t OUT VARCHAR2 ,
    depth NUMBER DEFAULT 1)
AS
--depth based version
  call_stack  VARCHAR2(4096) DEFAULT dbms_utility.format_call_stack;
  n           NUMBER;
  found_stack BOOLEAN DEFAULT FALSE;
  line        VARCHAR2(255);
  cnt         NUMBER := 0;
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
      IF ( cnt = (2+depth) ) THEN
        --dbms_output.put_line('         1         2         3');
        --dbms_output.put_line('123456789012345678901234567890');
        --dbms_output.put_line(line);
        --format '0x70165ba0       104  package body S06DP3.LOGMANAGER'
        lineno := to_number(SUBSTR( line, 13, 8 ));
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
          caller_t := ltrim(rtrim(upper(SUBSTR( line, 1, n-1 ))));
        ELSE
          caller_t := 'TRIGGER';
        END IF;
        line  := SUBSTR( line, NVL(n,1) );
        n     := instr( line, '.' );
        owner := ltrim(rtrim(SUBSTR( line, 1, n-1 )));
        name  := NVL(LTRIM(RTRIM(SUBSTR( LINE, N   +1 ))),'__anonymous_block');
        EXIT;
      END IF;
    END IF;
  END LOOP;
END who_called_me;


  FUNCTION subprogram(dynamic_depth IN PLS_INTEGER) RETURN UNIT_QUALIFIED_NAME AS
    owner  VARCHAR2(200);
    name  VARCHAR2(200);
    lineno  NUMBER;
    caller_t VARCHAR2(200) ;
 
  BEGIN
    who_called_me(owner,name,lineno,caller_t,dynamic_depth);
    RETURN UNIT_QUALIFIED_NAME(name);
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
    owner  VARCHAR2(200);
    name  VARCHAR2(200);
    lineno  NUMBER;
    caller_t VARCHAR2(200) ;
 
  BEGIN
    who_called_me(owner,name,lineno,caller_t,dynamic_depth);
    RETURN owner;
  END owner;

  FUNCTION unit_line(dynamic_depth IN PLS_INTEGER) RETURN PLS_INTEGER AS
 
    owner  VARCHAR2(200);
    name  VARCHAR2(200);
    lineno  NUMBER;
    caller_t VARCHAR2(200) ;
 
  BEGIN
    who_called_me(owner,name,lineno,caller_t,dynamic_depth);
    RETURN lineno;
  END unit_line;



  FUNCTION dynamic_depth RETURN PLS_INTEGER AS
--depth based version
  call_stack  VARCHAR2(4096) DEFAULT dbms_utility.format_call_stack;
  n           NUMBER;
  found_stack BOOLEAN DEFAULT FALSE;
  line        VARCHAR2(255);
  cnt         NUMBER := 0;
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
    end if;
  end loop;
  
  return cnt;    
      
  END dynamic_depth;
  
  
  
-- --------------------------------
-- --------------------------------------

  FUNCTION current_edition(dynamic_depth IN PLS_INTEGER) RETURN VARCHAR2 AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.current_edition
    RETURN NULL;
  END current_edition;

  FUNCTION lexical_depth(dynamic_depth IN PLS_INTEGER) RETURN PLS_INTEGER AS
  BEGIN
    -- TODO: Implementation required for FUNCTION UTL_CALL_STACK.lexical_depth
    RETURN NULL;
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
