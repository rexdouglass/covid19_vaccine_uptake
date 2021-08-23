
###### Library loads -----------------------

library(tidyverse)

restartspark <- function(){
  #devtools::install_github("rstudio/sparklyr")
  #devtools::install_github("rstudio/sparklyr")
  #install.packages('sparklyr') #rolling back to the stable version
  library(sparklyr)
  #spark_available_versions()
  #spark_installed_versions()
  #spark_uninstall(version="3.0.1", hadoop_version="3.2")
  #spark_uninstall(version="2.4.3", hadoop_version="2.7")
  #oh interesting the default is spark 2.4.3 I wonder why that is
  #Error: Java 11 is only supported for Spark 3.0.0+
  #spark_install("3.0") #3.1.1 is currently the latest stable, but 3.0 is the latest available
  
  #library(geospark)
  #library(arrow)
  mem="160G"
  try({spark_disconnect(sc)})
  conf <- spark_config()
  #conf$`sparklyr.cores.local` <- 128
  #https://datasystemslab.github.io/GeoSpark/api/sql/GeoSparkSQL-Parameter/
  conf$spark.serializer <- "org.apache.spark.serializer.KryoSerializer"
  #conf$spark.kryo.registrator <- "org.datasyslab.geospark.serde.GeoSparkKryoRegistrator"
  #conf$spark.kryoserializer.buffer.max <- "2047MB" #Caused by: java.lang.IllegalArgumentException: spark.kryoserializer.buffer.max must be less than 2048 mb, got: + 10240 mb.
  #https://github.com/DataSystemsLab/GeoSpark/issues/217
  #conf$geospark.global.index <- "true"
  #conf$geospark.global.indextype <- "quadtree"
  #conf$geospark.join.gridtype <- "kdbtree"
  #conf$spark.sql.shuffle.partitions <- 1999 #https://github.com/DataSystemsLab/GeoSpark/issues/361 #setting to just under 2k so compression doesn't kick in, don't need to lower the memory footprint
  conf$spark.driver.maxResultSize <- "100G"
  conf$spark.memory.fraction <- 0.9
  conf$spark.storage.blockManagerSlaveTimeoutMs <-"6000000s" #Failed during initialize_connection: java.lang.IllegalArgumentException: requirement failed: spark.executor.heartbeatInterval should be less than or equal to spark.storage.blockManagerSlaveTimeoutMs
  conf$spark.executor.heartbeatInterval <-"6000000s"# "10000000s"
  conf$spark.network.timeout <- "6000001s"
  conf$spark.local.dir <- "/mnt/8tb_b/spark_temp/"
  conf$spark.worker.cleanup.enabled <- "true"
  conf$"sparklyr.shell.driver-memory"= mem
  conf$'spark.driver.maxResultSize' <- 0 #0 is ulimmited
  
  conf$'spark.sql.legacy.parquet.datetimeRebaseModeInRead' <- 'LEGACY'
  conf$'spark.sql.legacy.parquet.datetimeRebaseModeInWrite' <- 'LEGACY'
  
  conf$'spark.sql.execution.arrow.maxRecordsPerBatch' <- "5000000" #https://github.com/arctern-io/arctern/issues/399
  
  #Error: org.apache.spark.sql.AnalysisException: The pivot column variable_clean has more than 10000 distinct values, this could indicate an error. If this was intended, set spark.sql.pivotMaxValues to at least the number of distinct values of the pivot column.;
  conf$'spark.sql.pivotMaxValues' <- "5000000"
  
  sc <<- spark_connect(master = "local", config = conf#,
                       #version = "2.3.3" #for geospark
  ) 
}

restartspark()



yid_test_include <- spark_read_parquet(sc, path="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_include/performance/" ,memory=F) %>% collect() #include is broken
yid_test_exclude <- spark_read_parquet(sc, path="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude/performance/" ,memory=F) %>% collect()
yid_test_cumulative <- spark_read_parquet(sc, path="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude_cumulative/performance/" ,memory=F) %>% collect()

performance_include <- yid_test_include %>% collect() %>% group_by(ablation) %>% summarize(rmse_include=Metrics::rmse(y_hat_test_pruned_optimized, y_share18plus), mae_include=Metrics::mae(y_hat_test_pruned_optimized, y_share18plus))  
performance_exclude <- yid_test_exclude %>% collect() %>% group_by(ablation) %>% summarize(rmse_exclude=Metrics::rmse(y_hat_test_pruned_optimized, y_share18plus), mae_exclude=Metrics::mae(y_hat_test_pruned_optimized, y_share18plus))  
performance_exclude_cumulative <- yid_test_cumulative %>% collect() %>% group_by(ablation) %>% summarize(rmse_exclude_cumulative=Metrics::rmse(y_hat_test_pruned_optimized, y_share18plus), mae_exclude_cumulative=Metrics::mae(y_hat_test_pruned_optimized, y_share18plus))  

results <- performance_include %>% mutate(ablation=ablation %>% str_replace("keep_","")) %>%
  full_join(performance_exclude %>% 
              mutate(ablation=ablation %>% str_replace("keep_","")) ) %>% 
  full_join(performance_exclude_cumulative %>%
              mutate(ablation=ablation %>% str_replace("exclude_","") ) ) %>% 
              arrange(rmse_exclude %>% desc() ) %>% 
              mutate(baseline=ifelse(ablation=="exclude_nothing", rmse_exclude, NA)) %>%
              mutate(baseline=max(baseline, na.rm=T)) %>%
              mutate(rmse_exclude_cumulative_percbasline= round( 1 - (rmse_exclude_cumulative/baseline) , 2) ) %>%
              mutate(rmse_exclude_percbasline= round( 1 - rmse_exclude/baseline , 2 ) ) %>%
              mutate(rmse_include_percbasline= round( 1 -  rmse_include/baseline, 2 ) )
results %>% view()


#install.packages("huxtable")
library(huxtable)
results_ht <- results %>% dplyr::select(ablation, rmse_include,rmse_include_percbasline, rmse_exclude,rmse_exclude_percbasline, rmse_exclude_cumulative, rmse_exclude_cumulative_percbasline ) %>% as_hux()

for(i in 1:ncol(df_clustered_thinned_ht) ) { #start on row 2 because 1 is the columns
  #print(i)
  groups <- apply(df_clustered_thinned[1:nrow(df_clustered_thinned) ,1:i] %>% as.matrix() ,1, paste0, collapse="_")  #Have to use the original
  groups_unique <- groups %>% unique()
  for(g in groups_unique ){
    start <- (which(groups==g) %>% min())+1
    end <- (which(groups==g) %>% max())+1
    series <- start:end
    df_clustered_thinned_ht <- df_clustered_thinned_ht %>%
      merge_cells(row=series, col=i)  %>% 
      set_left_border(row=series, col=i, value = 0.4)  %>% 
      set_top_border(row=start, col=i, value = 0.4) 
    
  }
}

for(i in 2:nrow(df_clustered_thinned_ht)){ #start on row 2 because 1 is the columns
  #print(i)
  end <- ncol(df_clustered_thinned_ht)
  start <- which(is.na(df_clustered_thinned_ht[i,]))
  if(length(start)>0){
    start <- min(start)-1
    #print(i)
    series <- c(start,end)
    #print(series)
    df_clustered_thinned_ht <- df_clustered_thinned_ht %>%
      merge_cells(row=i, series) %>% 
      set_right_border(row=i, col=start, value = 0.4) 
  }
}

df_clustered_thinned_ht <- df_clustered_thinned_ht %>% set_valign(value='middle' )  #%>% merge_repeated_rows() 

#valign(df_clustered_thinned_ht)

df_clustered_thinned_ht <- df_clustered_thinned_ht %>% 
  set_background_color(evens, everywhere, "grey95") #%>% 
#set_background_color(odds, everywhere, NULL) 

df_clustered_thinned_ht[1,] <- rep("",  df_clustered_thinned_ht %>% ncol())
#df_clustered_thinned_ht 











performance_ablation <- yid_test %>% collect() %>% group_by(ablation) %>% summarize(rmse_y_hat_test=Metrics::rmse(y_hat_test_2percMSE, y_share14plus), rae_y_hat_test=Metrics::mae(y_hat_test_2percMSE, y_share14plus))  
performance_ablation %>% View()
performance_ablation %>% ggplot(aes(x=ablation %>% as.factor(), y=rmse_y_hat_test)) + geom_point() + coord_flip()
performance_ablation %>% ggplot(aes(x=ablation %>% as.factor(), y=rae_y_hat_test)) + geom_point() + coord_flip()

residuals <- yid_test %>% dplyr::select(ablation, fips, y_share14plus, y_hat_test_2percMSE) %>% collect() %>% mutate(residual=y_hat_test_2percMSE-y_share14plus) %>% mutate(fips_state = round(fips/1000 ))

residuals_state <- residuals %>% group_by(ablation, fips_state) %>% summarise(residual=mean(residual))

residuals_state_diff <- residuals_state %>% 
                         left_join(residuals_state %>% mutate(ablation=ablation-1) %>% rename(residual_withoutinfo=residual) ) %>% 
                         mutate(state_residual_change_from_adding_info= round(abs(residual_withoutinfo)-abs(residual),4) )

states_sf_tigris_continental <- readRDS( "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/states_sf_tigris_continental.Rds") %>%
  janitor::clean_names() %>% mutate(fips_state=statefp %>% as.numeric() )

p_test_folds <- 
  states_sf_tigris_continental  %>%
  left_join(residuals_state_diff %>% filter(ablation==1)) %>%
  ggplot(aes(fill = state_residual_change_from_adding_info  )) +
  geom_sf() + 
  #ggtitle("1") +
  scale_fill_gradient2("Changes\nMAE",midpoint=0, trans="reverse") + xlab("") + ylab("") +
  theme_bw() + 
  theme(legend.position = c(0.90, 0.25)) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
p_test_folds

ggsave(filename="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/docs/p_ablation_states_1.png", plot = p_test_folds , height=1, width=2)
#ggsave(filename="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/docs/plots/p_ablation_states_2.png", plot = p_test_folds , height=8, width=16)


tbl_img <- data.frame(
  name = c("kableExtra 1", "kableExtra 2"),
  logo = ""
)
setwd("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/docs/")
tbl_img %>%
  kbl(booktabs = TRUE, longtable = TRUE, align = 'c') %>%
  kable_paper(full_width = F) %>%
  kable_styling(latex_options = c("hold_position", "repeat_header"), bootstrap_options = c('striped')) %>%
  column_spec(2, image = spec_image(
                           path=c("https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
                                  "./mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/docs/p_ablation_states_1.png"),
                           width=200, height=200 
                           )
              )



#ok apparently arrow won't open large files
#Error: IOError: Could not open parquet input source '/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap/treeshap_long_ablation3_fold4.parquet': Couldn't deserialize thrift: TProtocolException: Exceeded size limit
#treeshap_all <- arrow::open_dataset(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap/")) 
treeshap_all <- spark_read_parquet(sc, path="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap/" ,memory=F) 
dim(treeshap_all)

used_vars_df <- treeshap_all %>% 
  dplyr::select(ablation, k_smallest, variable, shap) %>% 
  dplyr::group_by(ablation,  k_smallest, variable) %>% 
    summarise(shap_variable_total= shap %>% abs() %>% sum() ) %>%
  dplyr::group_by(ablation,  k_smallest) %>% 
    mutate(shap_cluster_total=shap_variable_total %>% abs() %>% sum()) %>%
  ungroup() %>%
  #filter(shap_cluster_total==max(shap_cluster_total)) %>% 
  dplyr::arrange(ablation,shap_cluster_total %>% desc(),shap_variable_total %>% desc() ) %>%
  collect()

top_5_vars_by_abblation <- used_vars_df %>% group_by(ablation) %>% slice_head(n = 5) %>% filter(shap_cluster_total==max(shap_cluster_total)) 
top_5_vars_by_abblation %>% View()

#used_clusters_df <- treeshap_all %>% 
#  dplyr::select(ablation, test_fold, k_smallest, shap) %>% #throws an error here if it's the first run
#  dplyr::group_by(ablation,  k_smallest) %>% 
#  summarise(shap_cluster_total=sum(shap %>% abs())) %>%
#  filter(shap_cluster_total==max(shap_cluster_total))  %>% 
#  collect() 


#devtools::install_github("haozhu233/kableExtra")
library(kableExtra)
collapse_rows_dt <- data.frame(C1 = c(rep("a", 10), rep("b", 5)),
                               C2 = c(rep("c", 7), rep("d", 3), rep("c", 2), rep("d", 3)),
                               C3 = 1:15,
                               C4 = sample(c(0,1), 15, replace = TRUE))
kbl(collapse_rows_dt, align = "c") %>%
  kable_paper(full_width = F) %>%
  column_spec(1, bold = T) %>%
  collapse_rows(columns = 1:2, valign = "top") #https://github.com/haozhu233/kableExtra/issues/624 #collapse columns doesn't work right now



library(tidyverse)
library(kableExtra)
coef_table <- data.frame(
  Variables = c("var 1", "var 2", "var 3"),
  Coefficients = c(1.6, 0.2, -2.0),
  Conf.Lower = c(1.3, -0.4, -2.5),
  Conf.Higher = c(1.9, 0.6, -1.4)
) 

data.frame(
  Variable = coef_table$Variables,
  Visualization = ""
) %>%
  kbl(booktabs = T) %>%
  kable_classic(full_width = FALSE) %>%
  column_spec(2, image = spec_pointrange(
    x = coef_table$Coefficients, 
    xmin = coef_table$Conf.Lower, 
    xmax = coef_table$Conf.Higher, 
    vline = 0)
  )


mpg_list <- split(mtcars$mpg, mtcars$cyl)
disp_list <- split(mtcars$disp, mtcars$cyl)
inline_plot <- data.frame(cyl = c(4, 6, 8), mpg_box = "", mpg_hist = "",
                          mpg_line1 = "", mpg_line2 = "",
                          mpg_points1 = "", mpg_points2 = "", mpg_poly = "")
inline_plot %>%
  kbl(booktabs = TRUE) %>%
  kable_paper(full_width = FALSE) %>%
  column_spec(2, image = spec_boxplot(mpg_list)) %>%
  column_spec(3, image = spec_hist(mpg_list)) %>%
  column_spec(4, image = spec_plot(mpg_list, same_lim = TRUE)) %>%
  column_spec(5, image = spec_plot(mpg_list, same_lim = FALSE)) %>%
  column_spec(6, image = spec_plot(mpg_list, type = "p")) %>%
  column_spec(7, image = spec_plot(mpg_list, disp_list, type = "p")) %>%
  column_spec(8, image = spec_plot(mpg_list, polymin = 5))



tbl_img <- data.frame(
  name = c("kableExtra 1", "kableExtra 2"),
  logo = ""
)
tbl_img %>%
  kbl(booktabs = T) %>%
  kable_paper(full_width = F) %>%
  column_spec(2, image = c("kableExtra_sm.png","kableExtra_sm.png"))
              
              


