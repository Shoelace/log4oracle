set serveroutput on size unlimited
alter package logimpl compile;
alter package threadcontext compile;
alter package patternparser compile;

declare
    --get instance of logger
    l Logger := logmanager.getlogger('mytestlogger');
    
procedure mydolog is
procedure dolog is
v number;
begin
    l.entry;
    l.trace('hello world trace');
    L.debug('hello world debug');
    l.INFO('hello world info');
    l.WARN('hello world warn');
    l.error('hello world error');
    l.FATAL('hello world fatal');
    L.DEBUG('hello world debug');
    v := l.exit(3);
end;
begin
ThreadContext.push('level1');
ThreadContext.put('level','1');
ThreadContext.put('batch_id','crap');
--print_call_stack;
dolog;
raise no_data_found;
end;

BEGIN
--  dolog;
  mydolog;
exception
when others then
l.catching();
end;
/
/*
DECLARE
      cs utl_call_stack.callstack;
    --Depth pls_integer := UTL_Call_Stack.Dynamic_Depth();
  BEGIN
  dbms_output.put_line(dbms_utility.format_call_stack);  
 --dbms_output.put_line('depth:'||Depth);  
    cs := utl_call_stack.getcallstack;
       FOR j IN  cs.FIRST..cs.LAST loop
         DBMS_Output.Put_Line( utl_lms.format_message('%s - %s - %s - %s', cs(j).handle , to_char(cs(j).line), cs(j).caller_type, cs(j).object_name ) );
      
       end loop;
end;

*/
