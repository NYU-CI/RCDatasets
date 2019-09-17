drop table dataset_names
CREATE TABLE dataset_names (
   dataset_name_id serial PRIMARY KEY,
   original_dataset_name varchar ,
   dataset_name varchar ,
   dataset_provider varchar  NOT NULL,
date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

SELECT dataset_name_id, original_dataset_name, dataset_name, dataset_provider, date_inserted
	FROM public.dataset_names;
	
	drop table dataset_crosswalk
	
	CREATE TABLE dataset_crosswalk (
   dataset_id serial PRIMARY KEY,
   canonical_name varchar ,
   alt_name varchar, 
   data_provider varchar, 
   date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


	INSERT INTO dataset_crosswalk (
	canonical_name, alt_name,data_provider) 
  SELECT title,alias,data_provider from adrf_metadata
  
  SELECT count(*)
	FROM public.dataset_crosswalk;
	
	INSERT INTO dataset_crosswalk (
	canonical_name,data_provider) 
  SELECT dataset_name,dataset_provider from dataset_names