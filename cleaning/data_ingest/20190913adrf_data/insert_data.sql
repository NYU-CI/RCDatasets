INSERT INTO public.dataset_crosswalk(
	canonical_name, alt_name,data_provider) 
  SELECT title,alias,data_provider from adrf_metadata

  
  	INSERT INTO public.dataset_crosswalk(
	canonical_name, alt_name,data_provider) 
  SELECT title,alias,data_provider from adrf_metadata
