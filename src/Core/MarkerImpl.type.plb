create or replace
TYPE body MarkerImpl 
AS
  constructor function MarkerImpl(name VARCHAR2) return self as result
	as
	BEGIN
		--dbms_output.put_line('MarkerImpl(name):'||name);
		self.m_name := name;
		self.m_parent_name := NULL;
		return;
	end;

  constructor function MarkerImpl(name VARCHAR2, parent Marker) return self as result
	as
	begin
		IF parent IS NULL THEN
			RAISE NO_DATA_FOUND;
		END IF;
--dbms_output.put_line('MarkerImpl(name,parent)');
		self.m_name := NAME;
		self.m_parent_name := parent.m_name;
		return;
	end;
end;
/
show errors
