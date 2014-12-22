set serveroutput on size unlimited
BEGIN
utconfig.showfailuresonly (true);
utConfig.autocompile(false);   
utconfig.showconfig;

   utSuite.rem ('log4');

   utSuite.add ('log4');
/*
SELECT up.owner, up.name
FROM ut_suite us
LEFT OUTER JOIN ut_package up ON (us.ID = up.suite_id)
and us.name = 'LOG4'
;
*/

FOR x IN (
SELECT DISTINCT object_name , row_number() OVER (ORDER BY object_name) rn 
FROM user_objects 
WHERE object_name LIKE UPPER(utConfig.prefix)||'%' ESCAPE '#' AND object_type = 'PACKAGE' 
order by object_name
) LOOP
 dbms_output.put_line('adding to suite:'|| substr(x.object_name,4));
   utPackage.ADD( 'log4', substr(x.object_name,4), seq_in => x.rn);
  --dbms_output.put_line('exec utPLSQL.test ('''||substr(x.object_name,4)||''' , recompile_in => FALSE, suite_in => ''log4'')   ;' );
end loop;
  
  
   utPLSQL.testsuite ('log4', recompile_in => false);
END;
/
column ut_suite_name format a30 heading NAME


SELECT id,owner,name ut_suite_name, description, executions, failures, last_status, last_start
FROM ut_package
WHERE suite_id IS NOT NULL
order by suite_id,seq;

SELECT ID,NAME ut_suite_name,executions,failures,last_status FROM ut_suite;
