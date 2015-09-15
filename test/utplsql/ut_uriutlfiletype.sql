CREATE OR REPLACE PACKAGE ut_UTLFILEURITYPE
IS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   -- For each program to test...
   PROCEDURE ut_test_1;
   PROCEDURE ut_test_2;
   PROCEDURE ut_test_3;


END ut_UTLFILEURITYPE;
/
show errors

CREATE OR REPLACE PACKAGE BODY ut_UTLFILEURITYPE
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
   PROCEDURE ut_test_1
   IS
      u VARCHAR2(200) := 'GITHUB/test.txt';
	    m URITYPE;
   BEGIN

      -- Define "control" operation

      utAssert.objexists('test','UTLFILEURITYPE');
      -- Execute test code

      m := UTLFILEURITYPE(u);

      -- Assert success

      utAssert.this (
         'Test of UTLFILEURITYPE',
         m is not null
         );

      utAssert.eq (
         'Test of UTLFILEURITYPE.getUrl',
         m.getUrl,
         'utlfile://'||u
         );             

      -- End of test
   END ut_test_1;
   
  PROCEDURE ut_test_2
   IS
   u VARCHAR2(200) := 'utlfile://'||'GITHUB/test.txt';
	    m URITYPE;
   BEGIN

      m := UriFactory.getUri(u);
      
      utAssert.this (
         'Test of UriFactory.getUri',
         m IS NOT NULL
         );      

      utAssert.eq (
         'Test of UTLFILEURITYPE.getExternalUrl',
         m.getExternalUrl,
         urifactory.escapeuri(u)
         );      
      utAssert.eq (
         'Test of UTLFILEURITYPE.getUrl',
         m.getUrl,
         u
         );               
         

      -- End of test
   END ut_test_2;
     -- For each program to test...
   PROCEDURE ut_test_3
   IS
      u VARCHAR2(200) := '/test.txt';
	    m URITYPE;
   BEGIN

      -- Define "control" operation

      utAssert.objexists('test','UTLFILEURITYPE');
      -- Execute test code

      m := UTLFILEURITYPE(u);

      -- Assert success

      utAssert.this (
         'Test of UTLFILEURITYPE',
         m is not null
         );

      utAssert.eq (
         'Test of UTLFILEURITYPE.getUrl',
         m.getUrl,
         'utlfile://LOG4_CONFIG'||u
         );             

      -- End of test
   END ut_test_3;

END ut_UTLFILEURITYPE;
/

show errors
