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

insert_usda_dataset_names <-function(usda_dataset_df){
  
the_vals<-paste0("(","'",usda_dataset_df$original_dataset_name,"',"
                ,"'",usda_dataset_df$dataset_name,"',"
                ,"'",usda_dataset_df$data_provider,"'"
                ,")")

insert_vals<-paste(the_vals,collapse=",")

insert_query = sprintf("INSERT INTO dataset_names (original_dataset_name, dataset_name, dataset_provider)  VALUES %s",insert_vals)
res <- dbSendQuery(con, insert_query)
}

a<-unique(final_dataset_df)
insert_usda_dataset_names(a)


data_to_push<-final_dataset_df %>% filter(!(original_dataset_name %in% ds_names$original_dataset_name))
insert_usda_dataset_names(data_to_push)


