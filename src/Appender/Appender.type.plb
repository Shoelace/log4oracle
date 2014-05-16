create or replace
TYPE BODY Appender 
as 
	member function getName return varchar2
	is
	begin
		return m_name;
	end;

	member procedure append(event LogEvent) 
	is
	begin
		null;
	end;

	member function getLayout return Layout
	is
	begin
		return m_layout;
	end;

	member function toString return varchar2
	is
	begin
		return 'Appender('||m_name||',...)';
	end;

	map member function Compare return varchar2
	is
	begin
		return toString();
	end;

   constructor function Appender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result
	is
	begin
		m_name := name;
		m_filter := filter;
		m_layout := layout;
		return;
	end;



    member procedure addFilter(Filter filter) 
	IS BEGIN
        if self.m_filter IS NULL THEN
            self.m_filter := filter;
		ELSIF self.m_filter is of (CompositeFilter) THEN
           null;-- treat(self.m_filter as CompositeFilter).addFilter(filter);
        ELSE 
			NULL;
            --final Filter[] filters = new Filter[] {self.filter, filter};
            --self.filter = CompositeFilter.createFilters(filters);
		END IF;
    END;

    /**
     * Remove a Filter.
     * @param filter The Filter to remove.
     */
    member procedure removeFilter(Filter filter) 
	IS BEGIN
        if (self.m_filter = filter) THEN
            self.m_filter := null;
        elsif (filter is of (CompositeFilter)) then
            --CompositeFilter composite = (CompositeFilter) filter;
            --composite = composite.removeFilter(filter);
            --if (composite.size() > 1) {
                --self.filter = composite;
            --} else if (composite.size() == 1) {
                --final Iterator<Filter> iter = composite.iterator();
                --self.filter = iter.next();
            --} else {
                --self.filter = null;
            --}
			null;
        end if;
    END;

    member function hasFilter return boolean
	is begin
	return m_filter IS NOT NULL;
	end;

    member function isFiltered(event LogEvent) return boolean
	IS BEGIN
		return m_filter is not null AND m_filter.dofilter(event) = Result.DENY;
        --return filter != null && filter.filter(event) == Filter.Result.DENY;
	END;
end;
/
show errors
