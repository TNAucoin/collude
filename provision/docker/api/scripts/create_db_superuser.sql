-- delete user if it exists
DROP ROLE IF EXISTS :DB_USER;
-- create user
CREATE USER :DB_USER WITH PASSWORD :'DB_PASS';

-- make user a superuser
ALTER USER :DB_USER WITH SUPERUSER;

-- grant privileges on database
GRANT ALL PRIVILEGES ON DATABASE :DB_NAME to :DB_USER;