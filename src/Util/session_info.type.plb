CREATE OR REPLACE TYPE BODY session_info 
AS
--sys_context returns varchar2(256)
  constructor function session_info return self as result as
  begin
        client_ip := SYS_CONTEXT('USERENV', 'IP_ADDRESS');
        session_id := SYS_CONTEXT('USERENV', 'SESSIONID');

        oS_user := SYS_CONTEXT('USERENV', 'OS_USER');
        Host := SYS_CONTEXT('USERENV', 'HOST');
        module := SYS_CONTEXT('USERENV', 'MODULE');
        action := SYS_CONTEXT('USERENV', 'ACTION');
        Client_info := SYS_CONTEXT('USERENV', 'CLIENT_INFO');

        Session_user := SYS_CONTEXT('USERENV', 'SESSION_USER');
        terminal := SYS_CONTEXT('USERENV', 'TERMINAL');

        fg_job_id := SYS_CONTEXT('USERENV', 'FG_JOB_ID');
        bg_job_id := SYS_CONTEXT('USERENV', 'BG_JOB_ID');

 <<debug_web_variables>>
   BEGIN
      FOR i IN 1 .. OWA.num_cgi_vars
      LOOP
         cgi_vars  :=
               cgi_vars
            || OWA.cgi_var_name (i)
            || ': '
            || OWA.cgi_var_val (i)
            || CHR (10);
      END LOOP;
   EXCEPTION
      WHEN VALUE_ERROR
      THEN
         NULL;
   END debug_web_variables;


    return;
  end;
end;
/
show errors

