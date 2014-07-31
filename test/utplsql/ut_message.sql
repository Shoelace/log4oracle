CREATE OR REPLACE PACKAGE ut_message
IS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   -- For each program to test...
   PROCEDURE ut_NEWMESSAGE;
   PROCEDURE ut_NEWMESSAGE2;
   PROCEDURE ut_NEWMESSAGE3;

   PROCEDURE ut_simplemessage;
   PROCEDURE ut_objectmessage;
   procedure ut_parammessage;

END ut_message;
/
show errors

CREATE OR REPLACE PACKAGE BODY ut_message
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
         'Test of NEWMESSAGE 1',
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
         MSG => Log4_sql_object('objectmessage')
       );

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of NEWMESSAGE 2',
         check_this.getformattedmessage,
         'objectmessage'
         );

      -- End of test
   END ut_NEWMESSAGE2;


   PROCEDURE ut_NEWMESSAGE3
   IS
      -- Verify and complete data types.
      against_this Message;
      check_this Message;
         prms log4_array;

   BEGIN

      -- Define "control" operation

      against_this := NULL;
      prms := log4_array(log4_sql_object(1),log4_sql_object(2),log4_sql_object(3) );
      

      -- Execute test code

      check_this :=
      MESSAGEFACTORY.NEWMESSAGE (
         MSG => '1={},2={},3={}'
         ,
         PARAMS => prms
       );

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of NEWMESSAGE 3',
         check_this.getformattedmessage,
         '1=1,2=2,3=3'
         );
         
      check_this :=
      MESSAGEFACTORY.NEWMESSAGE (
         MSG => '1={},2=\{},3={},4={},5={}'
         ,
         PARAMS => prms
       );

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of NEWMESSAGE 3',
         check_this.getformattedmessage,
         '1=1,2=\{},3=2,4=3,5={}'
         );         

      check_this :=
      MESSAGEFACTORY.NEWMESSAGE (
         MSG => '1={}'
         ,
         PARAMS => prms
       );

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of NEWMESSAGE 3',
         check_this.getformattedmessage,
         '1=1'
         );    
      -- End of test
   END ut_NEWMESSAGE3;


   PROCEDURE ut_simplemessage
   IS
      -- Verify and complete data types.
      check_this simplemessage;

   BEGIN

      -- Define "control" operation

      -- Execute test code
      check_this := simplemessage('hello world');

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of simplemessage.getformat',
         'hello world',
         check_this.getformat
         );
      utAssert.eq (
         'Test of simplemessage.getformattedmessage',
         'hello world',
         check_this.getformattedmessage
         );

      utAssert.this (
         'Test of simplemessage.getthrowable is null',
                  check_this.getthrowable() IS NULL
         );

      utAssert.this (
         'Test of simplemessage.getparameters is null',
                  check_this.getparameters() IS NULL
         );


      -- End of test
   END ut_simplemessage;

 PROCEDURE ut_objectmessage
   IS
      -- Verify and complete data types.
      check_this objectmessage;

   BEGIN

      -- Define "control" operation

      -- Execute test code
      check_this := objectmessage(log4_sql_object('hello world'));

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of objectmessage.getformat',
         'hello world',
         check_this.getformat
         );
      utAssert.eq (
         'Test of objectmessage.getformattedmessage',
         'hello world',
         check_this.getformattedmessage
         );

      utAssert.this (
         'Test of objectmessage.getthrowable is null',
                  check_this.getthrowable() IS NULL
         );

      utAssert.this (
         'Test of objectmessage.getparameters is not null',
                  check_this.getparameters() IS NOT NULL
         );

      -- End of test
   END ut_objectmessage;

PROCEDURE ut_parammessage
IS
      -- Verify and complete data types.
      check_this ParameterizedMessage;
         prms log4_array;

   BEGIN
      prms := log4_array(log4_sql_object(1),log4_sql_object(2),log4_sql_object(3) );
      
      -- Define "control" operation

      -- Execute test code
      check_this := ParameterizedMessage('1={},2={},3={}',prms);

      -- Assert success

      -- Compare the two values.
      utAssert.eq (
         'Test of ParameterizedMessage.getformat',
         check_this.getformat,
         '1={},2={},3={}'
         );
      utAssert.eq (
         'Test of ParameterizedMessage.getformattedmessage',
         check_this.getformattedmessage,
         '1=1,2=2,3=3'
         );

      utAssert.this (
         'Test of ParameterizedMessage.getthrowable is null',
                  check_this.getthrowable() IS NULL
         );

      utAssert.this (
         'Test of ParameterizedMessage.getparameters is not null',
                  check_this.getparameters() IS NOT NULL
         );

      -- End of test
   END ut_parammessage;

END ut_message;
/

show errors
