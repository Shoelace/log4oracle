CREATE OR REPLACE PROCEDURE log_table_trim(p_retention INTERVAL DAY TO SECOND, p_loglevel loglevel DEFAULT NULL, p_loguser log_table.loguser%TYPE DEFAULT NULL)
AUTHID CURRENT_USER
AS

k_log logger := logmanager.getlogger();

v_now log_table.logtimestamp%TYPE := SYSTIMESTAMP;
v_llevel varchar2(2000);

v_delete_stmt VARCHAR(32000) := q'[DELETE FROM log_table WHERE logtimestamp < :retention]';

BEGIN
k_log.entry;

  IF p_loglevel IS NOT NULL THEN
    v_delete_stmt := v_delete_stmt ||' AND loglevel = :llevel' ;
    v_llevel := p_loglevel.toString();
  ELSE
    v_delete_stmt := v_delete_stmt ||' AND (1=1 OR :llevel IS NULL)' ;
  END IF;

  IF p_loguser IS NOT NULL THEN
    v_delete_stmt := v_delete_stmt ||' AND loguser = :luser' ;
  ELSE
    v_delete_stmt := v_delete_stmt ||' AND (1=1 OR :luser IS NULL)' ;
  END IF;

  k_log.debug('about to execute:'||v_delete_stmt);

  EXECUTE immediate v_delete_stmt USING (v_now - p_retention), v_llevel , p_loguser;

  k_log.debug('deleted {} records older then {}',SQL%ROWCOUNT, p_retention);


k_log.exit;

END;
/

show errors procedure log_table_trim
