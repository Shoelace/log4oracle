--drop table all_markers;

prompt create table all_markers 

create table all_markers of marker
(
CONSTRAINT pk_marker
PRIMARY KEY (m_NAME),
FOREIGN KEY (m_parent) REFERENCES all_markers
)
OBJECT IDENTIFIER IS PRIMARY KEY;
