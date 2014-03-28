
CREATE OR REPLACE TYPE ThreadContextMapEntry 
AS OBJECT
(
KEY VARCHAR2(32000),
VALUE VARCHAR2(32000)
);
/

CREATE OR REPLACE TYPE ThreadContextContextMapIndex AS TABLE OF ThreadContextMapEntry
/

CREATE OR REPLACE TYPE ThreadContextContextMap 
AS OBJECT
(
m_index ThreadContextContextMapIndex

, MEMBER PROCEDURE clear
, MEMBER FUNCTION containsKey(KEY VARCHAR2) RETURN boolean
, MEMBER FUNCTION get(KEY VARCHAR2) RETURN VARCHAR2
, MEMBER PROCEDURE put(KEY VARCHAR2, value VARCHAR2) 
--, MEMBER FUNCTION put(KEY VARCHAR2, value VARCHAR2) RETURN VARCHAR2
, MEMBER FUNCTION remove(KEY VARCHAR2) RETURN VARCHAR2
, MEMBER PROCEDURE remove(KEY VARCHAR2)
, MEMBER FUNCTION getsize RETURN NUMBER
, MEMBER FUNCTION isEmpty RETURN BOOLEAN
, MEMBER FUNCTION toString RETURN VARCHAR2
,constructor FUNCTION ThreadContextContextMap RETURN self AS result

);
/
show errors

CREATE OR REPLACE TYPE BODY ThreadContextContextMap 
AS 
constructor FUNCTION ThreadContextContextMap RETURN self AS result
IS
BEGIN
m_index := ThreadContextContextMapIndex();
RETURN;
end;

 MEMBER PROCEDURE clear
is
begin
 null;
end;
 MEMBER FUNCTION containsKey(KEY VARCHAR2) RETURN boolean
is
begin
 return false;
end;
 MEMBER FUNCTION get(KEY VARCHAR2) RETURN VARCHAR2
is
begin
 return null;
end;
 MEMBER PROCEDURE put(KEY VARCHAR2, value VARCHAR2) 
is
BEGIN

m_index.EXTEND;
m_index(m_index.last)  := ThreadContextMapEntry(key,value);

 null;
end;
--, MEMBER FUNCTION put(KEY VARCHAR2, value VARCHAR2) RETURN VARCHAR2
 MEMBER FUNCTION remove(KEY VARCHAR2) RETURN VARCHAR2
is
begin
 return null;
end;
 MEMBER PROCEDURE remove(KEY VARCHAR2)
is
begin
 null;
end;
 MEMBER FUNCTION getsize RETURN NUMBER
is
begin
 return m_index.count;
end;
 MEMBER FUNCTION isEmpty RETURN BOOLEAN
is
begin
 return m_index.count = 0;
end;
 MEMBER FUNCTION toString RETURN VARCHAR2
is
retval varchar2(32000);
begin
	if isEmpty() then return '{}'; end if;

	retval := '';
	for i in m_index.first .. m_index.last LOOP
		retval := retval||', '||m_index(i).key||'='||m_index(i).value;
	END LOOP;
	
 return '{'||ltrim(retval,', ')||'}';
end;

END;
/
show errors

