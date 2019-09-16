
	INSERT INTO public.dataset_crosswalk(
	canonical_name, alt_name,data_provider) 
  SELECT title,alias,data_provider from adrf_metadata

    CREATE TABLE adrf_metadata (
  access_requirements varchar
  , source_url varchar
  , data_classification varchar
  , data_provider varchar
  , data_steward varchar
  , adrf_id varchar 
  , geographical_coverage varchar
  , geographical_unit varchar
  , category varchar
  , temporal_coverage_end varchar
  , dataset_citation varchar
  , external_id varchar
  , data_usage_policy varchar
  , filenames varchar
  , access_actions_required varchar
  , reference_url varchar
  , data_steward_org varchar
  , keywords varchar
  , temporal_coverage_start varchar
  , title varchar
  , dataset_version varchar
  , alias varchar
  , dataset_documentation varchar
  , dataset_header_desc varchar
  , description varchar
  , related_articles varchar
  , source_archive varchar
  ,date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO public.dataset_crosswalk(
	canonical_name, alt_name) SELECT title,alias from adrf_metadata

  create table datasets(
    
  )
