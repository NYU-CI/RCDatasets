setwd("/Users/sophierand/RCDatasets/cleaning/20190913usda_data")
library(RODBC)
install.packages("RPostgreSQL")
library(RPostgreSQL)
library(DBI)
library("RPostgreSQL") 
pgdrv <- DBI::dbDriver(drvName = "PostgreSQL")

create_connection<-function(){
  con <-DBI::dbConnect(pgdrv,
                       dbname="rcdb",
                       host="richcontext.cz5u3bpfaar4.us-east-1.rds.amazonaws.com", port=5432,
                       user = 'postgres',
                       password = 'rc_dumps')
  
return(con)
  }


read_dataset_names<-function(con){
s_query<-"SELECT * FROM dataset_names;"
res <- dbSendQuery(con, s_query)
return(dbFetch(res))
}

con<-create_connection()
ds_names<-read_dataset_names(con)
