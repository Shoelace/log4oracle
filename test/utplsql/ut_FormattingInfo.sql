CREATE OR REPLACE PACKAGE ut_formattinginfo
AUTHID DEFINER
IS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   -- For each program to test...
   PROCEDURE ut_test0_create;
   PROCEDURE ut_test1_right_aligned;
   PROCEDURE ut_test2_left_aligned;
   
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
   
      PROCEDURE ut_test0_create
   IS
	fi formattinginfo;
   BEGIN
      -- Execute test code
		utassert.objexists('Looking for','FormattingInfo');
    
		fi := formattinginfo(false,1,1);

      -- Assert success

      utAssert.this ( 'Test of formatting info', fi IS NOT NULL); 
    END;
    

   PROCEDURE ut_test1_right_aligned
   IS
	fi formattinginfo;
	buffer varchar2(2000);
   BEGIN
      -- Execute test code

		fi := formattinginfo(FALSE,1,1);
    BUFFER := '1234567890';
	  fi.format(1,buffer);

      utAssert.eq (
         'Test of max length',
			    buffer, '1'
         );
		fi := formattinginfo(FALSE,6,6);
    BUFFER := '1234567890';
	  fi.format(1,buffer);

      utAssert.eq (
         'Test of max length',
			    BUFFER, '123456'
         );         
      utAssert.eq (
         'Test of max length length',
			    length(BUFFER), 6
         );           

		fi := formattinginfo(false,3,5);
	buffer := '12';
	fi.format(1,buffer);

      utAssert.eq (
         'Test of min length length',
			LENGTH(BUFFER), 3
         );

      utAssert.eq (
         'Test of min length ',
			BUFFER, ' 12'
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
         'Test of right align min=max length',
			length(BUFFER), 5
         );
      utAssert.eq (
         'Test of right align min=max ',
			buffer, '    1'
         );

      -- End of test
   END ut_test1_right_aligned;

 PROCEDURE ut_test2_left_aligned
   IS
	fi formattinginfo;
	buffer varchar2(2000);
   BEGIN
      -- Execute test code

		fi := formattinginfo(true,1,1);
	buffer := '1234567890';

	fi.format(1,buffer);

      utAssert.eq (
         'Test of truncate'||fi.toString(),
			buffer, '1'
         );
         
		fi := formattinginfo(true,4,4);
	buffer := '1234567890';
	fi.format(1,buffer);
      utAssert.eq (
         'Test of truncate'||fi.toString(),
			buffer, '1234'
         );

		fi := formattinginfo(true,3,5);
	buffer := '12';
	fi.format(1,buffer);

      utAssert.eq (
         'Test of left aligned min length'||fi.toString(),
			LENGTH(BUFFER), 3
         );

      utAssert.eq (
         'Test of min length'||fi.toString(),
			BUFFER, '12 '
         );

		fi := formattinginfo(true,1,5);
	buffer := '1234567890';
	fi.format(1,buffer);

      utAssert.eq (
         'Test of left aligned max length'||fi.toString(),
			length(BUFFER), 5
         );

      utAssert.eq (
         'Test of left aligned truncate'||fi.toString(),
			BUFFER, '12345'
         );

      -- End of test
   END ut_test2_left_aligned;
END ut_formattinginfo;
/

show errors
