BEGIN
utconfig.showconfig;
utConfig.autocompile(false);   

   utSuite.add ('log4');

for x in (select distinct object_name from user_objects where object_name like 'UT#_%' escape '#' ) LOOP
  
   utPackage.add( 'log4', substr(x.object_name,4));
   --utPackage.add( 'log4', 'logger');
   --utPackage.add( 'log4', 'loglevel');
   --utPackage.add( 'log4', 'marker');
end loop;
  
  
   utPLSQL.testsuite ('log4', recompile_in => false);
END;
/
