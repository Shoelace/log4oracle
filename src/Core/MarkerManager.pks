--prompt create or replace package MarkerManager
create or replace package MarkerManager
AUTHID DEFINER
AS

	FUNCTION getMarker(name VARCHAR2) RETURN Marker;
	FUNCTION getMarker(name VARCHAR2, parent VARCHAR2) RETURN Marker;
	FUNCTION getMarker(name VARCHAR2, parent IN OUT NOCOPY Marker) RETURN Marker;

END MarkerManager;
/
show errors
