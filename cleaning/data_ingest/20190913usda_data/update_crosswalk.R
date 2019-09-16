setwd("/Users/sophierand/RCDatasets/cleaning/20190913usda_data")
library(RODBC)
library(DBI)
library("RPostgreSQL") 
pgdrv <- DBI::dbDriver(drvName = "PostgreSQL")

con <-DBI::dbConnect(pgdrv,
                     dbname="rcdb",
                     host="richcontext.cz5u3bpfaar4.us-east-1.rds.amazonaws.com", port=5432,
                     user = 'postgres',
                     password = 'rc_dumps')


s_query<-"SELECT * FROM dataset_names;"
res <- dbSendQuery(con, s_query)
dbFetch(res)


dataset_crosswalk <- read.table("/Users/sophierand/RCDatasets/dataset_name_crosswalk.csv", sep = ",", header = T,stringsAsFactors = F)
dataset_crosswalk<-unique(dataset_crosswalk)


insert_crosswalk_vals <-function(dataset_crosswalk){
  
  the_vals<-paste0("(","'",dataset_crosswalk$canonical_name,"',"
                   ,"'",dataset_crosswalk$alt_name,"'"
                   ,")")
  
  insert_vals<-paste(the_vals,collapse=",")
  
  insert_query = sprintf("INSERT INTO dataset_crosswalk(canonical_name, alt_name) VALUES %s",insert_vals)
                        
  res <- dbSendQuery(con, insert_query)
}

insert_crosswalk_vals(dataset_crosswalk = dataset_crosswalk)
