prompt CREATE OR REPLACE TYPE NullConfiguration 

CREATE OR REPLACE TYPE NullConfiguration 
UNDER Configuration
(

 constructor function NullConfiguration  return self as result

);
/
show errors

create or replace
TYPE body NullConfiguration 
AS
  constructor function NullConfiguration return self as result
	as
	BEGIN
		--dbms_output.put_line('MarkerImpl(name):'||name);
		self.m_name := 'Null';
		--k_layout := PatternLayout('%date %5level %logger - %marker - %l - %m %ex%n');
 --final LoggerConfig root = getRootLogger();
--065            root.addAppender(appender, null, null);
--root.setLevel(LogLevel.OFF);

		return;
	end;

--@Override
--074        protected void doConfigure() {
--075        }

end;
/
show errors

