setwd("/Users/sophierand/RCDatasets/cleaning/data_ingest/20190913adrf_data")
adrf_datasets <- read.csv(paste0(getwd(),"/adrf_metadata.csv"))
# dataset_crosswalk<-unique(dataset_crosswalk)
adrf_datasets<-adrf_datasets %>% 
  select(access_requirements,source_url,data_classification,data_provider,data_steward,adrf_id,geographical_coverage,geographical_unit,category,temporal_coverage_end,dataset_citation,external_id,data_usage_policy,filenames,access_actions_required,reference_url,data_steward_org,keywords,temporal_coverage_start,title,dataset_version,alias,dataset_documentation,dataset_header_desc,description,related_articles,source_archive)

insert_vals_df<-adrf_datasets %>% 
  mutate(new_cols = gsub(",,",", ",paste(access_requirements,source_url,data_classification,data_provider,data_steward,adrf_id,geographical_coverage
                           ,geographical_unit,category,temporal_coverage_end,dataset_citation,external_id,data_usage_policy,filenames
                           ,access_actions_required,reference_url,data_steward_org,keywords,temporal_coverage_start,title,dataset_version
                           ,alias,dataset_documentation,dataset_header_desc,description,related_articles,source_archive,sep = ",")))


a<-head(adrf_datasets)
b<-a %>% mutate(new_col = paste(access_requirements,source_url,data_classification,data_provider,data_steward,adrf_id,geographical_coverage
      ,geographical_unit,sep = ",")) %>% select(new_col)

insert_vals<-paste0("(",insert_vals_df$new_cols  ,")")

insert_vals<-paste0("(","'",dataset_crosswalk$canonical_name,"',"
                    ,"'",dataset_crosswalk$alt_name,"'"
                    ,")")
"INSERT INTO public.adrf_metadata(
  access_requirements, source_url, data_classification, data_provider, data_steward, adrf_id, geographical_coverage, geographical_unit, category, temporal_coverage_end, dataset_citation, external_id, data_usage_policy, filenames, access_actions_required, reference_url, data_steward_org, keywords, temporal_coverage_start, title, dataset_version, alias, dataset_documentation, dataset_header_desc, description, related_articles, source_archive, date_inserted)
VALUES ?;
"

insert_crosswalk_vals <-function(dataset_crosswalk){
  the_vals<-paste0("(","'",dataset_crosswalk$canonical_name,"',"
                   ,"'",dataset_crosswalk$alt_name,"'"
                   ,")")
  
  insert_vals<-paste(the_vals,collapse=",")
  
  insert_query = sprintf("INSERT INTO dataset_crosswalk(canonical_name, alt_name) VALUES %s",insert_vals)
  
  res <- dbSendQuery(con, insert_query)
}

insert_crosswalk_vals(dataset_crosswalk = dataset_crosswalk)
