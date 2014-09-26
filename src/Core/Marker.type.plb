create or replace TYPE Body Marker 
AS 

	member function getName return varchar2
	as
	begin
		return m_name;
	end;

	member FUNCTION getParent RETURN Marker
	AS
 
	begin
		IF m_parent_name IS NULL THEN
			RETURN NULL;
		END IF;

    
		--need to avoid getmarker as it causes infinite loop
		IF NOT MarkerManager.m_all_markers.EXISTS(m_parent_name)  THEN
--dbms_output.put_line('parent not exist:'||m_parent_name);      
					return null;
		END IF;
    
		return MarkerManager.m_all_markers(m_parent_name);--0treat(m_parent as Marker);
	end;


	member function isInstanceOf(m Marker) return boolean
	as
		p Marker;
	BEGIN
		p := self;
		LOOP
			IF p = m THEN

				return true;
			END IF;
			p :=  p.getParent();
			exit WHEN p IS NULL;
		END LOOP;
		RETURN FALSE;
	END;
	--member function isInstanceOf(name Varchar2) return boolean,

	/* Returns log level value as an indication of relative values to be sortable. */
	overriding map member function Compare return varchar2 as
	begin
		return m_name;
	end;

	overriding member function toString return varchar2
	as
		retval VARCHAR2(32000) := self.getName();
		p Marker :=getParent();
	begin
		if p IS NOT NULL THEN
			retval := retval|| '[';
			retval := retval|| p.getName();
			loop
				p := p.getParent();
				exit when p IS NULL;
				retval := retval|| ', '||p.getName();
			end loop;
			retval := retval|| ']';
		end if;
		return retval;
	end;
			

end;
/
show errors
