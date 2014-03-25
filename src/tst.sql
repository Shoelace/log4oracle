set serveroutput on size unlimited
declare
    --get instance of logger
    l Logger := logmanager.getlogger();
procedure dolog is
begin
    l.entry;
    l.trace('hello world trace');
    L.debug('hello world debug');
    l.INFO('hello world info');
    l.WARN('hello world warn');
    l.error('hello world error');
    l.FATAL('hello world fatal');
    l.exit;
end;
begin
for i in 1..2 LOOP
ThreadContext.push('level:'||i);
dolog;
ThreadContext.pop;
    l.trace('no stack');
end loop;
end;
/

