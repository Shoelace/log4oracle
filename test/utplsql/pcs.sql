create or replace
  procedure Print_Call_Stack
  as
k_log Logger := logmanager.getlogger();
   -- Depth pls_integer := UTL_Call_Stack.Dynamic_Depth();
   procedure headers
   is
   begin
       dbms_output.put_line( 'Lexical   Depth   Line    Name' );
       dbms_output.put_line( 'Depth             Number      ' );
       dbms_output.put_line( '-------   -----   ----    ----' );
   end headers;
   procedure print
   is
    Depth pls_integer := UTL_Call_Stack.Dynamic_Depth();
   begin
k_log.entry;
       headers;
k_log.info('depth is set as:'||depth);
       for j in reverse 1..Depth loop
         DBMS_Output.Put_Line(
           rpad( utl_call_stack.lexical_depth(j), 10 ) ||
                   rpad( j, 7) ||
           rpad( To_Char(UTL_Call_Stack.Unit_Line(j), '99'), 9 ) ||
           UTL_Call_Stack.Concatenate_Subprogram
                      (UTL_Call_Stack.Subprogram(j)));
       end loop;
k_log.exit;
   end;
procedure p3
is
procedure p2
is
begin
k_log.entry;
print;
k_log.exit;
end;
begin
k_log.entry;
p2;
k_log.exit;
end;
 begin
k_log.entry;
   p3;
k_log.exit;
 end;
/
