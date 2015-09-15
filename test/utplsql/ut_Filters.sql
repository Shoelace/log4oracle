create or replace package ut_Filter
AUTHID DEFINER
AS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;
 
   PROCEDURE ut_filter;

   PROCEDURE ut_Thresholdfilter;
   PROCEDURE ut_Compositefilter;

--   PROCEDURE ut_MarkerFilter;
--   PROCEDURE ut_RegexFilter;
-- ThreadContextMapFilter
--TimeFilter

END ut_Filter;
/
show errors

create or replace package BODY ut_Filter
AS

--utplsql
 PROCEDURE ut_setup IS
   BEGIN
      NULL;
   END;
 
   PROCEDURE ut_teardown
   IS
   BEGIN
      NULL;
   END;
   
   PROCEDURE ut_filter
   IS
    f Filter;
   BEGIN
		utassert.objexists('test','Filter');


      f := Filter(NULL,NULL);

      utAssert.this ('Filter creation test', f IS NOT NULL);

      utAssert.this ('doFilter1', f.dofilter(NULL) = Result.NEUTRAL);
      utAssert.this ('doFilter2', f.dofilter(NULL,null,null,log4_sql_object(3),null) = Result.NEUTRAL);
      utAssert.this ('doFilter3', f.dofilter(NULL,null,null,MESSAGEFACTORY.NEWMESSAGE('hello world'),null) = Result.NEUTRAL);
      --utAssert.this ('doFilter3', f.dofilter(NULL) = Result.NEUTRAL);
      

   END;

   PROCEDURE ut_thresholdfilter
   IS
    f Filter;
l logger := Logmanager.getLogger();
   BEGIN
		utassert.objexists('test','ThresholdFilter');


      f := ThresholdFilter(LogLevel.INFO,NULL,NULL);

      utAssert.this ('threshold creation test', f IS NOT NULL);

      --utAssert.this ('threshold1', f.dofilter(NULL) = Result.NEUTRAL);
      --utAssert.this ('threshold2', f.dofilter(NULL,null,null,log4_sql_object(3),null) = Result.NEUTRAL);

      utAssert.this ('threshold3', f.dofilter(l,LogLevel.ERROR,null,MESSAGEFACTORY.NEWMESSAGE('my error message'),null) = Result.NEUTRAL);
      utAssert.this ('threshold4', f.dofilter(l,LogLevel.TRACE,null,MESSAGEFACTORY.NEWMESSAGE('my trace message'),null) = Result.DENY);

      --utAssert.this ('doFilter3', f.dofilter(NULL) = Result.NEUTRAL);
      
      f := ThresholdFilter(LogLevel.INFO,Result.DENY,Result.ACCEPT);
      utAssert.this ('threshold5', f.dofilter(l,LogLevel.ERROR,null,MESSAGEFACTORY.NEWMESSAGE('my error message'),null) = Result.DENY);
      utAssert.this ('threshold6', f.dofilter(l,LogLevel.TRACE,null,MESSAGEFACTORY.NEWMESSAGE('my trace message'),null) = Result.ACCEPT);

   END;


 PROCEDURE ut_compositefilter
   IS
    f Filter;
 fa FilterArray;
l logger := Logmanager.getLogger();
   BEGIN
		utassert.objexists('test','CompositeFilter');


		fa := FilterArray(ThresholdFilter(LogLevel.INFO,NULL,NULL), ThresholdFilter(LogLevel.FATAL,NULL,NULL) );
      f := CompositeFilter(fa);

      utAssert.this ('Filter creation test', f IS NOT NULL);

      --utAssert.this ('doFilter1', f.dofilter(NULL) = Result.NEUTRAL);
      --utAssert.this ('doFilter2', f.dofilter(NULL,null,null,log4_sql_object(3),null) = Result.NEUTRAL);
      utAssert.this ('doFilter3', f.dofilter(l,loglevel.ERROR,null,MESSAGEFACTORY.NEWMESSAGE('hello world'),null) = Result.DENY);
      --utAssert.this ('doFilter3', f.dofilter(NULL) = Result.NEUTRAL);
      

   END;


END ut_Filter;
/
show errors

