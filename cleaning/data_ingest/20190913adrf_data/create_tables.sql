
drop table usda_linkages_20190913
create table usda_linkages_20190913 (
    linkage_id serial PRIMARY KEY,
    sheet_name varchar,
    Author varchar,
    Released varchar,
    Series varchar,
    Titles varchar,
    Datasets varchar,
    date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()
)

create table usda_clean_dataset_names_20190913 (
    linkage_id int  REFERENCES usda_linkages_20190913 (linkage_id),
    dataset_listing varchar ,
    original_dataset_name varchar,
    dataset_name varchar,
    dataset_alias varchar,
    date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()
)

drop table adrf_metadata
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

drop table dataset_names
CREATE TABLE dataset_names (
   dataset_name_id serial PRIMARY KEY,
   original_dataset_name varchar ,
   dataset_name varchar ,
   dataset_provider varchar  NOT NULL,
    date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()

);


CREATE TABLE dataset_crosswalk (
   dataset_id serial PRIMARY KEY,
   canonical_name varchar ,
   alt_name varchar, 
   data_provider varchar, 
   date_inserted TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
