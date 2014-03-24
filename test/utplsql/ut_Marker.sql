create or replace package ut_Marker
AUTHID DEFINER
AS
   PROCEDURE ut_setup;
   PROCEDURE ut_teardown;
 
   PROCEDURE ut_marker;

END ut_Marker;
/
show errors

create or replace package BODY ut_Marker
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
   
   PROCEDURE ut_marker
   IS
    m Marker;
    m2 Marker;
    m3 Marker;
   BEGIN
		utassert.objexists('test','Marker');


      m := MarkerManager.getmarker('GRANDPARENT');
      utAssert.this ('basic creation test', m IS NOT NULL);
      
      utAssert.eq('getname', m.getname() , 'GRANDPARENT' );
      
      m2 := MarkerManager.getMarker('PARENT',m);
      utAssert.this ('creation test with parent', m2 IS NOT NULL);
      
      utAssert.this('getparent is parent', m2.getparent() = m );
      utAssert.this('child instance of parent', m2.isinstanceof(m) );
      
      utAssert.throws('missing parent', 'declare m Marker; begin m :=  MarkerManager.getMarker(''PARENT'',''''); end', 'NO_DATA_FOUND');

      m3 := MarkerManager.getMarker('CHILD',m2);
     
      utAssert.this('child instance of grandparent', m3.isinstanceof(m) );

		 utAssert.eq('tostring', m.tostring(), 'GRANDPARENT' );
		 utAssert.eq('tostring', m2.tostring(), 'PARENT[GRANDPARENT]' );
		 utAssert.eq('tostring', m3.tostring(), 'CHILD[PARENT, GRANDPARENT]' );


   END;

		 --utAssert.eq('tostring', m.tostring(), 'MarkerImpl' );
		 --utAssert.eq('tostring', m2.tostring(), 'MarkerImpl-child[MarkerImpl]' );
		 --utAssert.eq('tostring', m3.tostring(), 'MarkerImpl-grandchild[MarkerImpl-child, MarkerImpl]' );

END ut_Marker;
/
show errors

