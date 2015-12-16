Project Status
==============
work in progress on v2 


Documentation
=============
This is an implementation of the Apache logging service. http://logging.apache.org/

it is attempted to by a full and faithful re-implementation of the log4j code and functionailty
re-written in Oracle PL/SQL


it is currently equivielent to log4j v1.x  but work is underway to support full 2.x functionality


Features
========
entirely PL/SQL  (no java or external bits)
api compatible (whereever possible) with v1.x  (v2.x in progress)
cross session enabling of logging levels
dbms_output and plain table appenders  (more planned)
simple dbms_scheduler integration.


planned features
================
oracle editions enable to support non downtime upgrades
AQ appenders
fully unit tested codebase

support configuration for non-enterprise databases and features sets. (ie parallel, partitions, rac, etc)
