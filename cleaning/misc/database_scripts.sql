-- Database: rcdb
CREATE TABLE dataset_names(
   dataset_name_id serial PRIMARY KEY,
   dataset_name nvarchar(max)  UNIQUE NOT NULL,
   dataset_provider nvarchar(max)  NOT NULL,
   date_inserted TIMESTAMP NOT NULL
);

-- DROP DATABASE rcdb;

CREATE DATABASE rcdb
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;