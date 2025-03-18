SHOW logging_collector;

SHOW log_directory;

--

\connect demo

\timing

SELECT * FROM aircrafts_data;

UPDATE boarding_passes SET ticket_no = ticket_no, flight_id = flight_id, boarding_no = boarding_no, seat_no = seat_no;

\du