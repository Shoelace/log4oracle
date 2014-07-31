set serveroutput on 
BEGIN
utconfig.showfailuresonly (false);
utconfig.showconfig;
utConfig.autocompile(false);   


   utPLSQL.test ('layout');
END;
/
