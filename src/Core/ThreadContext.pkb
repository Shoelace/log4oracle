--prompt CREATE OR REPLACE PACKAGE BODY ThreadContext 
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
  end trim;

END threadcontext;
/
show errors
