-- terminate backend processes using db
SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = :'DB_NAME' AND pid <> pg_backend_pid();

-- delete database if it exists
DROP DATABASE IF EXISTS :DB_NAME;

-- delete user if it exists
DROP ROLE IF EXISTS :DB_USER;

-- create user
CREATE USER :DB_USER WITH PASSWORD :'DB_PASS';

-- create superuser
ALTER USER :DB_USER WITH SUPERUSER;

-- recreate db
CREATE DATABASE :DB_NAME OWNER :DB_USER;

-- grant user all privileges to database
GRANT ALL PRIVILEGES ON DATABASE :DB_NAME to :DB_USER;