prompt CREATE OR REPLACE TYPE DefaultConfiguration 

CREATE OR REPLACE TYPE DefaultConfiguration 
UNDER Configuration
(

 constructor function DefaultConfiguration  return self as result

);
/
show errors

create or replace
TYPE body DefaultConfiguration 
AS
  constructor function DefaultConfiguration return self as result
	as
		app Appender;
		k_layout layout;
	BEGIN
		--dbms_output.put_line('MarkerImpl(name):'||name);
		self.m_name := 'DEFAULT';
		--k_layout := PatternLayout('%date %5level %logger - %marker - %l - %m %ex%n');

		k_layout := PatternLayout('%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n' );

		app := DBMSOutputAppender('dbmsoutput',null,k_layout,false);
		--addAppender(app);
 --final LoggerConfig root = getRootLogger();
--065            root.addAppender(appender, null, null);
--root.setLevel(LogLevel.ERROR);

		return;
	end;

--@Override
--074        protected void doConfigure() {
--075        }

end;
/
show errors

