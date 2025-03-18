SELECT pid, usename, datname, state, state_change FROM pg_stat_activity;

SELECT pid, usename, datname, state, state_change, query FROM pg_stat_activity;

SELECT pid, usename, datname, state, state_change, query FROM pg_stat_activity WHERE state = 'active';

SELECT datname, tup_inserted, tup_updated, tup_deleted FROM pg_stat_database;

SELECT datname, tup_fetched, tup_returned FROM pg_stat_database;

SELECT datname, tup_inserted, tup_updated, tup_deleted, tup_fetched, tup_returned FROM pg_stat_database WHERE datname = 'demo';

-- local

CREATE EXTENSION pg_stat_statements;

ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';

\connect demo

\dx

show shared_preload_libraries;

\x

SELECT dbid, query, total_exec_time FROM pg_stat_statements;

SELECT oid, datname FROM pg_database;

DROP EXTENSION pg_stat_statements;

ALTER SYSTEM RESET shared_preload_libraries;

--

\connect demo

\dt

SELECT * FROM aircrafts_data;

\d aircrafts_data

DROP VIEW aircrafts;

ALTER TABLE aircrafts_data ALTER COLUMN range TYPE smallint;

\d aircrafts_data

show autovacuum;

SELECT relname, n_dead_tup, last_autoanalyze, autovacuum_count FROM pg_stat_user_tables;