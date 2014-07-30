prompt CREATE OR REPLACE TYPE UTLFILEURITYPE

CREATE OR REPLACE TYPE UTLFILEURITYPE
authid current_user under UriType
(
  -- url varchar2(4000),
  directory_name VARCHAR2(30), --all_directories.directory_name%type,

  overriding member function getClob RETURN clob,
  -- get the blob value of the output
  overriding MEMBER FUNCTION getBlob RETURN BLOB,
  constructor FUNCTION UTLFILEURITYPE(url IN VARCHAR2)   RETURN self AS result,
  static function createUri(utlfileuri in varchar2) return UTLFILEURITYPE,
  
  overriding MEMBER FUNCTION getExternalUrl RETURN VARCHAR2 deterministic,
  overriding MEMBER FUNCTION getUrl RETURN VARCHAR2 deterministic,
  
  
   overriding member function getXML return sys.XMLType
  /*

  -- returns the lob value of the pointed URL
  overriding member function getBlob(csid IN NUMBER) RETURN blob,

  -- new fcns in 9.2
  overriding member function getXML return sys.XMLType,

  overriding member function getContentType RETURN varchar2,
  overriding member function getClob(content OUT varchar2) RETURN clob,
  overriding member function getBlob(content OUT varchar2) RETURN blob,
  overriding member function getXML(content OUT varchar2)
    RETURN sys.XMLType
    */
);
/
show errors

CREATE OR REPLACE TYPE BODY UTLFILEURITYPE
AS

  overriding MEMBER FUNCTION getClob RETURN CLOB
    IS
  BEGIN
  --bfile (directory_name, url)
  --dbms_lob.loadfromfile()
    return q'[<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="debug" strict="true" name="XMLConfigTest">
  <Properties>
    <Property name="filename">target/test.log</Property>
  </Properties>
  <Filter type="ThresholdFilter" level="trace"/>
 
  <Appenders>
    <Appender type="Console" name="STDOUT">
      <Layout type="PatternLayout" pattern="%m MDC%X%n"/>
      <Filters>
        <Filter type="MarkerFilter" marker="FLOW" onMatch="DENY" onMismatch="NEUTRAL"/>
        <Filter type="MarkerFilter" marker="EXCEPTION" onMatch="DENY" onMismatch="ACCEPT"/>
      </Filters>
    </Appender>
    <Appender type="Console" name="FLOW">
      <Layout type="PatternLayout" pattern="%C{1}.%M %m %ex%n"/><!-- class and line number -->
      <Filters>
        <Filter type="MarkerFilter" marker="FLOW" onMatch="ACCEPT" onMismatch="NEUTRAL"/>
        <Filter type="MarkerFilter" marker="EXCEPTION" onMatch="ACCEPT" onMismatch="DENY"/>
      </Filters>
    </Appender>
    <Appender type="File" name="File" fileName="${filename}">
      <Layout type="PatternLayout">
        <Pattern>%d %p %C{1.} [%t] %m%n</Pattern>
      </Layout>
    </Appender>
    <Appender type="List" name="List">
    </Appender>
  </Appenders>
 
  <Loggers>
    <Logger name="org.apache.logging.log4j.test1" level="debug" additivity="false">
      <Filter type="ThreadContextMapFilter">
        <KeyValuePair key="test" value="123"/>
      </Filter>
      <AppenderRef ref="STDOUT"/>
    </Logger>
 
    <Logger name="org.apache.logging.log4j.test2" level="debug" additivity="false">
      <AppenderRef ref="File"/>
    </Logger>
 
    <Root level="trace">
      <AppenderRef ref="List"/>
    </Root>
  </Loggers>
 
</Configuration>]';

  END;
  
  overriding MEMBER FUNCTION getBlob RETURN BLOB
  IS
  BEGIN
    RETURN NULL;
  END;
  constructor FUNCTION UTLFILEURITYPE(url IN VARCHAR2)   RETURN self AS result
  IS
  BEGIN
    IF url LIKE '/%' THEN
      self.directory_name := 'LOG4_CONFIG';
      self.url := url;
    ELSE
      self.directory_name := substr(url,1, instr(url,'/')-1);
      self.url := substr(url,instr(url,'/'));
    END IF;
    return;
  END;
    
  STATIC FUNCTION createUri(utlfileuri IN VARCHAR2) RETURN UTLFILEURITYPE
  IS
  BEGIN
    return UTLFILEURITYPE(utlfileuri);
  END;
  
  overriding MEMBER FUNCTION getExternalUrl RETURN VARCHAR2 deterministic
  IS
  BEGIN
    RETURN 'utlfile:/$'||directory_name||'#'||url;
  END;  
  overriding MEMBER FUNCTION getUrl RETURN VARCHAR2 deterministic  
    IS
  BEGIN
    RETURN 'utlfile:/$'||directory_name||'#'||url;
  END;
  
  overriding MEMBER FUNCTION getXML RETURN sys.XMLTYPE
  IS
  BEGIN
    return XMLTYPE.createXML(getClob());
  END;
end;
/
show errors

exec SYS.URIFACTORY.registerurlhandler('utlfile://',USER,'UTLFILEURITYPE');
