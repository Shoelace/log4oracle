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

