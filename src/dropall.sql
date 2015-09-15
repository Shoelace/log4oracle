alter session set ddl_lock_timeout = 5;

set serveroutput on
begin
dbms_output.put_line('-- statements to drop all user_objects in order of dependency');

dbms_output.put_line('-- dropping packages');

for x in (SELECT 'drop '||object_type||' '||object_name||' ' stmt
          FROM user_objects
          where object_type like '% BODY') LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;
for x in (SELECT 'drop '||object_type||' '||object_name||' ' stmt
          FROM user_objects
          where object_type like 'PACKAGE') LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;
end;
/

begin
dbms_output.new_line;
dbms_output.put_line('-- dropping tables');

for x in ( SELECT 'drop '||object_type||' '||object_name||' purge' stmt
           FROM user_objects
           where object_type like 'TABLE' ) LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;
execute immediate 'purge recyclebin';

dbms_output.put_line('-- dropping everything else.');

end;
/
declare
c number :=0;
d number :=0;
begin
for y in 1 .. 1 LOOP
dbms_output.put_line(y);

c:=0;
FOR x IN (SELECT 'drop '||object_type||' '||object_name||' ' stmt
FROM user_objects
where (object_name,object_type) not in (SELECT  referenced_name, referenced_type 
          FROM USER_DEPENDENCIES where referenced_owner = USER and name != referenced_name)
and generated ='N'          
and object_type not in ('INDEX','LOB', 'TYPE BODY','PACKAGE BODY') ) LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
c := c+1;
END LOOP;

exit when c = 0;
d := 0;
END LOOP;
end;
/

begin
dbms_output.put_line('-- dropping public synonyms .');
FOR x IN (
SELECT 'drop public synonym '||synonym_name||' ' stmt
FROM all_synonyms
where 1=1
AND owner = 'PUBLIC' AND table_owner = USER) LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;


end;
/
