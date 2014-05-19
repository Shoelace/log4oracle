
CREATE OR REPLACE TYPE ThreadContextMapEntry 
AUTHID DEFINER
AS OBJECT
(
KEY VARCHAR2(32000),
VALUE VARCHAR2(32000)
);
/

CREATE OR REPLACE TYPE ThreadContextContextMapIndex AS TABLE OF ThreadContextMapEntry
/

CREATE OR REPLACE TYPE ThreadContextContextMap 
AUTHID DEFINER
AS OBJECT
(
m_index ThreadContextContextMapIndex

, MEMBER PROCEDURE clear
, MEMBER FUNCTION containsKey(KEY VARCHAR2) RETURN boolean
, MEMBER FUNCTION get(KEY VARCHAR2) RETURN VARCHAR2
, MEMBER PROCEDURE put(KEY VARCHAR2, value VARCHAR2) 
--, MEMBER FUNCTION put(KEY VARCHAR2, value VARCHAR2) RETURN VARCHAR2
, MEMBER PROCEDURE remove(KEY VARCHAR2)
--functions must define self to self modify
, MEMBER FUNCTION remove(self IN OUT NOCOPY ThreadContextContextMap, KEY VARCHAR2) RETURN VARCHAR2

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
	END;

	MEMBER PROCEDURE clear
	IS
	BEGIN
		m_index := ThreadContextContextMapIndex();
	END;

	MEMBER FUNCTION containsKey(KEY VARCHAR2) RETURN boolean
	IS
	BEGIN
		IF m_index IS NOT NULL AND m_index.first IS NOT NULL THEN
			FOR i IN  m_index.FIRST .. m_index.LAST LOOP
				IF m_index.exists(i) AND m_index(i).KEY = KEY THEN
					RETURN TRUE;
				END IF;
			END LOOP;
		END IF;  
	RETURN FALSE;
	END;

	MEMBER FUNCTION get(KEY VARCHAR2) RETURN VARCHAR2
	IS
	BEGIN
		IF m_index IS NOT NULL AND m_index.first IS NOT NULL THEN
			FOR i IN  m_index.FIRST .. m_index.LAST LOOP
				IF m_index.exists(i) AND m_index(i).KEY = KEY THEN
					RETURN m_index(i).value;
				END IF;
			END LOOP;
		END IF;
    return NULL; ---or shoudl this thro no data found?
	END;

	MEMBER PROCEDURE put(KEY VARCHAR2, value VARCHAR2) 
	IS
	BEGIN

	--chekc for existign value
	IF m_index.first IS NOT NULL THEN
	FOR i IN  m_index.FIRST .. m_index.LAST LOOP
	IF m_index.EXISTS(i) AND m_index(i).KEY = KEY THEN
    --update and return
		m_index(i)  := ThreadContextMapEntry(KEY,VALUE);
		return;
	END IF;
	END LOOP;
	END IF;

  --not found add new entry
	m_index.EXTEND;
	m_index(m_index.last)  := ThreadContextMapEntry(key,value);

	NULL;
	END;
	--, MEMBER FUNCTION put(KEY VARCHAR2, value VARCHAR2) RETURN VARCHAR2
	MEMBER FUNCTION remove(self IN OUT NOCOPY ThreadContextContextMap, KEY VARCHAR2) RETURN VARCHAR2
	IS
		retval VARCHAR2(32000);
	BEGIN
		IF m_index IS NOT NULL AND m_index.first IS NOT NULL THEN
			FOR i IN  m_index.FIRST .. m_index.LAST LOOP
				IF m_index.exists(i) AND m_index(i).KEY = KEY THEN
					retval := m_index(i).value;
					m_index.delete(i);
					RETURN retval;
				END IF;
			END LOOP;
		END IF;
	RETURN NULL;
	END;
	MEMBER PROCEDURE remove(KEY VARCHAR2)
	IS
	BEGIN
		IF m_index.first IS NOT NULL THEN
			FOR i IN  m_index.FIRST .. m_index.LAST LOOP
				IF m_index.exists(i) AND m_index(i).KEY = KEY THEN
					m_index.delete(i);
					RETURN ;
				END IF;
			END LOOP;
		END IF;
		RETURN;
	END;

	MEMBER FUNCTION getsize RETURN NUMBER
	IS
	BEGIN
	RETURN m_index.count;
	END;

	MEMBER FUNCTION isEmpty RETURN BOOLEAN
	IS
	BEGIN
	RETURN m_index.count = 0;
	END;

	MEMBER FUNCTION toString RETURN VARCHAR2
	IS
	retval varchar2(32765);
	BEGIN
		IF isEmpty() THEN RETURN '{}'; END IF;

		retval := '';
		FOR i IN m_index.FIRST .. m_index.LAST LOOP
      IF m_index.EXISTS(i) THEN
			  retval := retval||', '||m_index(i).KEY||'='||m_index(i).VALUE;
      END IF;
		END LOOP;

		RETURN '{'||ltrim(retval,', ')||'}';
	END;

END ;
/
show errors

