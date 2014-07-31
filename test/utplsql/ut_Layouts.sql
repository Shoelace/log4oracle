CREATE OR REPLACE PACKAGE ut_layout
IS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;

   -- For each program to test...
   PROCEDURE ut_SIMPLELAYOUT;

   PROCEDURE ut_PATTERNLAYOUT_default;

   PROCEDURE ut_PATTERNLAYOUT_custom1;
   PROCEDURE ut_PATTERNLAYOUT_custom2;


END ut_layout;
/
show errors

CREATE OR REPLACE PACKAGE BODY ut_layout
IS
   le1 LogEvent;
   le2 LogEvent;
   le3 LogEvent;

   PROCEDURE ut_setup
   IS
   BEGIN
      le1 := Log4oraclelogEvent('test logger',NULL,'fqcn',loglevel.info,messageFactory.newMessage('layout test message'),NULL);
      
   END;

   PROCEDURE ut_teardown
   IS
   BEGIN
     le1 := null;
     le2 := null;
     le3 := null;
   END;
   
   -- For each program to test...
   PROCEDURE ut_SIMPLELAYOUT
   IS
	   l Layout;
   BEGIN
   
   utassert.objexists('test','SIMPLELAYOUT');

      -- Define "control" operation



      -- Execute test code

      l := SimpleLayout;

      -- Assert success

      utAssert.this (
         'Test of simplelayout',
         l is not null
         );
         
         l.activateoptions;
         
     utAssert.eq (
         'Test of simplelayout.getcontenttype',
         l.getcontenttype,
         'text/plain'
         );

     utAssert.isnull (
         'Test of simplelayout.header',
         l.header
         );

     utAssert.isnull (
         'Test of simplelayout.footer',
         l.footer
         );
    

     utAssert.eq (
         'Test of simplelayout.getcontenttype',
         l.format(le1),
         'INFO - layout test message'
         );
      -- End of test
      
   END ut_SIMPLELAYOUT;

   PROCEDURE ut_PATTERNLAYOUT_default
   IS
      -- Verify and complete data types.
	   l Layout;

   BEGIN
   utassert.objexists('test','PATTERNLAYOUT');
      -- Define "control" operation

 -- Execute test code

      l := PatternLayout;

      -- Assert success

      utAssert.this (
         'Test of PatternLayout',
         l is not null
         );

      l.activateoptions;
         
     utAssert.eq (
         'Test of PatternLayout.getcontenttype',
         l.getcontenttype,
         'text/plain'
         );

     utAssert.isnull (
         'Test of PatternLayout.header',
         l.header
         );

     utAssert.isnull (
         'Test of PatternLayout.footer',
         l.footer
         );
    

     utAssert.eq (
         'Test of PatternLayout.format le1',
         l.format(le1),
         to_char(le1.gettimestamp(),'YYYY-MM-DD HH24:MI:SS,FF3') ||' INFO - layout test message'
         );


      -- End of test
   END ut_PATTERNLAYOUT_default;


 PROCEDURE ut_PATTERNLAYOUT_custom1
   IS
      -- Verify and complete data types.
	   l Layout;

   BEGIN
   utassert.objexists('test','PATTERNLAYOUT');
      -- Define "control" operation

 -- Execute test code

      l := PatternLayout('%p - %m');

      -- Assert success

      utAssert.this (
         'Test of PatternLayout',
         l is not null
         );

      l.activateoptions;
         
     utAssert.eq (
         'Test of PatternLayout.getcontenttype',
         l.getcontenttype,
         'text/plain'
         );

     utAssert.isnull (
         'Test of PatternLayout.header',
         l.header
         );

     utAssert.isnull (
         'Test of PatternLayout.footer',
         l.footer
         );
    

     utAssert.eq (
         'Test of PatternLayout.format le1',
         l.format(le1),
         'INFO - layout test message'
         );

      -- End of test
   END ut_PATTERNLAYOUT_custom1;



 PROCEDURE ut_PATTERNLAYOUT_custom2
   IS
      -- Verify and complete data types.
	   l Layout;

   BEGIN
 -- Execute test code
      l := PatternLayout('%10p - %m');

      l.activateoptions;
         

     utAssert.eq (
         'Test of PatternLayout.format le1',
         l.format(le1),
         '      INFO - layout test message'
         );

      -- End of test
   END ut_PATTERNLAYOUT_custom2;

END ut_layout;
/

show errors
