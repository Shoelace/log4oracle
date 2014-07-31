create or replace package BODY MarkerManager
AS
/* copyright
*/

	k_log Logger;


	FUNCTION getMarker(name VARCHAR2) RETURN Marker
	IS
  --PRAGMA AUTONOMOUS_TRANSACTION;

		m marker;
	BEGIN
		k_log.entry();

		BEGIN
			SELECT VALUE(am) INTO m FROM all_markers am WHERE am.m_name = NAME;
		exception
			WHEN no_data_found THEN
				INSERT INTO all_markers am values (MarkerImpl(NAME)) returning VALUE(am) into m;
		END;

		RETURN TREAT(k_log.exit(m) AS Marker);
	END getMarker;
  
  
	FUNCTION getMarker(name VARCHAR2, parent VARCHAR2) RETURN Marker
	IS
		p_marker Marker;
	BEGIN
		k_log.ENTRY();
    --k_log.trace('getMarker(name,parent)'||name||','||parent);    
		if parent IS NULL THEN
			RAISE NO_DATA_FOUND;
		END IF;

		p_marker := getMarker(PARENT);
		RETURN TREAT(k_log.exit(getMarker(NAME,p_marker)) AS Marker);

	END;

	FUNCTION getMarker(name VARCHAR2, parent IN OUT NOCOPY Marker) RETURN Marker
	IS
  
--  PRAGMA AUTONOMOUS_TRANSACTION;

		v_marker Marker;
		v_parent_ref Ref Marker;
	BEGIN
		k_log.ENTRY();
		if parent IS NULL THEN
			RAISE NO_DATA_FOUND;
		END IF;    
    k_log.info('getMarker(name,parent)'||name||','||parent.getname());


		BEGIN
			SELECT VALUE(am) INTO v_marker FROM all_markers am WHERE am.m_name = NAME;
		exception
			WHEN no_data_found THEN

				SELECT REF(m) INTO v_parent_ref FROM all_markers m WHERE VALUE(m) = PARENT;
				v_marker := MarkerImpl(NAME,v_parent_ref);
				INSERT INTO all_markers am VALUES (v_marker);
		END;

		RETURN TREAT(k_log.exit(v_marker) AS Marker);

	END;

BEGIN
	k_log := Logmanager.getlogger(); 
END MarkerManager;
/
show errors
