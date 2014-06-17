create or replace
TYPE body MarkerImpl 
AS
  constructor function MarkerImpl(name VARCHAR2) return self as result
	as
	BEGIN
		--dbms_output.put_line('MarkerImpl(name):'||name);
		self.m_name := name;
		self.m_parent := NULL;
		return;
	end;

  constructor function MarkerImpl(name VARCHAR2, parent Ref Marker) return self as result
	as
	begin
		IF parent IS NULL THEN
			RAISE NO_DATA_FOUND;
		END IF;
--dbms_output.put_line('MarkerImpl(name,parent)');
		self.m_name := NAME;
    --SELECT REF(am) INTO self.m_parent FROM all_markers am WHERE VALUE(am) = PARENT;
		self.m_parent := parent;
		return;
	end;
end;
/
show errors