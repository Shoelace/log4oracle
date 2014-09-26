prompt create or replace package MarkerManager
create or replace package MarkerManager
AUTHID DEFINER
AS
	type markerArray is table of Marker not null index by varchar2(255); --Marker.name%type;
	m_all_markers markerArray;

	FUNCTION getMarker(name VARCHAR2) RETURN Marker;
	FUNCTION getMarker(name VARCHAR2, parent VARCHAR2) RETURN Marker;
	FUNCTION getMarker(name VARCHAR2, parent IN OUT NOCOPY Marker) RETURN Marker;

END MarkerManager;
/
show errors
