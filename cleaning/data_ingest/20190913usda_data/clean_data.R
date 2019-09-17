# setwd("/Users/sophierand/RCDatasets/cleaning/20190913usda_data")
library(RODBC)
library(RPostgreSQL)
library(dplyr)
library(purrr)

library(DBI)
library("RPostgreSQL") 
pgdrv <- DBI::dbDriver(drvName = "PostgreSQL")
library(magrittr)
library(tidyverse)

create_connection<-function(){
  con <-DBI::dbConnect(pgdrv,
                       dbname="rcdb",
                       host="richcontext.cz5u3bpfaar4.us-east-1.rds.amazonaws.com", port=5432,
                       user = 'postgres',
                       password = 'rc_dumps')
  
  return(con)
}

run_select_query <- function(con){
  s_query <- "SELECT linkage_id, sheet_name, author, released, series, titles, datasets, date_inserted FROM public.usda_linkages_20190913"
  res <- dbSendQuery(con, s_query)
  return(dbFetch(res))
}

con<-create_connection()
usda_data<-run_select_query(con)


usda_dataset_df<-usda_data %>% 
  mutate(original_dataset_name = strsplit(as.character(datasets), "▪")) %>% 
  unnest(original_dataset_name) %>% 
  filter(original_dataset_name != "") %>% 
  mutate(original_dataset_name = trimws(original_dataset_name)) %>% 
  unique() %>%
  mutate(clean_ds_name = case_when(
    grepl("Food and Nutrition Service|FNS",original_dataset_name,ignore.case = T) ~ "Food and Nutrition Service",
    grepl("NHANES|National Health and Nutrition Examination Survey",original_dataset_name,ignore.case = T) ~ "National Health and Nutrition Examination Survey",
    grepl("School Nutrition and Dietary Assessment Study|SNDA",original_dataset_name,ignore.case = T) ~ "School Nutrition and Dietary Assessment Study",
    grepl("TDLinx",original_dataset_name,ignore.case = T) ~ "TDLinx",
    grepl("FoodAPS",original_dataset_name,ignore.case = T) ~ "FoodAPS",
    grepl("FSIS",original_dataset_name,ignore.case = T) ~ "FSIS",
    grepl("AMS|Agricultural Marketing Service",original_dataset_name,ignore.case = T) ~ "Agricultural Marketing Service",
    grepl("CPS-FSS|FSS|Food Security Supplement|CPS",original_dataset_name,ignore.case = T) ~ "Current Population Survey, Food Security Supplement",
    grepl("Current Population Survey|CPS",original_dataset_name,ignore.case = T) ~ "Current Population Survey",
    grepl("Consumer Expenditure|CES",original_dataset_name,ignore.case = T) ~ "Consumer Expenditure Survey",
    grepl("American Community Survey|ACS",original_dataset_name,ignore.case = T) ~ "American Community Survey",
    grepl("Decennial|Tract|Census",original_dataset_name,ignore.case = T) ~"U.S. Census",
    grepl("Homescan",original_dataset_name,ignore.case = T) ~ "IRI Consumer Network",
    grepl("InfoScan|IRI scanner",original_dataset_name,ignore.case = T) ~ "IRI InfoScan",
    grepl("Eating and Health|EHM",original_dataset_name,ignore.case = T) ~ "Eating and Health Module",
    grepl("Survey of Income and Program Participation|SIPP",original_dataset_name,ignore.case = T) ~ "Survey of Income and Program Participation",
    grepl("Nielsen",original_dataset_name,ignore.case = T) ~ "Nielsen",
    grepl("IRI",original_dataset_name,ignore.case = T) ~ "IRI",
    grepl("CSFII|Continuing Survey of Food Intakes by Individuals",original_dataset_name,ignore.case = T) ~ "Continuing Survey of Food Intakes by Individuals",
    grepl("FARA",original_dataset_name,ignore.case = T) ~ "FARA",
    grepl("FADS-LAFA|FADS",original_dataset_name,ignore.case = T) ~ "Food Availability Data System",
    grepl("FDA",original_dataset_name,ignore.case = T) ~ "FDA",
    grepl("FICRCD|Food Intakes Converted to Retail Commodities Databases",original_dataset_name,ignore.case = T) ~ "Food Intakes Converted to Retail Commodities Databases",
    grepl("Annual Social and Economic Supplement|ASEC",original_dataset_name,ignore.case = T) ~ "Annual Social and Economic Supplement",
    grepl("SNAP|Supplemental Nutrition Assistance Program",original_dataset_name,ignore.case = T) ~ "Supplemental Nutrition Assistance Program",
    grepl("FAFH",sheet_name,ignore.case = T) ~ "Food Away From Home",
    grepl("Foodborne Illnesses",original_dataset_name,ignore.case = T) ~ "Cost Estimates of Foodborne Illnesses",
    TRUE ~ as.character(sheet_name)))
  
usda_dataset_df %>% filter(clean_ds_name == 'sup')
usda_dataset_df %>% filter(original_dataset_name == 'nan')

usda_dataset_df %>% select(linkage_id,datasets,original_dataset_name,clean_ds_name) %>% head(7)

usda_data_to_push<-usda_dataset_df %>% 
  mutate(alias = ifelse(grepl(" ", original_dataset_name),"",original_dataset_name)) %>% 
  select("linkage_id","datasets","original_dataset_name","clean_ds_name", "alias") %>% 
  dplyr::rename("dataset_listing" = "datasets","dataset_name" = "clean_ds_name")
  unique()
  
  
usda_vals<-paste0(
  "("
  ,usda_data_to_push$linkage_id,","
  ,"'", usda_data_to_push$dataset_listing,"',"
  ,"'", usda_data_to_push$original_dataset_name,"',"  
  ,"'", usda_data_to_push$dataset_name,"',"
  ,"'", usda_data_to_push$alias,"'"
  ,")"
)


insert_vals<-paste(usda_vals,collapse=",")
insert_query = sprintf( "INSERT INTO public.usda_clean_dataset_names_20190913(linkage_id, dataset_listing, original_dataset_name, dataset_name, dataset_alias) VALUES %s;",insert_vals)
res <- dbSendQuery(con, insert_query)
  
