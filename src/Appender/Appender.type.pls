prompt create or replace TYPE Appender 
create or replace
TYPE Appender 
AUTHID DEFINER
as object
(
	/* The name of this Appender. */
	m_name varchar2(255),
	m_layout Layout,
	m_filter Filter,

	member function getName return varchar2,
	member procedure append(event LogEvent) ,

	--member function getHandler return ErrorHandler,
	member function getLayout return Layout,
	--member procedure setHandler(h ErrorHandler) ,

	member function toString return varchar2,

   constructor function Appender(name VARCHAR2, filter Filter, layout Layout,ignoreExceptions boolean ) return self as result,

	map member function Compare return varchar2

	--abstractfilterable interface
	
    ,member procedure addFilter(Filter filter) 
    ,member procedure removeFilter(Filter filter) 
    ,member function hasFilter return boolean

    ,member function isFiltered(event LogEvent) return boolean


)
not final not instantiable ;
/
show errors


create or replace
TYPE BODY Appender 
as 

    member procedure addFilter(Filter filter) 
	IS BEGIN
        if self.m_filter IS NULL THEN
            self.m_filter := filter;
		ELSIF self.m_filter is of (CompositeFilter) THEN
            self.m_filter.addFilter(filter);
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
