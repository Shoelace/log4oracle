set serveroutput on 
BEGIN
utconfig.showfailuresonly (false);
utConfig.autocompile(false);   
utconfig.showconfig;


   utPLSQL.test ('filter');
END;
/
