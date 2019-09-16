
canonical_name	alt_name

CREATE TABLE dataset_names (
   dataset_name_id serial PRIMARY KEY,
   original_dataset_name varchar UNIQUE NOT NULL,
   dataset_name varchar ,
   dataset_provider varchar  NOT NULL,
date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()

);

CREATE TABLE dataset_crosswalk (
   dataset_id serial PRIMARY KEY,
   canonical_name varchar UNIQUE NOT NULL references dataset_names(dataset_name)
   alt_name varchar 
   date_inserted TIMESTAMP NOT NULL
);