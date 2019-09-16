CREATE TABLE dataset_names (
   dataset_name_id serial PRIMARY KEY,
   originial_dataset_name varchar UNIQUE NOT NULL
   dataset_name varchar ,
   dataset_provider varchar  NOT NULL,
   date_inserted TIMESTAMP NOT NULL
);

canonical_name	alt_name