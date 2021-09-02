
#Reset env
rm(list = ls())
#.rs.restartR()
gc()

########## Library Loads ---------------------------------------
library(doParallel)
library(pacman)
p_load(tidyverse)
fromscratch=F

#conda_list()
#use_condaenv("py3.6", required = TRUE)

p_load(tictoc)
p_load(janitor)
p_load(tidylog)
p_load(stringr)
p_load(glue)
p_load(scales)

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


yid_test_exclude <- spark_read_parquet(sc, path="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude/performance/" ,memory=F) %>% collect()
yid_test_include <- spark_read_parquet(sc, path="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_include/performance/" ,memory=F) %>% collect() #include is broken

performance_include <- yid_test_include %>% collect() %>% group_by(ablation) %>% summarize(rmse_include=Metrics::rmse(y_hat_test_pruned_optimized, y_share18plus), mae_include=Metrics::mae(y_hat_test_pruned_optimized, y_share18plus))  
performance_exclude <- yid_test_exclude %>% collect() %>% group_by(ablation) %>% summarize(rmse_exclude=Metrics::rmse(y_hat_test_pruned_optimized, y_share18plus), mae_exclude=Metrics::mae(y_hat_test_pruned_optimized, y_share18plus))  

#performance_include %>% full_join(performance_exclude) %>% view()


########## Data Loads ---------------------------------------

yid_all <- readRDS( "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/yid_train.Rds")
x_all <- readRDS("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/x_train.Rds")

dim(x_all)
x_all[!is.finite(x_all)] <- NA
not_missingness <- colSums( !is.na(x_all) ) # / nrow(rhs_combined_wide)
nonzero <- colSums( x_all>0 , na.rm = T)
both <- colSums( !is.na(x_all) & x_all>0  , na.rm = T)
table(not_missingness<200) #there are 6k that have fewer than 500 obs
table(nonzero<200) #there are 6k that have fewer than 500 obs
table(both<200) #there are 6k that have fewer than 500 obs

x_all <- x_all[,both>500]

#install.packages("huxtable")
library(stringi)
rhs_codebook_total_coded <- arrow::open_dataset("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/rhs_codebook_spark/") %>% collect()

rhs_codebook_total_coded <- rhs_codebook_total_coded %>% 
  filter(!category_warning_dv %in% 1) #We're excluding warning DV from this
dim(rhs_codebook_total_coded)

setdiff( colnames(x_all), rhs_codebook_total_coded$variable_clean_255)
#setdiff(  rhs_codebook_total_coded$variable_clean_255, colnames(x_all)) #There are 1300 vars in the codebook that aren't in x_all. I believe that's because they were all NA and dropped
rhs_codebook_total_coded <- rhs_codebook_total_coded %>% filter(variable_clean_255 %in% colnames(x_all))

rhs_codebook_total_coded %>% dplyr::select(starts_with("category")) %>% colSums(na.rm=T) %>% sort()
variable_groups <- rhs_codebook_total_coded %>% dplyr::select(starts_with("category")) %>% colSums(na.rm=T) %>% sort() %>% names()
variable_groups <- variable_groups[!variable_groups %in% c("category_warning_dv","category_va_vaccinations")] #va vvaccinations isn't in xtable right onw and that's fine

Folds1 <- readRDS( "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/Folds1.Rds")
length(unlist(Folds1))
xy_all <- cbind(yid_all[,'y'],x_all) %>% as.data.frame()
dim(xy_all)
#x_all_scaled <- x_all %>% scale() 

summary(yid_all$y_share18plus)
#x_train[,'y_share18plus']
#x_train[,'y']

x_all_variables <- data.frame(variables=colnames(x_all))


#table(not_missingness<3050) #there are 6k that have fewer than 500 obs
#colnames(x_all)[not_missingness<1000] #They're almost all peurto rico related
#x_all_varies <- x_all[,not_missingness>500 & nonzero>500]  #lightgbm requires both a certain amount of nonmissingness and a certain amount of variation. Kill any variable with less than 500 obs or less than 500 nonzero obs

#rhs_codebook_total_coded_varies <- rhs_codebook_total_coded %>% filter(variable_clean_255 %in% colnames(x_all_varies))

#https://github.com/microsoft/LightGBM/issues/283
get_lgbm_cv_preds <- function(cv){
  rows <- length(cv$boosters[[1]]$booster$.__enclos_env__$private$valid_sets[[1]]$.__enclos_env__$private$used_indices)+length(cv$boosters[[1]]$booster$.__enclos_env__$private$train_set$.__enclos_env__$private$used_indices)
  preds <- numeric(rows)
  for(i in 1:length(cv$boosters)){
    preds[
      cv$boosters[[i]]$booster$.__enclos_env__$private$valid_sets[[1]]$.__enclos_env__$private$used_indices] <- cv$boosters[[i]]$booster$.__enclos_env__$private$inner_predict(2)
  }
  return(preds)
}


library(doParallel)
cl <- makeCluster(4)
registerDoParallel(cl)

########## Ablation Loop Include ---------------------------------------
verbose=F
eligible_variables <- rhs_codebook_total_coded$variable_clean_255
print(length(eligible_variables)) #24,265 


variable_groups <- performance_exclude %>% arrange(rmse_exclude) %>% pull(ablation) %>% 
                   str_replace("keep_",'') %>% setdiff("exclude_nothing") #%>%
                   #str_replace('poverty_income_earnings_food_stamps_labor_force_employment','poverty_income_earnings_food_stamps_labor_force_employment_earner_owner_costs') %>% str_replace('household','household_rooms_vacancy_allocation_of_allocation_rate') #We're cumulatively going to exclude more an more of these


for(masterseed in 1:5){
  
  set.seed(masterseed)
  masterparams = list(
    seed=masterseed,
    boosting="gbdt", #dart #gbdt #now goss seems slower somehow
    objective = "regression", 
    metric = "rmse",
    learning_rate=0.1, #default 0.1
    #max_bin=63
    #max_bin=15,
    #task="train",
    num_leaves = 31,
    max_depth=-1,
    #gpu_use_dp=F,
    #device = 'gpu',
    tree_learner = 'feature', #'feature',
    #gpu_platform_id = 0,
    #gpu_device_id = 0,
    is_training_metric=F
  )
  
  for(g in 1:length(variable_groups)  ){
      #group="transportation"
      print(g)
      ablation=paste0("exclude_",variable_groups[g])
      ablation_cumulative <- paste0(variable_groups[1:g], collapse=";")
      
      setdiff(variable_groups[1:g], colnames(rhs_codebook_total_coded) )
      condition <- rowSums(rhs_codebook_total_coded[,variable_groups[1:g], drop=F], na.rm=T) %in% 0 #reversing it for exclude, that and the file path are the only two things I changed for this script
      eligible_variables <- rhs_codebook_total_coded$variable_clean_255[condition]
      print(length(eligible_variables))
      print(eligible_variables %>% head(10))
      folds=1:5 #We can iterate quickly by just doing one fold over many variables and then switch it to 6 when we're running the full overnight
      for(fold in folds){
        #fold=1
        shap_out_file=glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude_cumulative/shap/treeshap_long_ablation_{ablation}_fold{fold}_seed{masterseed}.parquet")
        
        if(file.exists(shap_out_file)){next}
        
        tic()
        print(fold)
        print("Partition data")
        yid_train <- yid_all[yid_all$fold!=fold,]
        setdiff(eligible_variables, colnames(x_all))
        x_train <- x_all[yid_all$fold!=fold,eligible_variables, drop=F]
        
        yid_test <- yid_all[yid_all$fold==fold,]
        x_test <- x_all[yid_all$fold==fold,eligible_variables, drop=F]
        cv_folds_list=lapply(yid_train$fold%>% unique(), FUN=function(x) which(yid_train$fold==x))
        
        #yup that's the reason
        library(lightgbm)
        #This is suprisingly slow, I guess because it's doing all the binning here
        print("Fit all features")
        #If you include column 8 it crashes
        #saveRDS(x_train, "/home/skynet3/Downloads/x_train.Rds")
        #saveRDS(yid_train, "/home/skynet3/Downloads/yid_train.Rds")
        #saveRDS(cv_folds_list, "/home/skynet3/Downloads/cv_folds_list.Rds")
        dtrain=lgb.Dataset( x_train %>% scale()  %>% Rfast::data.frame.to_matrix(col.names=F) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                            label=yid_train[,'y_share18plus']  %>% Rfast::data.frame.to_matrix(col.names=F), feature_pre_filter=T, max_bin=15) 
        #for gpu it says we can get away with 15 bins, smaller number of bins speeds up cpu too when lots of features
        
        #Fit 5 fold CV on all possible features
        tic()
        lightgbm_cv_unpruned <- lgb.cv(
          params = masterparams,
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
          y_all <- yid_train[,'y_share18plus']$y_share18plus
          y_hat_lightgbm <- get_lgbm_cv_preds(lightgbm_cv_unpruned)
          
          summary(abs(y_all- y_hat_lightgbm ))
          #     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
          #0.0000086 0.0288985 0.0585476 0.0724966 0.0996328 0.4053946  #7.2% off CV 
          plot(y_all, y_hat_lightgbm)
          abline(coef = c(0,1)) #  
        }
        
        print("Find importances")
        tic()
        importance1=lgb.importance(lightgbm_cv_unpruned$boosters[[1]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
        importance2=lgb.importance(lightgbm_cv_unpruned$boosters[[2]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
        importance3=lgb.importance(lightgbm_cv_unpruned$boosters[[3]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
        importance4=lgb.importance(lightgbm_cv_unpruned$boosters[[4]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
        #importance5=lgb.importance(lightgbm_cv_unpruned$boosters[[5]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
        #,importance5
        importances <- bind_rows(importance1,importance2,importance3,importance4) %>% clean_names() %>%  group_by(variable) %>% summarise(gain=mean(gain), cover=mean(cover), frequency=mean(frequency), folds_used=n()) %>% arrange(desc(gain))
        toc() #30 seconds here
        
        #Here we decide which to keep, requiring it to appear in at least 3 any more or less drives down performance a lot
        importances_all5 <- importances %>% filter(folds_used>=3) %>% arrange(folds_used %>% desc(), gain %>% desc()) #leave this at 3, 4 really degrades performance
        
        vars_pruned <- importances_all5$variable %>% as.character()
        length(vars_pruned)
        dtrain_pruned=lgb.Dataset( x_train[,vars_pruned, drop=F] %>% scale()   %>% Rfast::data.frame.to_matrix(col.names=T) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                                   label=yid_train[,'y_share18plus']  %>% Rfast::data.frame.to_matrix(col.names=T), feature_pre_filter=T, max_bin=255) #I can up it to 255 now
        
        #Refit to the pruned data so we can more easily run shap
        tic()
        lightgbm_cv_pruned <- lgb.cv(
          params = masterparams,
          folds = cv_folds_list,
          data =dtrain_pruned ,
          early_stopping_rounds=10,
          num_threads=32, #feature parallel makes 128 way worse, 32 somehow faster
          force_col_wise=T,
          nrounds=1000,
          verbose=0
          #return_cvbooster=T
        )
        toc()
        
        print("Find Shaps")
        #Now get shap values for every test observation, and then see how the RMSE would change if that var weren't in the model. Order the vars from least to most important by that amount.
        y_hat_lightgbm_cv_pruned <- get_lgbm_cv_preds(lightgbm_cv_pruned)
        #yid_train[,'y_share18plus']
        library(treeshap)
        unified1 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[1]]$booster, x_train[,vars_pruned, drop=F]   )
        treeshap1 <- treeshap(unified1,  x_train[cv_folds_list[[1]],vars_pruned, drop=F]  %>% as.data.frame() , verbose =0)
        treeshap1_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[1]]]) - treeshap1$shaps #the prediction if we subtracted off the contribution of each varibale
        
        unified2 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[2]]$booster, x_train[,vars_pruned, drop=F]   )
        treeshap2 <- treeshap(unified2,  x_train[cv_folds_list[[2]],vars_pruned, drop=F]  %>% as.data.frame() , verbose =0)
        treeshap2_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[2]]]) - treeshap2$shaps
        
        unified3 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[3]]$booster, x_train[,vars_pruned, drop=F]   )
        treeshap3 <- treeshap(unified3,  x_train[cv_folds_list[[3]],vars_pruned, drop=F]  %>% as.data.frame() , verbose =0)
        treeshap3_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[3]]]) - treeshap3$shaps
        
        unified4 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[4]]$booster, x_train[,vars_pruned, drop=F]   )
        treeshap4 <- treeshap(unified4,  x_train[cv_folds_list[[4]],vars_pruned, drop=F]  %>% as.data.frame() , verbose =0)
        treeshap4_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[4]]]) - treeshap4$shaps
        
        #unified5 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[5]]$booster, x_train[,vars_pruned, drop=F]   )
        #treeshap5 <- treeshap(unified5,  x_train[cv_folds_list[[5]],vars_pruned, drop=F]  %>% as.data.frame() , verbose =0)
        #treeshap5_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[5]]]) - treeshap5$shaps
        
        y_hat_rmse <- Metrics::rmse(y_hat_lightgbm_cv_pruned,yid_train[,'y_share18plus']$y_share18plus)
        ordering <- c(cv_folds_list[[1]],cv_folds_list[[2]],cv_folds_list[[3]],cv_folds_list[[4]]) #cv_folds_list[[5]]
        treeshap_hat <- bind_rows(treeshap1_hat,treeshap2_hat,treeshap3_hat,treeshap4_hat) #treeshap5_hat
        shap_rmse <- sapply(bind_rows(treeshap1_hat,treeshap2_hat,treeshap3_hat,treeshap4_hat), FUN=function(x) Metrics::rmse(x, yid_train[ordering,'y_share18plus']$y_share18plus)) #the rmse of the altered prediction #treeshap5_hat
        
        variable_shape_order <- names(rev(sort(shap_rmse))) %>% as.character()
        
        #Now tune the model, varying depth, leaves, and how many features to leave in in order of importance
        #Instead of having to iterate now over all X-hundred features, we can sample 30ish times and be reasonably confident we picked the right amount. Plus we get to vary other parameters.
        #https://cran.r-project.org/web/packages/ParBayesianOptimization/vignettes/tuningHyperparameters.html
        
        #When there's too much missingness it fails
        scoringFunction <- function(max_depth=-1L,  num_leaves=31L, bagging_fraction=1, feature_fraction=1, features_to_keep) { #min_data_in_leaf learning_rate
          print(features_to_keep)
          try({
            dtrain_pruned_subset=lgb.Dataset( x_train[,variable_shape_order[1:features_to_keep], drop=F] %>% scale()  %>% Rfast::data.frame.to_matrix(col.names=T) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                                              label=yid_train[,'y_share18plus']  %>% Rfast::data.frame.to_matrix(col.names=T), feature_pre_filter=T, max_bin=255) #I can up it to 255 now
            
            lightgbm_cv_pruned_subset <- lgb.cv(
              params = masterparams,
              folds = cv_folds_list,
              data =dtrain_pruned_subset ,
              early_stopping_rounds=10,
              num_threads=21, #going to lower this to 21 from 32 and see if we can't parallel 3 of them
              force_col_wise=T,
              nrounds=1000,
              #return_cvbooster=T,
              verbose=0
            )
            
            return(
              list( 
                Score = lightgbm_cv_pruned_subset$best_score*-1 #it maximizes so you have to do negative root mean squared
                , nrounds = lightgbm_cv_pruned_subset$best_iter
              )
            )
          })
          
          return(
            list( 
              Score = -999999 #it maximizes so you have to do negative root mean squared
              , nrounds = -999999
            )
          )
        }
        
        num_features <- as.integer(length(variable_shape_order))
        feature_range <- 1:num_features
        condition <- runif(n=length(feature_range)) > (feature_range/num_features)^(1/10)
        if(sum(condition)<10){condition <- rep(T,num_features)}
        feature_range_surviving <- feature_range[condition]
        
        clusterEvalQ(cl,expr= {
          library(lightgbm)
          library(tidyverse)
        })
        clusterExport(cl,c('cv_folds_list','x_train','yid_train','variable_shape_order','scoringFunction'))
        
        print("Subset features")
        library(pbapply)
        results <- pblapply(feature_range_surviving, FUN = function(x){ scoringFunction(features_to_keep=x) } , cl=cl)
        optObj <- bind_rows(results)
        optObj$features_to_keep=feature_range_surviving
        #optObj %>% ggplot(aes(x=features_to_keep,y=Score)) + geom_line()
        
        #Final fit, to all of the data, with our final subset of features, and final paramaters
        optObj_best <- optObj %>% janitor::clean_names() %>% arrange(score %>% desc()) %>% head(1)
        vars_final=variable_shape_order[1:optObj_best$features_to_keep]
        dtrain_pruned_subset=lgb.Dataset( x_train[,vars_final, drop=F]   %>% Rfast::data.frame.to_matrix(col.names=T) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                                          label=yid_train[,'y_share18plus']  %>% Rfast::data.frame.to_matrix(col.names=T), feature_pre_filter=T, max_bin=255) #I can up it to 255 now
        
        print("Final Fit")
        lightgbm_pruned_optimized <- lgb.train(
          params = masterparams
          , data = dtrain_pruned_subset
          , nrounds = (optObj_best$nrounds*1) %>% round()
          , verbose=0
          , force_col_wise=T
          , num_threads=32
        )
        
        #importance_pruned_optimized=lgb.importance(lightgbm_pruned_optimized, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
        
        #Make our final predictions on that test hold out set
        y_hat_test_pruned_optimized <- predict(lightgbm_pruned_optimized, x_test[,vars_final, drop=F] )
        y_test <- yid_test[,'y_share18plus']$y_share18plus
        summary(abs(y_test-y_hat_test_pruned_optimized)) #0.0524484 bettter than everything
        #      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
        #0.0000119 0.0205543 0.0451527 0.0548780 0.0757547 0.3324835 
        suppressMessages(
          yid_test %>% 
            mutate(y_hat_test_pruned_optimized=y_hat_test_pruned_optimized, fold=fold, ablation=ablation, ablation_cumulative=ablation_cumulative, seed=masterseed) %>% 
            arrow::write_parquet(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude_cumulative/performance/yid_test_ablation_{ablation}_fold{fold}_seed{masterseed}.parquet"))
        )
        
        #And save final shap values for that test hold out set
        #devtools::install_github('ModelOriented/treeshap')
        print("Final Importance")
        library(treeshap)
        unified <- lightgbm.unify(lightgbm_pruned_optimized, x_train[,vars_final, drop=F] %>% as.data.frame()  )
        #head(unified$model)
        treeshap1 <- treeshap(unified,  x_test[,vars_final, drop=F] %>% as.data.frame() , verbose =1)
        
        suppressMessages(
          treeshap_long <- 
            treeshap1$shaps  %>% 
            mutate(obs=row_number()) %>% 
            pivot_longer(-obs, values_to = "shap",names_to = "variable_clean_255") %>% 
            left_join( treeshap1$observations  %>% mutate(obs=row_number()) %>% 
                         pivot_longer(-obs, values_to = "covariate_value",names_to = "variable_clean_255") )  %>% 
            left_join(rhs_codebook_total_coded, by=c('variable_clean_255') ) %>% #join the codebook on it
            group_by(variable) %>% 
            mutate(shap_variable_total= shap %>% abs() %>% sum() ) %>%
            mutate(covariate_value_scaled= covariate_value %>% scale() ) %>%
            ungroup() %>%
            mutate(test_fold=fold)  %>%
            mutate(ablation=ablation, ablation_cumulative=ablation_cumulative) %>%
            mutate(seed=masterseed)
        )
        suppressMessages(
          treeshap_long %>% 
            mutate_if(is.logical, as.numeric) %>%
            mutate_if(is.integer, as.numeric) %>%
            arrow::write_parquet(shap_out_file, version="2.0") #2.0 did not fix it, now trying
        )
        treeshap_long <- NULL;    gc()
        
        treeshap_interactions <- treeshap(unified,  x_test[,vars_final, drop=F] %>% as.data.frame() , verbose =1, interactions = T)
        
        #treeshap_interactions$interactions['yale_percent_who_self_report_somewhat_strongly_disagree_that_global_warming_is_affecting_the_weather_in_the_united_states',,]
        
        k=ncol(treeshap_interactions$interactions)
        for(var_num in 1:k){
          print(var_num)
          shap_out_file2=glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude_cumulative/shap_interactions/treeshap_long_ablation_{ablation}_fold{fold}_variable{var_num}_seed{masterseed}.parquet")
          
          x_long <- x_test[,vars_final, drop=F] %>% as.data.frame() %>% mutate(i=row_number()) %>% pivot_longer(-i) %>% dplyr::select(-i) %>%  mutate(fips = rep(yid_test$fips, length.out=nrow(yid_test) * length(vars_final)))
          
          df <- as.data.frame(treeshap_interactions$interactions[var_num,,])
          df$variable_a <- vars_final[var_num]
          df$variable_b <- vars_final
          df_long <- df %>% pivot_longer(cols=-c(variable_a,variable_b))
          df_long$fips <- rep(yid_test$fips, nrow(df_long)/nrow(yid_test))
          
          df_long2 <- df_long %>% rename(shap=value) %>% left_join(x_long %>% rename(covariate_value_a=value), by=c('variable_a'='name','fips')) %>% left_join(x_long %>% rename(covariate_value_b=value), by=c('variable_b'='name','fips')) %>% dplyr::select(-name)
          df_long2$ablation <- ablation
          df_long2$seed=masterseed
          df_long2 %>% arrow::write_parquet(shap_out_file2, version="2.0") #2.0 did not fix it, now trying
          
        }
        
        toc()
      }
      
      #After each var, fire off a script to knit the results so you can look at them while it goes
      #command <- "Rscript -e 'library(rmarkdown); rmarkdown::render(\"/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/docs/Douglass_et_al_2021_WhatExplainsVaccinationRates_SummarizeResults.Rmd\", \"html_document\")'"
      #system(command, wait = F, ignore.stdout = T, show.output.on.console =F)
      
  }

}
stopCluster(cl)
registerDoSEQ()



