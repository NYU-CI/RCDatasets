
canonical_name	alt_name

CREATE TABLE dataset_names (
   dataset_name_id serial PRIMARY KEY,
   original_dataset_name varchar ,
   dataset_name varchar ,
   dataset_provider varchar  NOT NULL,
date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()

);


	INSERT INTO public.dataset_crosswalk(
	canonical_name, alt_name,data_provider) 
  SELECT title,alias,data_provider from adrf_metadata
