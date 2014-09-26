drop user log4 cascade;
CREATE USER log4 IDENTIFIED BY log4;
GRANT CONNECT, RESOURCE TO log4;
GRANT UNLIMITED TABLESPACE TO log4;


grant create procedure to log4;
grant create sequence to log4;
grant create table to log4;
grant create type to log4;
grant create view to log4;

--some system grants as DBA or SYSDBA
grant under on uritype to log4;


-- optional grants
grant SELECT ANY DICTIONARY to log4;

--
grant create synonym to log4;

--public synonyms useless for editioning
--grant create public synonym to log4;

--needed for AQ impl. not current used
--GRANT aq_administrator_role TO log4;
--GRANT EXECUTE ON dbms_aq TO log4;
--GRANT EXECUTE ON dbms_aqadm TO log4;
