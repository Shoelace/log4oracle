update log_levels set trace=1, debug = 1
where logger_name = '.';
commit;
