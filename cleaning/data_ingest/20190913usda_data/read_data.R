setwd("/Users/sophierand/RCDatasets/cleaning/20190913usda_data")
library(RODBC)
install.packages("RPostgreSQL")
library(RPostgreSQL)
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
