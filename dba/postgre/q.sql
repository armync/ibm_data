\i flights_RUSSIA_small.sql

\dt

SHOW wal_level;

ALTER SYSTEM SET wal_level = 'logical';

\connect demo

SELECT * FROM pg_tables WHERE schemaname = 'bookings';

ALTER TABLE boarding_passes ENABLE ROW LEVEL SECURITY;

SELECT name, setting, short_desc FROM pg_settings WHERE name = 'wal_level';

UPDATE pg_tables SET tablename = 'aircraft_fleet' WHERE tablename = 'aircrafts_data';

ALTER TABLE aircrafts_data RENAME TO aircraft_fleet;

SELECT tablename FROM pg_tables WHERE schemaname = 'bookings';