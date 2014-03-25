CREATE OR REPLACE PACKAGE ut_formattinginfo
AUTHID DEFINER
IS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   -- For each program to test...
   PROCEDURE ut_test1;
END ut_formattinginfo;
/
show errors

CREATE OR REPLACE PACKAGE BODY ut_formattinginfo
IS
   PROCEDURE ut_setup
   IS
   BEGIN
      NULL;
   END;

   PROCEDURE ut_teardown
   IS
   BEGIN
      NULL;
   END;

   PROCEDURE ut_test1
   IS
	fi formattinginfo;
	buffer varchar2(2000);
   BEGIN
      -- Execute test code

		fi := formattinginfo(true,1,1);

      -- Assert success

      utAssert.this ( 'Test of formatting info', fi is not null); 
		
	buffer := '1234567890';

	fi.format(1,buffer);

      utAssert.eq (
         'Test of truncate',
			buffer, '1'
         );


		fi := formattinginfo(false,5,10);
	buffer := '1234567890';
	fi.format(7,buffer);

      utAssert.eq (
         'Test of right aligned',
			buffer, '123456 7890'
         );

		fi := formattinginfo(false,5,5);
	buffer := '1';
	fi.format(1,buffer);

      utAssert.eq (
         'Test of right align',
			buffer, '    1'
         );
      -- End of test
   END ut_test1;

END ut_formattinginfo;
/

show errors
