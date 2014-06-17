create table all_markers of marker
(
CONSTRAINT pk_marker
PRIMARY KEY (m_NAME),
FOREIGN KEY (m_parent) REFERENCES all_markers
)
OBJECT IDENTIFIER IS PRIMARY KEY;




DESC formattinginfo

create table fi_tab of formattinginfo;

insert into fi_tab values(1,999, 0);

select ref(e) from fi_tab e;

create table ref_fi (ID REF formattinginfo);

INSERT INTO ref_fi
select ref(e) from fi_tab e;


select deref(id) from ref_fi;

desc logger

create table allloggers of logger(primary key (m_name) );

select * from allloggers;


desc utl_ref

set serveroutput on
DECLARE
f REF formattinginfo;
fo formattinginfo;
BEGIN
SELECT REF(e) INTO f FROM fi_tab e;


utl_ref.select_object(f,fo);

dbms_output.put_line('ref:'||fo.minlength);
fo.minLength := 6;

UTL_REF.UPDATE_OBJECT(f, fo); 

END;
/

select ref(e) from fi_tab e;

