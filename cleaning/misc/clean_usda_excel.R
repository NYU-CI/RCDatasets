# library(xlsx)
library(tidyverse)
library("readxl")

excel_path_name<- "/Users/sophierand/RCDatasets/cleaning/FY2014-19 Datasets for ERS Publications.xlsx"
sheet_names_list = c('Census Surveys', 'CES', 'CPS-FSS', 'Cost Est. Foodborne Illnesses'
                   ,'FDA-FSIS-AMS', 'FADS-LAFA', 'FARA', 'FICRCD-CSFII', 'FNS', 'FoodAPS'
                   ,'IRI', 'NHANES', 'Nielsen', 'Qtrly FAFH', 'SNAP Admin', 'TD Linx', 'SCH MEALS DATA')

df_list <- vector("list", length(sheet_names_list)) 
for (s in sheet_names_list){
  print(s)
  this_sheet <- read_excel(excel_path_name, sheet = s) 
  df_list[s]<-this_sheet
}
# my_data <- read_excel("FY2014-19 Datasets for ERS Publications.xlsx", sheet = 2)
do.call(rbind,