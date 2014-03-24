--prompt CREATE OR REPLACE PACKAGE BODY ThreadContext 
create or replace 
package body threadcontext as

procedure put(key varchar2, value varchar2) as
  begin
    -- TODO: Implementation required for procedure THREADCONTEXT.put
    null;
  end put;

function get(key varchar2) return varchar2 as
  begin
    -- TODO: Implementation required for function THREADCONTEXT.get
    return null;
  end get;

procedure remove(key varchar2) as
  begin
    -- TODO: Implementation required for procedure THREADCONTEXT.remove
    null;
  end remove;

procedure clear as
  begin
    -- TODO: Implementation required for PROCEDURE THREADCONTEXT.clear
    null;
  end clear;

function containskey(key varchar2) return boolean as
  begin
    -- TODO: Implementation required for FUNCTION THREADCONTEXT.containsKey
    return null;
  end containskey;

function isempty return boolean  as
  begin
    -- TODO: Implementation required for function THREADCONTEXT.isEmpty
    return null;
  end isempty;

procedure clearstack as
  begin
    -- TODO: Implementation required for procedure THREADCONTEXT.clearStack
    null;
  end clearstack;

function getdepth return integer as
  begin
    -- TODO: Implementation required for function THREADCONTEXT.getDepth
    return null;
  end getdepth;

function pop return varchar2 as
  begin
    -- TODO: Implementation required for function THREADCONTEXT.pop
    return null;
  end pop;

procedure push(message varchar2) as
  begin
    -- TODO: Implementation required for PROCEDURE THREADCONTEXT.push
    null;
  end push;

procedure removestack  as
  begin
    -- TODO: Implementation required for procedure THREADCONTEXT.removeStack
    null;
  end removestack;

procedure trim(depth integer)  as
  begin
    -- TODO: Implementation required for procedure THREADCONTEXT.trim
    null;
  end trim;

END threadcontext;
/
show errors
