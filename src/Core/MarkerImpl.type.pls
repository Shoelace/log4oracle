create or replace
TYPE MarkerImpl under Marker
(
  constructor FUNCTION MarkerImpl(NAME VARCHAR2) RETURN self AS result,
  constructor function MarkerImpl(name VARCHAR2, parent Ref Marker) return self as result
)
instantiable final;
/

show errors

