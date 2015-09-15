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
           FROM user_objects uo
           where object_type like 'TABLE' 
           order by (select count(*)
					from USER_CONSTRAINTS fk
					inner join USER_CONSTRAINTS bt on (fk.r_constraint_name = bt.constraint_name)
					where fk.constraint_type = 'R'
					and bt.table_name = uo.object_name) asc
           ) LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;
execute immediate 'purge recyclebin';

dbms_output.new_line;
dbms_output.put_line('-- dropping scheduler');

for x in ( SELECT 'begin DBMS_SCHEDULER.drop_'||object_type||'( ''"'||object_name||'"''); end; ' stmt
           FROM user_objects uo
           where object_type IN ('JOB','PROGRAM','CHAIN')
           order by case object_type when 'CHAIN' then 1 when 'JOB' then 2 else 3 end
           ) LOOP
dbms_output.put_line(x.stmt);
execute immediate x.stmt;
END LOOP;



dbms_output.put_line('-- dropping everything else.');

end;
/

begin
for y in 1 .. 15 LOOP
dbms_output.put_line(y);

FOR x IN (SELECT 'drop '||object_type||' '||object_name||' ' stmt
FROM user_objects
where (object_name,object_type) not in (SELECT  referenced_name, referenced_type 
          FROM USER_DEPENDENCIES where referenced_owner = USER and name != referenced_name)
and generated ='N'          
and object_type not in ('INDEX','LOB', 'TYPE BODY','PACKAGE BODY', 'JOB') ) LOOP
dbms_output.put_line(x.stmt||';');
execute immediate x.stmt;
END LOOP;
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
