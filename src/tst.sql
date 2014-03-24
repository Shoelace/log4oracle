set serveroutput on size unlimited
declare
    --get instance of logger
    l Logger := logmanager.getlogger();
begin
    l.trace('hello world trace');
    L.debug('hello world debug');
    l.INFO('hello world info');
    l.WARN('hello world warn');
    l.error('hello world error');
    l.FATAL('hello world fatal');
end;
/

