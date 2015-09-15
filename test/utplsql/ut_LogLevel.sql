
create or replace package ut_LogLevel
AUTHID DEFINER
AS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;
 
   PROCEDURE ut_LogLevel_1;
   PROCEDURE ut_LogLevel_2;
   PROCEDURE ut_LogLevel_3;

   PROCEDURE ut_LogLevel_4;

   PROCEDURE ut_LogLevel_5;
   
   PROCEDURE ut_LogLevel_6;

END;
/
show errors

create or replace package body ut_LogLevel
AS
 PROCEDURE ut_setup IS
   BEGIN
      NULL;
   END;
 
   PROCEDURE ut_teardown
   IS
   BEGIN
      NULL;
   END;
   PROCEDURE ut_LogLevel_1
	IS
	BEGIN
		utassert.objexists('Looking for','LogLevel');
	END;
   
   PROCEDURE ut_LogLevel_2
	IS
		ll LogLevel;
		ll2 LogLevel;

	BEGIN
		utassert.this('uninitialised is null',ll is null);
		ll := LogLevel(5);
		utassert.this('basic creation was successfull',ll is not null);

		utassert.eq('check value', ll.intLevel , 5);

	END;

	PROCEDURE ut_LogLevel_3
	IS
		ll LogLevel;
		prev_ll LogLevel;
		l_vals log4_array;
		i integer;

	BEGIN
		l_vals := LogLevel.vals();

		utassert.this('LogLevel.vals() returns array',l_vals is not null);

		i := l_vals.count;

		utassert.this('Levels are defined',i > 0);
		i := l_vals.FIRST;  -- get subscript of first element
		WHILE i IS NOT NULL LOOP
		   ---- do something with courses(i) 
			ll := treat ( l_vals(i) as loglevel);
			if prev_ll is not null THEN
				utassert.this('incrementing levels:'||ll.tostring||' > '||prev_ll.tostring, ll > prev_ll);
			END IF;
--
			prev_ll :=  ll;
		   i := l_vals.NEXT(i);  -- get subscript of next element
		END LOOP;

	END;
  
     PROCEDURE ut_LogLevel_4
	IS
  ll loglevel;

	BEGIN
    ll := LogLevel.TRACE;
		utassert.eq('tostring()',ll.toString(),'TRACE');

    ll := LogLevel.DEBUG;
		utassert.eq('tostring()',ll.toString(),'DEBUG');

    ll := LogLevel.INFO;
		utassert.eq('tostring()',ll.toString(),'INFO');

    ll := LogLevel.WARN;
		utassert.eq('tostring()',ll.toString(),'WARN');

    ll := LogLevel.ERROR;
		utassert.eq('tostring()',ll.toString(),'ERROR');

    ll := LogLevel.FATAL;
		utassert.eq('tostring()',ll.toString(),'FATAL');

    ll := LogLevel.OFF;
		utassert.eq('tostring()',ll.toString(),'OFF');

    ll := LogLevel.ll_ALL;
		utassert.eq('tostring()',ll.toString(),'ALL');

    ll := LogLevel(999);
		utassert.eq('tostring()',ll.toString(),'CUSTOM');

	END;

     PROCEDURE ut_LogLevel_5
	IS
  ll loglevel;

	BEGIN  
   ll := LogLevel.DEBUG;

		utassert.this('DEBUG isMoreSpecificThan TRACE',ll.isMoreSpecificThan(loglevel.TRACE));

		utassert.this('DEBUG NOT isMoreSpecificThan INFO',NOT ll.isMoreSpecificThan(loglevel.INFO));
END;
    

     PROCEDURE ut_LogLevel_6
	IS
  ll loglevel;

  ll2 loglevel;

	BEGIN  
    ll := LogLevel.tolevel('ALL');
    ll2 := loglevel.ll_ALL;

		utassert.eq('tolevel(ALL) = loglevel.all',ll.intlevel, ll2.intlevel);

    ll := LogLevel.tolevel('debug');
    ll2 := loglevel.debug;

		utassert.eq('tolevel(debug) = loglevel.debug',ll.intlevel, ll2.intlevel);

    ll := LogLevel.tolevel('debug');
    ll2 := loglevel.debug;

		utassert.eq('tolevel(debug) = loglevel.debug',ll.intlevel, ll2.intlevel);


    ll := LogLevel.tolevel('unknown');
    ll2 := loglevel.DEBUG;
		utassert.eq('tolevel(unknown) = loglevel.debug',ll.intlevel, ll2.intlevel);

    ll := LogLevel.tolevel('unknown', loglevel.INFO);
    ll2 := loglevel.INFO;
		utassert.eq('tolevel(unknown,info) = loglevel.info',ll.intlevel, ll2.intlevel);


		--utassert.this('DEBUG NOT isAtLeastAsSpecificAs INFO',NOT ll.isAtLeastAsSpecificAs(loglevel.INFO));
   END;

END;
/
show errors

