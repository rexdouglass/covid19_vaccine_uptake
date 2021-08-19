

########## Library Loads ---------------------------------------
library(pacman)
p_load(tidyverse)
Sys.setenv(LD_LIBRARY_PATH="/usr/lib/cuda:/usr/lib/cuda/lib64:/usr/lib/cuda/include:" %>% paste0(Sys.getenv("LD_LIBRARY_PATH") ) )
Sys.getenv("LD_LIBRARY_PATH")

#rm(list = ls())
#.rs.restartR()
gc()
fromscratch=F
library(reticulate)
#conda_list()
#use_condaenv("py3.6", required = TRUE)

library(tensorflow)
library(keras)

#install_tensorflow(
#  method = c("auto"),
#  conda = "auto",
#  version = "default",
#  envname = "py3.6",
#  extra_packages = NULL,
#  restart_session = TRUE,
#  conda_python_version = "3.7",
#)

knitr::opts_chunk$set(fig.width = 8, fig.height = 8, message=F, warning=F, echo=F, results=F)

#Library Loads
p_load(tictoc)
p_load(janitor)
p_load(tidylog)
p_load(stringr)
p_load(ggdag)
p_load(data.table)
p_load(sf)
p_load(glue)
p_load(scales)
options(tigris_use_cache = TRUE)


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

########## Data Loads ---------------------------------------


rhs_codebook_total_clustered <- readRDS("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs_codebook_total_clustered.Rds")

yid_all <- readRDS( "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/yid_train.Rds")
x_all <- readRDS("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/x_train.Rds")
Folds1 <- readRDS( "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/Folds1.Rds")
xy_all <- cbind(yid_all[,'y'],x_all) %>% as.data.frame()
dim(xy_all)
#x_all_scaled <- x_all %>% scale() 

summary(yid_all$y_share14plus)
#x_train[,'y_share14plus']
#x_train[,'y']

x_all_variables <- data.frame(variables=colnames(x_all))

variable_clean_255 <- rhs_codebook_total_clustered$variable_clean_255
names(variable_clean_255) <-rhs_codebook_total_clustered$variable_clean
x_all_255 <- x_all
colnames(x_all_255) <- variable_clean_255[colnames(x_all)]

#https://github.com/microsoft/LightGBM/issues/283
get_lgbm_cv_preds <- function(cv){
  rows <- length(cv$boosters[[1]]$booster$.__enclos_env__$private$valid_sets[[1]]$.__enclos_env__$private$used_indices)+length(cv$boosters[[1]]$booster$.__enclos_env__$private$train_set$.__enclos_env__$private$used_indices)
  preds <- numeric(rows)
  for(i in 1:length(cv$boosters)){
    preds[
      cv$boosters[[i]]$booster$.__enclos_env__$private$valid_sets[[1]]$.__enclos_env__$private$used_indices] <-
      cv$boosters[[i]]$booster$.__enclos_env__$private$inner_predict(2)
  }
  return(preds)
}


########## Ablation Loop  ---------------------------------------
verbose=F
rounds=1:20
eligible_variables <- rhs_codebook_total_clustered$variable_clean_255
print(length(eligible_variables))
ablation=1 #default unti we checked to see how many finished rounds there's been
for(round in rounds){
  gc()
  
  try({
    restartspark()
    #treeshap_all <- arrow::open_dataset(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap/")) 
    treeshap_all <- spark_read_parquet(sc, path="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap/" ,memory=F) 
    
    #dim(treeshap_all)
    
    #used_vars_df <- treeshap_all %>% 
    #  dplyr::select(ablation, test_fold, variable, k_smallest, shap) %>% 
    #  dplyr::group_by(ablation,  k_smallest, variable) %>% 
    #  summarise(shap_cluster_total=sum(shap %>% abs())) %>%
    #  filter(shap_cluster_total==max(shap_cluster_total)) %>% 
    #  dplyr::arrange(ablation,shap_cluster_total %>% desc()) %>%
    #  collect()

    used_clusters_df <- treeshap_all %>% 
      dplyr::select(ablation, test_fold, k_smallest, shap) %>% #throws an error here if it's the first run
      dplyr::group_by(ablation,  k_smallest) %>% 
      summarise(shap_cluster_total=sum(shap %>% abs())) %>%
      filter(shap_cluster_total==max(shap_cluster_total))  %>% 
      collect() 
    
    print(used_clusters_df)
    used_clusters <- used_clusters_df %>% pull(k_smallest)
    ablation=length(used_clusters)+1
    print(used_clusters)
    eligible_variables <- rhs_codebook_total_clustered %>% filter(!k_smallest %in% used_clusters) %>% pull(variable_clean_255)
    print(length(eligible_variables))
    
    restartspark()
    treeshap_all <- NULL; gc()
  })
  
  folds=1:6
  for(fold in folds){
    
    yid_train <- yid_all[yid_all$fold!=fold,]
    x_train <- x_all_255[yid_all$fold!=fold,eligible_variables]
    yid_test <- yid_all[yid_all$fold==fold,]
    x_test <- x_all_255[yid_all$fold==fold,eligible_variables]
    
    cv_folds_list=lapply(yid_train$fold%>% unique(), FUN=function(x) which(yid_train$fold==x))

    #yup that's the reason
    library(lightgbm)
    #This is suprisingly slow, I guess because it's doing all the binning here
    dtrain=lgb.Dataset( x_train  %>% Rfast::data.frame.to_matrix(col.names=F) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                        label=yid_train[,'y_share14plus']  %>% Rfast::data.frame.to_matrix(col.names=F), feature_pre_filter=T, max_bin=15) 
    #for gpu it says we can get away with 15 bins, smaller number of bins speeds up cpu too when lots of features

    #Fit 5 fold CV on all possible features
    tic()
      lightgbm_cv_unpruned <- lgb.cv(
        params = list(
          boosting="gbdt", #dart #gbdt
          objective = "regression", 
          metric = "l2",
          learning_rate=0.1, #default 0.1
          #max_bin=63
          max_bin=15,
          #task="train",
          #num_leaves = 255,
          #gpu_use_dp=F,
          #device = 'gpu',
          tree_learner = 'feature', #'feature',
          #gpu_platform_id = 0,
          #gpu_device_id = 0,
          is_training_metric=F
        ),
        folds = cv_folds_list,
        data =dtrain ,
        early_stopping_rounds=10,
        num_threads=32, #feature parallel makes 128 way worse, 32 somehow faster
        force_col_wise=T,
        nrounds=1000,
        verbose=0
        #return_cvbooster=T
      )
    #So this is 4 minutes
    toc() #tree_learner feature gets that down to 4 #Shrinking the number of bins to 15 reduced the fit time to 4.5 minutes #this takes 10 minutes, 128 threads was actually slightly faster 9.9 minutes

    if(verbose){
      y_all <- yid_train[,'y_share14plus']$y_share14plus
      y_hat_lightgbm <- get_lgbm_cv_preds(lightgbm_cv_unpruned)
      
      summary(abs(y_all- y_hat_lightgbm ))
      #     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
      #0.0000086 0.0288985 0.0585476 0.0724966 0.0996328 0.4053946  #7.2% off CV 
      plot(y_all, y_hat_lightgbm)
      abline(coef = c(0,1)) #  
    }
    
    #Wow we don't actually need this step at all, never use
    #lightgbm_unpruned <- lgb.train(
    #  params = list(
    #    objective = "regression", 
    #    metric = "l2",
    #    learning_rate=0.1, #default 0.1, 0.05 was worse 0.2 was worse too
    #    max_bin=63
    #  )
    #  ,data = dtrain
    #  , nrounds = round(lightgbm_cv_unpruned$best_iter*1) #this performs better when it's full as the cv
    #  ,force_col_wise=T
    #)
    
    #y_test <- yid_test[,'y_share14plus']$y_share14plus
    #y_hat_lightgbm_unpruned <- predict(lightgbm_unpruned, x_test )
    #summary(abs(y_test- y_hat_lightgbm_unpruned ))
    #     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
    #0.0000276 0.0177338 0.0454322 0.0560570 0.0790354 0.4415007  5.6% off on average
    
    #since we're just pulling feature names we may not have to calculate actual importance and save some time here
    tic()
      importance1=lgb.importance(lightgbm_cv_unpruned$boosters[[1]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
      importance2=lgb.importance(lightgbm_cv_unpruned$boosters[[2]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
      importance3=lgb.importance(lightgbm_cv_unpruned$boosters[[3]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
      importance4=lgb.importance(lightgbm_cv_unpruned$boosters[[4]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
      importance5=lgb.importance(lightgbm_cv_unpruned$boosters[[5]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
      importances <- bind_rows(importance1,importance2,importance3,importance4,importance5) %>% clean_names() %>%  group_by(variable) %>% summarise(gain=mean(gain), cover=mean(cover), frequency=mean(frequency), folds_used=n()) %>% arrange(desc(gain))
    toc()
    
    #Here we decide which to keep, requiring it to appear in at least 3 any more or less drives down performance a lot
    importances_all5 <- importances %>% filter(folds_used>=3) %>% arrange(folds_used %>% desc(), gain %>% desc()) #leave this at 3, 4 really degrades performance
    
    vars_pruned <- importances_all5$variable
    length(vars_pruned)
    dtrain_pruned=lgb.Dataset( x_train[,vars_pruned]  %>% Rfast::data.frame.to_matrix(col.names=F) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                               label=yid_train[,'y_share14plus']  %>% Rfast::data.frame.to_matrix(col.names=F), feature_pre_filter=T, max_bin=63) #I can up it to 255 now
    lightgbm_cv_pruned <- lgb.cv(
      params = list(
        boosting="gbdt", #dart #gbdt
        objective = "regression", 
        metric = "l2",
        learning_rate=0.1, #default 0.1
        max_bin=63
      ),
      folds = cv_folds_list,
      data =dtrain_pruned ,
      early_stopping_rounds=10,
      num_threads=64,
      force_col_wise=T,
      nrounds=1000,
      #return_cvbooster=T,
      verbose=0
    )
    
    x_train_pruned=x_train[,vars_pruned]
    y_hat_lightgbm_pruned <- get_lgbm_cv_preds(lightgbm_cv_pruned)
    if(verbose){
      summary(abs(y_all- y_hat_lightgbm_pruned ))  
      #     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
      #0.0000091 0.0263566 0.0539701 0.0668619 0.0919933 0.4269607 #on the pruned set the validation performance improved to 6.6%
      plot(y_all, y_hat_lightgbm_pruned)
      abline(coef = c(0,1)) #  
    }

    #Don't need this either
    #lightgbm_pruned <- lgb.train(
    #  params = list(
    #    objective = "regression", 
    #    metric = "l2",
    #    learning_rate=0.1, #default 0.1
    #    max_bin=63
    #  )
    #  ,force_col_wise=T
    #  ,data = dtrain_pruned
    #  , nrounds = round(lightgbm_cv_pruned$best_iter*0.8) #iterating for 80% of the cv runs performance best, so we're now outperforming the full dataset with a fraction of the features
    #)
    
    #y_hat_test <- predict(lightgbm_pruned, x_test[,vars_pruned] )*100
    #y_test <- yid_test[,'y_share14plus']$y_share14plus*100
    #summary(abs(y_test- y_hat_test ))    
    #   Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    #0.05011  2.00674  4.12891  5.55416  7.33402 41.07800 #5.55% off when we back off the rounds 80%
    
    

    #Maybe we skip this shap step?
    #
    #This is in sample shap
    condition_test=yid_train[,'fold']!=unique(yid_train[,'fold'])$fold[1]
    y_test_df <- yid_train[condition_test,'y_share14plus'] %>% mutate(ID=row_number()) %>% mutate(y_hat=predict(lightgbm_cv_pruned$boosters[[1]]$booster, x_train_pruned[condition_test,])) %>% mutate(residual=y_hat-y_share14plus)
    shap_values1 <- SHAPforxgboost::shap.values(xgb_model = lightgbm_cv_pruned$boosters[[1]]$booster, X_train =  x_train_pruned[condition_test,] )
    shap_long1 <- SHAPforxgboost::shap.prep(xgb_model = lightgbm_cv_pruned$boosters[[1]]$booster, X_train = x_train_pruned[condition_test,]      ) %>% left_join(y_test_df) %>% 
      mutate(new_y_hat =y_hat-value) %>% mutate(new_residual=new_y_hat-y_share14plus)
    shap_loss1 <- shap_long1 %>% group_by(variable) %>% summarize(old_rmse=Metrics::mse(y_share14plus,y_hat), new_rmse=Metrics::mse(y_share14plus,new_y_hat)) %>% mutate(rmse_change_from_removing=new_rmse-old_rmse) 
    shap_importances1 <- SHAPforxgboost::shap.importance(shap_long1, names_only = FALSE, top_n = Inf) %>% left_join(shap_loss1) #it's identical
    
    condition_test=yid_train[,'fold']!=unique(yid_train[,'fold'])$fold[2]
    y_test_df <- yid_train[condition_test,'y_share14plus'] %>% mutate(ID=row_number()) %>% mutate(y_hat=predict(lightgbm_cv_pruned$boosters[[2]]$booster, x_train_pruned[condition_test,])) %>% mutate(residual=y_hat-y_share14plus)
    shap_values2 <- SHAPforxgboost::shap.values(xgb_model = lightgbm_cv_pruned$boosters[[2]]$booster, X_train =  x_train_pruned[condition_test,] )
    shap_long2 <- SHAPforxgboost::shap.prep(xgb_model = lightgbm_cv_pruned$boosters[[2]]$booster, X_train = x_train_pruned[condition_test,]      ) %>% left_join(y_test_df) %>% 
      mutate(new_y_hat =y_hat-value) %>% mutate(new_residual=new_y_hat-y_share14plus)
    shap_loss2 <- shap_long2 %>% group_by(variable) %>% summarize(old_rmse=Metrics::mse(y_share14plus,y_hat), new_rmse=Metrics::mse(y_share14plus,new_y_hat)) %>% mutate(rmse_change_from_removing=new_rmse-old_rmse) 
    shap_importances2 <- SHAPforxgboost::shap.importance(shap_long2, names_only = FALSE, top_n = Inf) %>% left_join(shap_loss2) #it's identical
    
    condition_test=yid_train[,'fold']!=unique(yid_train[,'fold'])$fold[3]
    y_test_df <- yid_train[condition_test,'y_share14plus'] %>% mutate(ID=row_number()) %>% mutate(y_hat=predict(lightgbm_cv_pruned$boosters[[3]]$booster, x_train_pruned[condition_test,])) %>% mutate(residual=y_hat-y_share14plus)
    shap_values3 <- SHAPforxgboost::shap.values(xgb_model = lightgbm_cv_pruned$boosters[[3]]$booster, X_train =  x_train_pruned[condition_test,] )
    shap_long3 <- SHAPforxgboost::shap.prep(xgb_model = lightgbm_cv_pruned$boosters[[3]]$booster, X_train = x_train_pruned[condition_test,]      ) %>% left_join(y_test_df) %>% 
      mutate(new_y_hat =y_hat-value) %>% mutate(new_residual=new_y_hat-y_share14plus)
    shap_loss3 <- shap_long3 %>% group_by(variable) %>% summarize(old_rmse=Metrics::mse(y_share14plus,y_hat), new_rmse=Metrics::mse(y_share14plus,new_y_hat)) %>% mutate(rmse_change_from_removing=new_rmse-old_rmse) 
    shap_importances3 <- SHAPforxgboost::shap.importance(shap_long3, names_only = FALSE, top_n = Inf) %>% left_join(shap_loss3) #it's identical
    
    
    condition_test=yid_train[,'fold']!=unique(yid_train[,'fold'])$fold[4]
    y_test_df <- yid_train[condition_test,'y_share14plus'] %>% mutate(ID=row_number()) %>% mutate(y_hat=predict(lightgbm_cv_pruned$boosters[[4]]$booster, x_train_pruned[condition_test,])) %>% mutate(residual=y_hat-y_share14plus)
    shap_values4 <- SHAPforxgboost::shap.values(xgb_model = lightgbm_cv_pruned$boosters[[4]]$booster, X_train =  x_train_pruned[condition_test,] )
    shap_long4 <- SHAPforxgboost::shap.prep(xgb_model = lightgbm_cv_pruned$boosters[[4]]$booster, X_train = x_train_pruned[condition_test,]      ) %>% left_join(y_test_df) %>% 
      mutate(new_y_hat =y_hat-value) %>% mutate(new_residual=new_y_hat-y_share14plus)
    shap_loss4 <- shap_long4 %>% group_by(variable) %>% summarize(old_rmse=Metrics::mse(y_share14plus,y_hat), new_rmse=Metrics::mse(y_share14plus,new_y_hat)) %>% mutate(rmse_change_from_removing=new_rmse-old_rmse) 
    shap_importances4 <- SHAPforxgboost::shap.importance(shap_long4, names_only = FALSE, top_n = Inf) %>% left_join(shap_loss4) #it's identical  
    
    
    condition_test=yid_train[,'fold']!=unique(yid_train[,'fold'])$fold[5]
    y_test_df <- yid_train[condition_test,'y_share14plus'] %>% mutate(ID=row_number()) %>% mutate(y_hat=predict(lightgbm_cv_pruned$boosters[[5]]$booster, x_train_pruned[condition_test,])) %>% mutate(residual=y_hat-y_share14plus)
    shap_values5 <- SHAPforxgboost::shap.values(xgb_model = lightgbm_cv_pruned$boosters[[5]]$booster, X_train =  x_train_pruned[condition_test,] )
    shap_long5 <- SHAPforxgboost::shap.prep(xgb_model = lightgbm_cv_pruned$boosters[[5]]$booster, X_train = x_train_pruned[condition_test,]      ) %>% left_join(y_test_df) %>% 
      mutate(new_y_hat =y_hat-value) %>% mutate(new_residual=new_y_hat-y_share14plus)
    shap_loss5 <- shap_long5 %>% group_by(variable) %>% summarize(old_rmse=Metrics::mse(y_share14plus,y_hat), new_rmse=Metrics::mse(y_share14plus,new_y_hat)) %>% mutate(rmse_change_from_removing=new_rmse-old_rmse) 
    shap_importances5 <- SHAPforxgboost::shap.importance(shap_long5, names_only = FALSE, top_n = Inf) %>% left_join(shap_loss5) #it's identical  
    
    
    # SHAP value: value
    # raw feature value: rfvalue;
    # standarized: stdfvalue
    shap_longs <- bind_rows(shap_long1,shap_long2,shap_long3,shap_long4,shap_long5) %>% group_by(variable) %>% 
      summarise(shap_max=max(value),shap_min=min(value), shap_range=max(value)-min(value)) %>% mutate(shap_range_greater1=shap_range>=0.01)
    
    shap_importances <- bind_rows(shap_importances1,shap_importances2,shap_importances3,shap_importances4,shap_importances5) %>% group_by(variable) %>% summarise(mean_abs_shap=mean(mean_abs_shap), rmse_change_from_removing=mean(rmse_change_from_removing))
    
    importances_all5_and_shap <- importances_all5 %>% 
      #left_join(py$sage_df) %>% 
      left_join(shap_importances) %>% 
      arrange(desc(rmse_change_from_removing)) %>%
      mutate(ablation=ablation) %>%
      mutate(test_fold=fold)
    
    importances_all5_and_shap %>% arrow::write_parquet(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap_first_stage/importances_all5_and_shap_ablation{ablation}_fold{fold}.parquet"))
    
    #plot(importances_all5_and_shap$gain, importances_all5_and_shap$rmse_change_from_removing)
    
    #x_train_pruned_shap <- x_train[,importances_all5_and_shap$variable, drop=F]
    #dim(x_train_pruned_shap)
    #library(infotheo)
    #mi_x_train_pruned_shap <-   mutinformation(discretize(x_train_pruned_shap), method="emp")
    #d_x_train_pruned_shap <- dist(-1*mi_x_train_pruned_shap)
    #hc_x_train_pruned_shap <- hclust(d_x_train_pruned_shap, method="ward.D2")
    #library(ggdendro)
    #hc_x_train_pruned_shap %>% ggdendrogram(rotate = TRUE, theme_dendro = FALSE)
    #importances_all5_and_shap$cluster10 <- cutree(hc_x_train_pruned_shap, k=5)[as.character(importances_all5_and_shap$variable)]
    
    #What want to do is greadily pick the top performing variable in each cluster, make that 1 through 10. Do it again
    #importances_all5_and_shap <- importances_all5_and_shap %>% group_by(cluster10) %>% mutate(cluster_rank=rank(rmse_change_from_removing)) %>% ungroup()
    
    #importances_all5_and_shap <- importances_all5_and_shap %>% arrange(desc(rmse_change_from_removing))
    #importances_all5_and_shap$orthogonal_rank <- NA
    #importances_all5_and_shap$condition <- F
    #used_cuts <- c()
    #for(i in 1:nrow(importances_all5_and_shap)){
    # print(i)
    # importances_all5_and_shap$condition <- is.na(importances_all5_and_shap$orthogonal_rank) & !importances_all5_and_shap$cluster10 %in% used_cuts
    # if(sum(importances_all5_and_shap$condition)==0){
    #   used_cuts <- c()
    #   importances_all5_and_shap$condition <- is.na(importances_all5_and_shap$orthogonal_rank) & !importances_all5_and_shap$cluster10 %in% used_cuts
    # }
    # greedy_pick=min(which(importances_all5_and_shap$condition==T))
    # print(greedy_pick)
    # importances_all5_and_shap$orthogonal_rank[greedy_pick] <- i
    # used_cuts <- c(used_cuts, importances_all5_and_shap$cluster10[greedy_pick])
    # if(length(used_cuts)>=5){used_cuts <- c()}
    #}
    
    ###################### Iterate feature by feature by cv rmse shap value and find the minimum number that's within 2% of the minimum in cv. Odds are that's close to the test minimum.
    #Average gain does better than sage or folds
    result_list <- list()

    #This fold picked 557 vars in at least 3, that's what's killing me. Also this fold has a higher test error than validation error which is unusual
    vars_pruned_folds_df <- importances_all5_and_shap %>%
      filter(folds_used>=3) %>% #restricting to 4 doesn't help
      arrange(desc(rmse_change_from_removing)) %>%  #desc(folds_used)
      filter(rmse_change_from_removing>=0.000005) #2 thousands of a percent floor seems to be pretty close to the test minimum settling on 5 thousand
      
    vars_pruned_2percMSE <- vars_pruned_folds_df$variable #set here and then potentially replace if we walk each var below
    walk_each_var <- F
    if(walk_each_var){
        print("Starting a sequential adding run which is the most time consuming")
        for(i in 1:nrow(vars_pruned_folds_df)){
          vars_pruned_folds <- vars_pruned_folds_df %>%
                              filter(row_number()<=i) %>%
                              pull(variable)
          length(vars_pruned_folds)
          
          
          dtrain_pruned_folds=lgb.Dataset( x_train[,vars_pruned_folds, drop=F]  %>% Rfast::data.frame.to_matrix(col.names=F)  , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                                           label=yid_train[,'y_share14plus'] %>% Rfast::data.frame.to_matrix(col.names=F) ,
                                           feature_pre_filter=T, max_bin=63)
          
          lightgbm_cv_pruned_shap <- lgb.cv(
            params = list(
              boosting="gbdt", #dart #gbdt
              objective = "regression", 
              metric = "l2",
              learning_rate=0.1, #default 0.1
              max_bin=63
            ),
            folds = cv_folds_list,
            data =dtrain_pruned_folds ,
            early_stopping_rounds=10,
            num_threads=64,
            force_col_wise=T,
            nrounds=1000,
            #return_cvbooster=T,
            verbose=0
          )
          y_all <- yid_train[,'y_share14plus']$y_share14plus
          y_hat_lightgbm_cv_pruned_shap <- get_lgbm_cv_preds(lightgbm_cv_pruned_shap)
          
          lightgbm_pruned_shap <- lgb.train(
            params = list(
              objective = "regression", 
              metric = "l2",
              learning_rate=0.1, #default 0.1
              max_bin=63
            )
            ,data = dtrain_pruned_folds
            , nrounds = round(lightgbm_cv_pruned_shap$best_iter*0.8)
            , verbose=0
            ,force_col_wise=T
            ,num_threads=64
          )
          y_hat_test_shap <- predict(lightgbm_pruned_shap, x_test[,vars_pruned_folds, drop=F] )
          y_test <- yid_test[,'y_share14plus']$y_share14plus
          
          result_list[[as.character(i)]] <- data.frame(x=i,
                                                       cv_best_iteration=lightgbm_cv_pruned_shap$best_iter,
                                                       rmse_test=Metrics::rmse(y_test,y_hat_test_shap),
                                                       rmse_cv=Metrics::rmse(y_all,y_hat_lightgbm_cv_pruned_shap),
                                                       rmse_test_null=Metrics::rmse(mean(y_all),y_test),
                                                       mae_test=Metrics::mae(y_test,y_hat_test_shap),
                                                       mae_cv=Metrics::mae(y_all,y_hat_lightgbm_cv_pruned_shap),
                                                       mae_test_null=Metrics::mae(mean(y_all),y_test)
          ) 
          
          if(verbose){
            result_list_df <- 
              bind_rows(result_list)  %>%
              mutate(rmse_cv_min=which(rmse_cv==min(rmse_cv))+1)  %>%
              mutate(rmse_test_min=which(rmse_test==min(rmse_test))+1) %>%
              mutate(rmse_cv_percmin=rmse_cv/min(rmse_cv)) %>%
              mutate(rmse_cv_percmin_within1perc= rmse_cv_percmin<1.02)  #within 2% of the minimum on validation is pretty close to within the minimum on test
            
            p <- result_list_df  %>% 
              ggplot(aes(x)) + 
              geom_point(aes(y=rmse_test ), col="red") +
              geom_point(aes(y=rmse_cv), col="blue") + 
              #geom_point(aes(y=mae_test ), col="red") +
              #geom_point(aes(y=mae_cv), col="blue") + 
              #geom_errorbar(aes(ymin=l_bound , ymax=u_bound ), colour="black", width=.1) +
              geom_vline(aes(xintercept = rmse_cv_min), linetype="dotted", color = "blue", size=1) +
              geom_vline(aes(xintercept = rmse_test_min), linetype="dotted", color = "red", size=1) +
              geom_vline(aes(xintercept = which(rmse_cv_percmin_within1perc==T) %>% min()), linetype="dotted", color = "purple", size=1) +
              geom_hline(aes(yintercept = rmse_test_null ), linetype="dotted", color = "black", size=1) 
            
            
            plot(p)
          }
          
        }
        
        result_list_df <- 
          bind_rows(result_list)  %>%
          mutate(rmse_cv_min=which(rmse_cv==min(rmse_cv))+1)  %>%
          mutate(rmse_test_min=which(rmse_test==min(rmse_test))+1) %>%
          mutate(rmse_cv_percmin=rmse_cv/min(rmse_cv)) %>%
          mutate(rmse_cv_percmin_within1perc= rmse_cv_percmin<1.02) %>%
          bind_cols(vars_pruned_folds_df) #this step can only happen out of the loop
        
        if(verbose){
          p <- result_list_df  %>% 
            ggplot(aes(x)) + 
            geom_point(aes(y=rmse_test ), col="red") +
            geom_point(aes(y=rmse_cv), col="blue") + 
            #geom_point(aes(y=mae_test ), col="red") +
            #geom_point(aes(y=mae_cv), col="blue") + 
            #geom_errorbar(aes(ymin=l_bound , ymax=u_bound ), colour="black", width=.1) +
            geom_vline(aes(xintercept = rmse_cv_min), linetype="dotted", color = "blue", size=1) +
            geom_vline(aes(xintercept = rmse_test_min), linetype="dotted", color = "red", size=1) +
            geom_vline(aes(xintercept = which(rmse_cv_percmin_within1perc==T) %>% min()), linetype="dotted", color = "purple", size=1) +
            geom_hline(aes(yintercept = rmse_test_null ), linetype="dotted", color = "black", size=1) 
          
          plot(p)
        }
        
        ###################### Of the 70 or so that's left refit the mdoel, see if we can't make it linear
        vars_pruned_2percMSE <- result_list_df %>%
          #arrange(desc(x)) %>%  #desc(folds_used) #don't arrange
          filter(row_number() <= (which(rmse_cv_percmin_within1perc==T) %>% min() )) %>% #restricting to 4 doesn't help
          pull(variable)
        length(vars_pruned_2percMSE)
    }
    x_train_pruned_2percMSE <- x_train[,vars_pruned_2percMSE]
    
    dtrain_pruned_2percMSE =lgb.Dataset( x_train_pruned_2percMSE  %>% Rfast::data.frame.to_matrix(col.names=T) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                                         label=yid_train[,'y_share14plus']  %>% Rfast::data.frame.to_matrix(col.names=F), feature_pre_filter=T, max_bin=255)
    
    
    #https://cran.r-project.org/web/packages/ParBayesianOptimization/vignettes/tuningHyperparameters.html
    #Nnow tune the final model before making predictions to give those features the best chance
    scoringFunction <- function(max_depth,  num_leaves, bagging_fraction, feature_fraction) { #min_data_in_leaf learning_rate

      lightgbm_cv_pruned_2percMSE<- lgb.cv(
        params = list(
          boosting="gbdt", #dart #gbdt
          objective = "regression", 
          metric = "l2",
          learning_rate=0.1, #learning_rate,#, #default 0.1
          num_leaves=num_leaves %>% round(),
          #" with `feature_pre_filter=true` may cause unexpected behaviour for features that were pre-filtered by the larger "
          #min_data_in_leaf=min_data_in_leaf %>% round(), #we set this in feature_pre filter
          max_depth=max_depth %>% round(),
          bagging_fraction=bagging_fraction,
          feature_fraction = feature_fraction
        ),
        folds = cv_folds_list,
        data =dtrain_pruned_2percMSE ,
        early_stopping_rounds=10,
        num_threads=32,
        force_col_wise=T,
        nrounds=1000,
        #return_cvbooster=T,
        verbose=0
      )
      
      return(
        list( 
          Score = lightgbm_cv_pruned_2percMSE$best_score*-1 #it maximizes so you have to do negative root mean squared
          , nrounds = lightgbm_cv_pruned_2percMSE$best_iter
        )
      )
    }
    
    bounds <- list( 
      max_depth = c(-1, 20L)
      #, min_data_in_leaf = c(0, 100)
      #, subsample = c(0.25, 1)
      , num_leaves=c(16,255)
      , bagging_fraction = c(.5,1)
      , feature_fraction = c(.3, 1)
      #,learning_rate=c(0.1,0.2) #
    )
    
    #dart is crazy slow. even if it was good we can't sustain it
    library(ParBayesianOptimization)
    set.seed(1234)
    optObj <- bayesOpt(
      FUN = scoringFunction
      , bounds = bounds
      , initPoints = 6
      , iters.n = 15
      , plotProgress = T
    )
    #optObj$scoreSummary
    #Running initial scoring function 10 times in 1 thread(s)...  415.054 seconds
    
    optObj$scoreSummary %>% 
      mutate(ablation=ablation) %>%
      mutate(test_fold=fold) %>%
      mutate_if(is.logical, as.numeric) %>%
      mutate_if(is.integer, as.numeric) %>%
      arrow::write_parquet(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/tuning/scoreSummary_ablation{ablation}_fold{fold}.parquet"), version="2.0") #2.0 did not fix it, now trying
    
    
    #we basically run this only to get the number of rounds
    #lightgbm_cv_pruned_2percMSE<- lgb.cv(
    #  params = list(
    #    objective = "regression", 
    #    metric = "l2",
    #    learning_rate=0.1, #default 0.1
    #    max_bin=63
    #  ),
    #  folds = cv_folds_list,
    #  data =dtrain_pruned_2percMSE ,
    #  early_stopping_rounds=10,
    #  num_threads=64,
    #  force_col_wise=T,
    #  nrounds=1000,
    #  #return_cvbooster=T,
    #  verbose=0
    #)
    
    optObj_best <- optObj$scoreSummary %>% janitor::clean_names() %>% arrange(score %>% desc()) %>% head(1)
      
    lightgbm_pruned_2percMSE <- lgb.train(
      params = list(
        boosting="gbdt", #dart
        objective = "regression", 
        metric = "l2",
        learning_rate=0.1, #learning_rate,#, #default 0.1
        num_leaves=optObj_best$num_leaves %>% round(),
        #" with `feature_pre_filter=true` may cause unexpected behaviour for features that were pre-filtered by the larger "
        #min_data_in_leaf=min_data_in_leaf %>% round(), #we set this in feature_pre filter
        max_depth=optObj_best$max_depth %>% round(),
        bagging_fraction=optObj_best$bagging_fraction#,
        #feature_fraction = optObj_best$feature_fraction
      )
      , data = dtrain_pruned_2percMSE
      , nrounds = (optObj_best$nrounds*0.8) %>% round()
      , verbose=0
      , force_col_wise=T
    )
    y_hat_test_2percMSE <- predict(lightgbm_pruned_2percMSE, x_test[,vars_pruned_2percMSE, drop=F] )
    y_test <- yid_test[,'y_share14plus']$y_share14plus
    summary(abs(y_test-y_hat_test_2percMSE)) #0.0524484 bettter than everything
    
    yid_test %>% mutate(y_hat_test_2percMSE=y_hat_test_2percMSE, fold=fold, ablation=ablation) %>% 
      arrow::write_parquet(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/performance/yid_test_ablation{ablation}_fold{fold}.parquet"))
    
    #devtools::install_github('ModelOriented/treeshap')
    library(treeshap)
    unified <- lightgbm.unify(lightgbm_pruned_2percMSE, x_train_pruned_2percMSE  )
    #head(unified$model)
    treeshap1 <- treeshap(unified,  x_train_pruned_2percMSE %>% as.data.frame() , verbose =1)
    
    treeshap_long <- 
        treeshap1$shaps  %>% 
        mutate(obs=row_number()) %>% 
        pivot_longer(-obs, values_to = "shap",names_to = "variable_clean_255") %>% 
        left_join( treeshap1$observations  %>% mutate(obs=row_number()) %>% 
                     pivot_longer(-obs, values_to = "covariate_value",names_to = "variable_clean_255") )  %>% 
        left_join(rhs_codebook_total_clustered, by=c('variable_clean_255') ) %>% #join the codebook on it
        group_by(variable) %>% 
          mutate(shap_variable_total= shap %>% abs() %>% sum() ) %>%
          mutate(covariate_value_scaled= covariate_value %>% scale() ) %>%
        ungroup() %>%
        group_by(k_smallest) %>% 
          mutate(shap_cluster_total= shap %>% abs() %>% sum() ) %>%
        ungroup() %>%
        mutate(test_fold=fold)  %>%
        mutate(ablation=ablation)
    
    #This write is actually very slow
    #Honest to god one of these is failing because fold is stored as an integer in one file and a double in another
    treeshap_long %>% 
      mutate_if(is.logical, as.numeric) %>%
      mutate_if(is.integer, as.numeric) %>%
      arrow::write_parquet(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap/treeshap_long_ablation{ablation}_fold{fold}.parquet"), version="2.0") #2.0 did not fix it, now trying
  
    #files <-     list.files(path = "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap/", pattern = NULL, all.files = FALSE,
    #           full.names = T, recursive = FALSE,
    #           ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)
    #for(file in files){
    #  print(file)
    #  file %>%
    #  arrow::read_parquet() %>% 
    #  mutate_if(is.logical, as.numeric) %>%
    #  mutate_if(is.integer, as.numeric) %>%
    #  arrow::write_parquet(glue::glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results/shap2/{basename(file)}"), version="2.0") #hoping switching to version 2.0 auto solves the schema problem
    #}
    
    
      
    treeshap_long <- NULL;    gc()
  }
  
}




