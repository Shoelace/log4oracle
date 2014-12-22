create or replace package BODY MarkerManager
AS
/* copyright
*/

	k_log Logger;


	FUNCTION getMarker(name VARCHAR2) RETURN Marker
	IS
	BEGIN
		k_log.entry();
--('getMarker(name)'||name);
		if not m_all_markers.exists(name) then
            m_all_markers(name) :=  MarkerImpl(name);
        end if;

		RETURN TREAT(k_log.exit(m_all_markers(name)) AS Marker);

	END getmarker;

	FUNCTION getMarker(name VARCHAR2, parent VARCHAR2) RETURN Marker
	IS
		p_marker Marker;
	BEGIN
		k_log.entry();
		IF m_all_markers.exists(name)  THEN
			k_log.ERROR('parent doesnt exist:'||NAME);
			RAISE NO_DATA_FOUND;
		END IF;

		p_marker := getMarker(parent);
		RETURN TREAT(k_log.exit(getMarker(name,p_marker)) AS Marker);
	END;

	FUNCTION getMarker(name VARCHAR2, parent IN OUT NOCOPY Marker) RETURN Marker
	IS
	BEGIN
		k_log.ENTRY();
    IF PARENT IS NULL THEN RAISE NO_DATA_FOUND; END IF;
k_log.trace('getMarker(name,parent)'||name||','||parent.getname());
	 if not m_all_markers.exists(name) then
            --LogLog.debug('creating Marker:'||name);
            m_all_markers(name) :=  MarkerImpl(name,parent);
        end if;

		RETURN TREAT(k_log.exit(m_all_markers(name)) AS Marker);
	END;

BEGIN
	k_log := Logmanager.getlogger(); 
END MarkerManager;
/
show errors
