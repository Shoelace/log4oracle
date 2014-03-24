CREATE OR REPLACE PACKAGE ut_messagefactory
IS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   -- For each program to test...
   PROCEDURE ut_NEWMESSAGE;
   PROCEDURE ut_NEWMESSAGE2;
   PROCEDURE ut_NEWMESSAGE3;
END ut_messagefactory;
/
show errors

CREATE OR REPLACE PACKAGE BODY ut_messagefactory
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
   -- For each program to test...
   PROCEDURE ut_NEWMESSAGE
   IS
	m message;
   BEGIN

      -- Define "control" operation


      -- Execute test code

      m := MESSAGEFACTORY.NEWMESSAGE('hello world');

      -- Assert success

      utAssert.eq (
         'Test of NEWMESSAGE',
         'hello world', m.getFormattedMessage()
         );

      -- End of test
   END ut_NEWMESSAGE;

   PROCEDURE ut_NEWMESSAGE2
   IS
      -- Verify and complete data types.
      against_this Message;
      check_this Message;
   BEGIN

      -- Define "control" operation

      against_this := NULL;

      -- Execute test code

      check_this :=
      MESSAGEFACTORY.NEWMESSAGE (
         MSG => ''
       );

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of NEWMESSAGE',
         1,
         2
         );

      -- End of test
   END ut_NEWMESSAGE2;

   PROCEDURE ut_NEWMESSAGE3
   IS
      -- Verify and complete data types.
      against_this Message;
      check_this Message;
   BEGIN

      -- Define "control" operation

      against_this := NULL;

      -- Execute test code

      check_this :=
      MESSAGEFACTORY.NEWMESSAGE (
         MSG => ''
         --,
         --PARAMS => ''
       );

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of NEWMESSAGE',
         3,
         4
         );

      -- End of test
   END ut_NEWMESSAGE3;

END ut_messagefactory;
/

show errors
