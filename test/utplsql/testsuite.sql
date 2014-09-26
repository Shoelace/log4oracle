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

for x in (select distinct object_name , row_number() over (order by object_name) rn from user_objects where object_name like 'UT#_%' escape '#' and object_type = 'PACKAGE' order by object_name
) LOOP
 dbms_output.put_line('adding to suite:'|| substr(x.object_name,4));
   utPackage.add( 'log4', substr(x.object_name,4), seq_in => x.rn);
end loop;
  
  
   utPLSQL.testsuite ('log4', recompile_in => false);
END;
/
column ut_suite_name format a30 heading NAME

select id,name ut_suite_name,executions,failures,last_status from ut_suite;
