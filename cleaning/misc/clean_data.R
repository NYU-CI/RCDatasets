library(tidyverse)
library(readxl)
library(stringr)

setwd("/Users/sophierand/RCDatasets/cleaning")

# Read in USDA metadata
excel_path_name<- paste0("/Users/sophierand/RCDatasets/cleaning/FY2014-19 Datasets for ERS Publications.xlsx")
sheet_names_list = c('Census Surveys', 'CES', 'CPS-FSS', 'Cost Est. Foodborne Illnesses'
                     ,'FDA-FSIS-AMS', 'FADS-LAFA', 'FARA', 'FICRCD-CSFII', 'FNS', 'FoodAPS'
                     ,'IRI', 'NHANES', 'Nielsen', 'Qtrly FAFH', 'SNAP Admin', 'TD Linx', 'SCH MEALS DATA')


df_list <- vector("list", length(sheet_names_list)) 
for (s in sheet_names_list){
  print(s)
  this_sheet <- read_excel(excel_path_name, sheet = s,col_names = c("Author","Released", "Series", "Titles","Datasets")) 
  this_sheet <- this_sheet %>% mutate(sheet_name = s) %>% 
    slice(., 3:nrow(.)) %>% 
    data.frame()
  df_list[[s]]<-this_sheet
}

usda_data_df<-do.call("rbind",df_list) %>% filter(Datasets != "")

dataset_crosswalk <- read.table("/Users/sophierand/RCDatasets/cleaning/dataset_name_crosswalk.csv", sep = ",", header = T,stringsAsFactors = F)

alias_patterns<-paste0(dataset_crosswalk$alt_name,collapse = "|")

usda_dataset_df<-usda_data_df %>% 
  mutate(original_dataset_name = strsplit(as.character(Datasets), "▪")) %>% 
  unnest(original_dataset_name) %>% 
  filter(original_dataset_name != "") %>% 
  mutate(original_dataset_name = trimws(original_dataset_name)) %>% 
  unique()

dataset_df<-usda_dataset_df %>% 
  mutate(mention_name = ifelse(grepl(alias_patterns,original_dataset_name),str_extract_all(original_dataset_name, alias_patterns),original_dataset_name)) %>%
  unnest() %>% 
  left_join(dataset_crosswalk, by = c("mention_name" = "alt_name"))


final_dataset_df<-dataset_df %>% mutate(data_provider = 'U.S. Department of Agriculture') %>% 
  filter(!is.na(canonical_name)) %>% 
  select(original_dataset_name, canonical_name,data_provider) %>% 
  dplyr::rename("dataset_name" = "canonical_name") %>% unique()

