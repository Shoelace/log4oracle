CREATE OR REPLACE TYPE LoggerConfig
AS OBJECT
--under log4_object
(
m_max_retries INTEGER,
m_level LogLevel,
m_additive INTEGER,
m_includelocation INTEGER,
m_parent log4_object, --LoggerConfig
m_config Configuration

, constructor FUNCTION LoggerConfig RETURN self AS result
, constructor function LoggerConfig(name varchar2, lvl LogLevel, additive boolean) return self as result

, member function isAdditive return boolean
)
;
/


CREATE OR REPLACE TYPE BODY LoggerConfig
AS 

 constructor FUNCTION LoggerConfig RETURN self AS result
 IS
 BEGIN
    m_level := LogLevel.ERROR;
 --    m_name :=  ' ';
    m_config := NULL;
    m_additive := 1;
    m_includelocation := 1;
    
 END;
 constructor function LoggerConfig(name varchar2, lvl LogLevel, additive boolean) return self as result
  IS
 BEGIN
 NULL;
     m_level := lvl;
 --    m_name :=  ' ';
    m_config := NULL;
    m_additive := (case additive when TRUE then 1 ELSE 0 end);
    m_includelocation := 1;
 END;
 
 MEMBER FUNCTION isAdditive RETURN boolean
 IS
 BEGIN
 
         RETURN m_additive != 0;
END;
         

end;
/