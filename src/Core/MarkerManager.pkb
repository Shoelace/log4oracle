/* copyright
*/
create or replace package BODY MarkerManager
AS
	k_log Logger;
  
  FUNCTION getMarkerRef(NAME VARCHAR2) RETURN REF Marker
  IS
   mr Ref Marker;
  BEGIN
    SELECT REF(m) INTO mr FROM all_markers m WHERE m_name = NAME;
    return mr;
  END;

	FUNCTION getMarker(name VARCHAR2) RETURN Marker
	IS
	BEGIN
		k_log.entry();
--('getMarker(name)'||name);
		if not m_all_markers.exists(name) then
            m_all_markers(name) :=  MarkerImpl(name);
        end if;

		--RETURN TREAT(k_log.exit(m_all_markers(name)) AS Marker);
		RETURN m_all_markers(name);

	END;
	FUNCTION getMarker(name VARCHAR2, parent VARCHAR2) RETURN Marker
	IS
		p_marker Marker;
	BEGIN
		k_log.entry();
		IF m_all_markers.exists(name)  THEN
			k_log.ERROR('parent doesnt exist:'||NAME);
			RAISE NO_DATA_FOUND;
		END IF;

		p_marker := getMarker(PARENT);
		--RETURN TREAT(k_log.exit() AS Marker);
    RETURN getMarker(NAME,p_marker);
	END;

	FUNCTION getMarker(name VARCHAR2, parent IN OUT NOCOPY Marker) RETURN Marker
	IS
	BEGIN
		k_log.entry();
k_log.trace('getMarker(name,parent)'||name||','||parent.getname());
	 if not m_all_markers.exists(name) then
            --LogLog.debug('creating Marker:'||name);
            m_all_markers(name) :=  MarkerImpl(name,parent);
        end if;

		--RETURN TREAT(k_log.exit(m_all_markers(NAME)) AS Marker);
    RETURN m_all_markers(name);
	END;

BEGIN
	k_log := Logmanager.getlogger(); 
END MarkerManager;
/
show errors
