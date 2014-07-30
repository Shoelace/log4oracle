set serveroutput on
declare
cnt NUMBER;
begin
dbms_output.put_line('-- statements to drop all user_objects in order of dependency');

dbms_output.put_line('-- dropping packages');

for x in (SELECT 'drop '||object_type||' '||object_name||' ' stmt
          FROM user_objects
          where object_type like 'PACKAGE') LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;
dbms_output.new_line;
dbms_output.put_line('-- dropping tables');

for x in ( SELECT 'drop '||object_type||' '||object_name||' purge' stmt
           FROM user_objects
           where object_type like 'TABLE' ) LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;

dbms_output.put_line('-- dropping everything else.');

for y in 1 .. 15 LOOP
dbms_output.new_line;

FOR x IN (SELECT 'drop '||object_type||' '||object_name||' ' stmt
FROM user_objects
where (object_name,object_type) not in (SELECT  referenced_name, referenced_type 
          FROM USER_DEPENDENCIES where referenced_owner = USER and name != referenced_name)
and generated ='N'          
and object_type not in ('INDEX','LOB', 'TYPE BODY','PACKAGE BODY') ) LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;
END LOOP;

end;
/
