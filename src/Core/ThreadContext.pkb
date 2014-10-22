Prompt CREATE OR REPLACE PACKAGE BODY ThreadContext 
create or replace 
package body threadcontext as

  k_contextMap ThreadContextContextMap := new ThreadContextContextMap();
  k_contextStack ThreadContextContextStack := new ThreadContextContextStack();

  procedure put(key varchar2, value varchar2) as
  begin
    -- TODO: Implementation required for procedure THREADCONTEXT.put
    k_contextMap.put(key,value);
  end put;

  function get(key varchar2) return varchar2 as
  begin
    -- TODO: Implementation required for function THREADCONTEXT.get
    RETURN k_contextMap.get(key);
  end get;

  procedure remove(key varchar2) as
  begin
    -- TODO: Implementation required for procedure THREADCONTEXT.remove
    k_contextMap.remove(key);
  end remove;

  procedure clear as
  begin
    k_contextMap.clear;
  END CLEAR;

  function containskey(key varchar2) return boolean as
  begin
    RETURN k_contextMap.containskey(key);
  end containskey;

  function isempty return boolean  as
  BEGIN
    return k_contextMap.isempty;
  end isempty;


--stack methos below
  procedure clearstack as
  begin
    k_contextStack.CLEAR;
  END clearstack;
  
  function cloneStack return ThreadContextContextStack AS
  begin
    RETURN k_contextStack;
  END cloneStack;

  function cloneMap return ThreadContextContextMap AS
  BEGIN
    RETURN k_contextMap;
  END cloneMap;

  function getdepth return integer as
  BEGIN
    RETURN k_contextStack.getDepth();
  end getdepth;

  function pop return varchar2 as
  begin
    RETURN k_contextStack.pop();
  END pop;
  PROCEDURE pop AS
   dummy varchar2(32000);
  begin
    dummy := k_contextStack.pop();
    return;
  END pop;


  procedure push(message varchar2) as
  begin
    k_contextStack.push(message);
  END push;

  procedure removestack  as
  BEGIN
     k_contextStack.clear;
  END removestack;

  procedure trim(depth integer)  as
  begin
    k_contextStack.trim(depth);
  END trim;

BEGIN
--pre populate threadcontext with system info

put('instance'     , SYS_CONTEXT('USERENV', 'INSTANCE') );
put('instance_name', SYS_CONTEXT('USERENV', 'INSTANCE_NAME'));
put('db_domain'    , SYS_CONTEXT('USERENV', 'DB_DOMAIN'));
put('db_name'      , SYS_CONTEXT('USERENV', 'DB_NAME'));

$if (dbms_db_version.version >=11  and dbms_db_version.release >=2) OR (dbms_db_version.version >= 12 ) $then
put('db_role'      , SYS_CONTEXT('USERENV', 'DATABASE_ROLE'));
$end

put('server_host'  , SYS_CONTEXT ('USERENV', 'SERVER_HOST'));
put('service_name' , SYS_CONTEXT ('USERENV', 'SERVICE_NAME'));

put('client_ip'    , SYS_CONTEXT('USERENV', 'IP_ADDRESS'));
put('session_id'   , SYS_CONTEXT('USERENV', 'SESSIONID'));

put('os_user'      , SYS_CONTEXT('USERENV', 'OS_USER'));
put('host'         , SYS_CONTEXT('USERENV', 'HOST'));

put('session_user' , SYS_CONTEXT('USERENV', 'SESSION_USER'));
put('terminal'     , SYS_CONTEXT('USERENV', 'TERMINAL'));

END threadcontext;
/
show errors
