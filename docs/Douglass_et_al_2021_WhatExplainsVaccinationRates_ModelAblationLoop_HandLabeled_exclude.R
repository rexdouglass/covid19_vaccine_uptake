

#Reset env
rm(list = ls())
#.rs.restartR()
gc()

########## Library Loads ---------------------------------------
library(doParallel)
library(pacman)
p_load(tidyverse)
Sys.setenv(LD_LIBRARY_PATH="/usr/lib/cuda:/usr/lib/cuda/lib64:/usr/lib/cuda/include:" %>% paste0(Sys.getenv("LD_LIBRARY_PATH") ) )
Sys.getenv("LD_LIBRARY_PATH")

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
#Library Loads
p_load(tictoc)
p_load(janitor)
p_load(tidylog)
p_load(stringr)
p_load(glue)
p_load(scales)

library(tidyverse)

########## Data Loads ---------------------------------------

#install.packages("huxtable")
library(stringi)
rhs_codebook_total_coded <- read.csv(file="/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/rhs_codebook_total_coded.csv") %>% 
  janitor::clean_names() %>% #for these columns
  mutate(variable_clean = variable %>% janitor::make_clean_names()  ) %>% #for these variable names
  mutate(variable_clean_255 = abbreviate(variable_clean, 255, strict=T)  ) %>%
  mutate(variable_clean_255_dupe = duplicated(variable_clean_255)) %>%
  mutate(variable_clean_255 = ifelse(variable_clean_255_dupe, variable %>% abbreviate(200, strict=T) %>% paste0(row_number()) , variable_clean_255 )     ) %>%
  #mutate( variable_clean_255 = stringi::stri_replace_all_fixed("[],{}":"),"")  ) %>%
  #Further remove json characters
  mutate( variable_clean_255 = variable_clean_255 %>% stringi::stri_replace_all_fixed("[","")  ) %>% #https://github.com/awslabs/autogluon/issues/399
  mutate( variable_clean_255 = variable_clean_255 %>% stringi::stri_replace_all_fixed("]","")  ) %>% 
  mutate( variable_clean_255 = variable_clean_255 %>% stringi::stri_replace_all_fixed(",","")  ) %>%
  mutate( variable_clean_255 = variable_clean_255 %>% stringi::stri_replace_all_fixed("{","")  ) %>%
  mutate( variable_clean_255 = variable_clean_255 %>% stringi::stri_replace_all_fixed("}","")  ) %>%
  mutate( variable_clean_255 = variable_clean_255 %>%  stringi::stri_replace_all_fixed("\"","") ) # %>%
  
dim(rhs_codebook_total_coded)
#We're also going to drop any acs1s that show up in acs5
acs5_to_remove <- rhs_codebook_total_coded %>% filter(dataset %in% "acs5") %>% pull(description_stemmed) %>% unique()

rhs_codebook_total_coded <- rhs_codebook_total_coded %>% 
  filter(!(dataset %in% "acs1" & description_stemmed %in% acs5_to_remove)) %>%
  dplyr::select(-variable_short, -variable_short_group, -dataset,-description_stemmed, -variable_clean_255_dupe) %>%
  ####
  filter(!warning_dv %in% 1) #We're excluding warning DV from this

dim(rhs_codebook_total_coded)
rhs_codebook_total_coded %>% dplyr::select(-variable, -variable_clean_255, -variable_clean) %>% colSums(na.rm=T) %>% sort()
variable_groups <- rhs_codebook_total_coded %>% dplyr::select(-variable, -variable_clean_255, -variable_clean) %>% colSums(na.rm=T) %>% sort() %>% names()
variable_groups <- variable_groups[!variable_groups %in% "warning_dv"]

yid_all <- readRDS( "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/yid_train.Rds")
x_all <- readRDS("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/x_train.Rds")

not_missingness <- colSums( !is.na(x_all) ) # / nrow(rhs_combined_wide)
table(not_missingness<2000) #there are 6k that have fewer than 500 obs
#colnames(x_all)[not_missingness<1000] #They're almost all peurto rico related
x_all <- x_all[,not_missingness>2000]  

Folds1 <- readRDS( "/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/data_out/Folds1.Rds")
xy_all <- cbind(yid_all[,'y'],x_all) %>% as.data.frame()
dim(xy_all)
#x_all_scaled <- x_all %>% scale() 

summary(yid_all$y_share18plus)
#x_train[,'y_share18plus']
#x_train[,'y']

x_all_variables <- data.frame(variables=colnames(x_all))

rhs_codebook_total_coded$variable_clean <- rhs_codebook_total_coded$variable %>% janitor::make_clean_names() #actually quite slow
#setdiff(colnames(x_all), rhs_codebook_total_coded$variable_clean) #make sure all the names are n there

rhs_codebook_total_coded <- rhs_codebook_total_coded %>% filter(variable_clean %in% colnames(x_all)) #there's two random x and x_2 from the google sheet
#setdiff( rhs_codebook_total_coded$variable_clean, colnames(x_all))

variable_clean_255 <- rhs_codebook_total_coded$variable_clean_255
names(variable_clean_255) <-rhs_codebook_total_coded$variable_clean #wow this is that R bug where it'll silently do partial matching
x_all_255 <- x_all[,rhs_codebook_total_coded$variable_clean]
colnames(x_all_255) <- variable_clean_255[colnames(x_all_255)]
dim(x_all_255)

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
  

library(doParallel)
cl <- makeCluster(4)
registerDoParallel(cl)
  
  ########## Ablation Loop Include ---------------------------------------
  verbose=F
  eligible_variables <- rhs_codebook_total_coded$variable_clean_255
  print(length(eligible_variables)) #15,815 removing the acs1 in acs5 gets us down to 15k
  for(group in variable_groups){
    
    print(group)
    ablation=paste0("keep_",group)
    
    condition <- !rhs_codebook_total_coded[,group] %in% 1 #reversing it for exclude, that and the file path are the only two things I changed for this script
    eligible_variables <- rhs_codebook_total_coded$variable_clean_255[condition]
    
    folds=1:6 #We can iterate quickly by just doing one fold over many variables and then switch it to 6 when we're running the full overnight
    for(fold in folds){
      shap_out_file=glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude/shap/treeshap_long_ablation_{ablation}_fold{fold}.parquet")
      if(file.exists(shap_out_file)){next}
      
      tic()
      print(fold)
      print("Partition data")
      yid_train <- yid_all[yid_all$fold!=fold,]
      x_train <- x_all_255[yid_all$fold!=fold,eligible_variables]
      yid_test <- yid_all[yid_all$fold==fold,]
      x_test <- x_all_255[yid_all$fold==fold,eligible_variables]
      
      cv_folds_list=lapply(yid_train$fold%>% unique(), FUN=function(x) which(yid_train$fold==x))
      
      #yup that's the reason
      library(lightgbm)
      #This is suprisingly slow, I guess because it's doing all the binning here
      print("Fit all features")
      dtrain=lgb.Dataset( x_train  %>% Rfast::data.frame.to_matrix(col.names=F) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                          label=yid_train[,'y_share18plus']  %>% Rfast::data.frame.to_matrix(col.names=F), feature_pre_filter=T, max_bin=15) 
      #for gpu it says we can get away with 15 bins, smaller number of bins speeds up cpu too when lots of features
      
      #Fit 5 fold CV on all possible features
      tic()
        lightgbm_cv_unpruned <- lgb.cv(
          params = list(
            boosting="gbdt", #dart #gbdt #now goss seems slower somehow
            objective = "regression", 
            metric = "rmse",
            learning_rate=0.1, #default 0.1
            #max_bin=63
            #max_bin=15,
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
        importance5=lgb.importance(lightgbm_cv_unpruned$boosters[[5]]$booster, percentage = TRUE) %>% mutate(variable=Feature %>% str_replace("Column_","") %>% as.numeric()  ) %>% mutate(variable=colnames(x_train)[variable+1])
        importances <- bind_rows(importance1,importance2,importance3,importance4,importance5) %>% clean_names() %>%  group_by(variable) %>% summarise(gain=mean(gain), cover=mean(cover), frequency=mean(frequency), folds_used=n()) %>% arrange(desc(gain))
      toc() #30 seconds here
      
      #Here we decide which to keep, requiring it to appear in at least 3 any more or less drives down performance a lot
      importances_all5 <- importances %>% filter(folds_used>=3) %>% arrange(folds_used %>% desc(), gain %>% desc()) #leave this at 3, 4 really degrades performance
      
      vars_pruned <- importances_all5$variable %>% as.character()
      length(vars_pruned)
      dtrain_pruned=lgb.Dataset( x_train[,vars_pruned]  %>% Rfast::data.frame.to_matrix(col.names=T) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                                 label=yid_train[,'y_share18plus']  %>% Rfast::data.frame.to_matrix(col.names=T), feature_pre_filter=T, max_bin=255) #I can up it to 255 now
  
      #Refit to the pruned data so we can more easily run shap
      tic()
        lightgbm_cv_pruned <- lgb.cv(
          params = list(
            boosting="gbdt", #dart #gbdt #now goss seems slower somehow
            objective = "regression", 
            metric = "rmse",
            learning_rate=0.1, #default 0.1
            #max_bin=63
            #max_bin=15,
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
      unified1 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[1]]$booster, x_train[,vars_pruned]   )
      treeshap1 <- treeshap(unified1,  x_train[cv_folds_list[[1]],vars_pruned]  %>% as.data.frame() , verbose =0)
      treeshap1_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[1]]]) - treeshap1$shaps #the prediction if we subtracted off the contribution of each varibale
      
      unified2 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[2]]$booster, x_train[,vars_pruned]   )
      treeshap2 <- treeshap(unified2,  x_train[cv_folds_list[[2]],vars_pruned]  %>% as.data.frame() , verbose =0)
      treeshap2_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[2]]]) - treeshap2$shaps
  
      unified3 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[3]]$booster, x_train[,vars_pruned]   )
      treeshap3 <- treeshap(unified3,  x_train[cv_folds_list[[3]],vars_pruned]  %>% as.data.frame() , verbose =0)
      treeshap3_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[3]]]) - treeshap3$shaps
  
      unified4 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[4]]$booster, x_train[,vars_pruned]   )
      treeshap4 <- treeshap(unified4,  x_train[cv_folds_list[[4]],vars_pruned]  %>% as.data.frame() , verbose =0)
      treeshap4_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[4]]]) - treeshap4$shaps
      
      unified5 <- lightgbm.unify(lightgbm_cv_pruned$boosters[[5]]$booster, x_train[,vars_pruned]   )
      treeshap5 <- treeshap(unified5,  x_train[cv_folds_list[[5]],vars_pruned]  %>% as.data.frame() , verbose =0)
      treeshap5_hat <- as.matrix(y_hat_lightgbm_cv_pruned[cv_folds_list[[5]]]) - treeshap5$shaps
      
      y_hat_rmse <- Metrics::rmse(y_hat_lightgbm_cv_pruned,yid_train[,'y_share18plus']$y_share18plus)
      ordering <- c(cv_folds_list[[1]],cv_folds_list[[2]],cv_folds_list[[3]],cv_folds_list[[4]],cv_folds_list[[5]])
      treeshap_hat <- bind_rows(treeshap1_hat,treeshap2_hat,treeshap3_hat,treeshap4_hat,treeshap5_hat)
      shap_rmse <- sapply(bind_rows(treeshap1_hat,treeshap2_hat,treeshap3_hat,treeshap4_hat,treeshap5_hat), FUN=function(x) Metrics::rmse(x, yid_train[ordering,'y_share18plus']$y_share18plus)) #the rmse of the altered prediction
      
      variable_shape_order <- names(rev(sort(shap_rmse))) %>% as.character()
  
      #Now tune the model, varying depth, leaves, and how many features to leave in in order of importance
      #Instead of having to iterate now over all X-hundred features, we can sample 30ish times and be reasonably confident we picked the right amount. Plus we get to vary other parameters.
      #https://cran.r-project.org/web/packages/ParBayesianOptimization/vignettes/tuningHyperparameters.html

      #When there's too much missingness it fails
      scoringFunction <- function(max_depth=-1L,  num_leaves=2, bagging_fraction=1, feature_fraction=1, features_to_keep) { #min_data_in_leaf learning_rate
        #print(features_to_keep)
        try({
          dtrain_pruned_subset=lgb.Dataset( x_train[,variable_shape_order[1:features_to_keep]]  %>% Rfast::data.frame.to_matrix(col.names=T) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                                     label=yid_train[,'y_share18plus']  %>% Rfast::data.frame.to_matrix(col.names=T), feature_pre_filter=T, max_bin=255) #I can up it to 255 now
          
          lightgbm_cv_pruned_subset <- lgb.cv(
            params = list(
              boosting="gbdt", #dart #gbdt
              objective = "regression", 
              metric = "rmse",
              learning_rate=0.1, #learning_rate,#, #default 0.1
              num_leaves=num_leaves %>% round(),
              #" with `feature_pre_filter=true` may cause unexpected behaviour for features that were pre-filtered by the larger "
              #min_data_in_leaf=min_data_in_leaf %>% round(), #we set this in feature_pre filter
              max_depth=max_depth %>% round()#,
              #bagging_fraction=bagging_fraction,
              #feature_fraction = feature_fraction
            ),
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
      feature_range_surviving <- feature_range[condition]

      clusterEvalQ(cl,expr= {
        library(lightgbm)
        library(tidyverse)
      })
      clusterExport(cl,c('cv_folds_list','x_train','yid_train','variable_shape_order','scoringFunction'))

      library(pbapply)
      results <- pblapply(feature_range_surviving, FUN = function(x){ scoringFunction(features_to_keep=x) } , cl=cl)
      optObj <- bind_rows(results)
      optObj$features_to_keep=feature_range_surviving
      #loess1_Score <- loess(Score ~ features_to_keep, data=optObj, span=0.1)
      #loess1_nrounds <- loess(nrounds ~ features_to_keep, data=optObj, span=0.1)
      #optObj$features_to_keep_hat <- loess1_Score$fitted
      #p <- optObj%>% ggplot(aes(x=features_to_keep, y=Score)) + geom_line() #+ geom_line(aes(y=features_to_keep_hat) , col='red') 
      #print(p)
      
      # bounds <- list( 
      #   #max_depth = c(-1L, 100L) #If you put L it understands integers
      #   #, min_data_in_leaf = c(0, 100)
      #   #, subsample = c(0.25, 1)
      #   #, num_leaves= c(2L,255L)
      #    features_to_keep=c(2L, as.integer(length(variable_shape_order)))
      #   #, bagging_fraction = c(.5,1)
      #   #, feature_fraction = c(.3, 1)
      #   #,learning_rate=c(0.1,0.2) #
      # )
      # 
      # if(length(variable_shape_order)>=12){
      #   #dart is crazy slow. even if it was good we can't sustain it
      #   print("Start optimizing")
      #   optObj <- NULL
      #   tic()
      #     library(ParBayesianOptimization)
      #     set.seed(1234)
      #     optObj <- bayesOpt(
      #       FUN = scoringFunction
      #       , acqThresh= 1 #0.7 #lowering the acq threshold lead to fewer conflicts and it's trying more things
      #       , bounds = bounds
      #       , iters.k = 4
      #       , initPoints = min(ceiling(length(variable_shape_order)/4), 100) #if you sample more than 100 it throws an error
      #       , iters.n = 400 #I think we can get away with just 30 #it only needs to be 10 bc we're running 4 threads
      #       , plotProgress = F
      #       , verbose=0
      #       , parallel = TRUE
      #       , otherHalting = list(timeLimit = 120)
      #     )
      #   toc() #That's another 3 minutes
      #   
      #   #optObj$scoreSummary
      #   #Running initial scoring function 10 times in 1 thread(s)...  415.054 seconds
      #   #View(optObj$scoreSummary )
      #   optObj$scoreSummary %>% 
      #     mutate(ablation=ablation) %>%
      #     mutate(test_fold=fold) %>%
      #     mutate_if(is.logical, as.numeric) %>%
      #     mutate_if(is.integer, as.numeric) %>%
      #     arrow::write_parquet(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude/tuning/scoreSummary_ablation{ablation}_fold{fold}.parquet"), version="2.0") #2.0 did not fix it, now trying
      # 
      #   optObj_best <- optObj$scoreSummary %>% janitor::clean_names() %>% arrange(score %>% desc()) %>% head(1)
      # } else {
      #   optObj_best <- data.frame(features_to_keep=length(variable_shape_order), nrounds=100)
      # }
      
      #Final fit, to all of the data, with our final subset of features, and final paramaters
      optObj_best <- optObj %>% janitor::clean_names() %>% arrange(score %>% desc()) %>% head(1)
      vars_final=variable_shape_order[1:optObj_best$features_to_keep]
      dtrain_pruned_subset=lgb.Dataset( x_train[,vars_final]  %>% Rfast::data.frame.to_matrix(col.names=T) , #it's throwing an error about string size, i'm going to withhold feature names just incase that's the reason
                                        label=yid_train[,'y_share18plus']  %>% Rfast::data.frame.to_matrix(col.names=T), feature_pre_filter=T, max_bin=255) #I can up it to 255 now
      
      print("Final Fit")
      lightgbm_pruned_optimized <- lgb.train(
        params = list(
          boosting="gbdt", #dart
          objective = "regression", 
          metric = "rmse",
          learning_rate=0.1, #learning_rate,#, #default 0.1
          num_leaves= 2, #optObj_best$num_leaves %>% round(),
          #" with `feature_pre_filter=true` may cause unexpected behaviour for features that were pre-filtered by the larger "
          #min_data_in_leaf=min_data_in_leaf %>% round(), #we set this in feature_pre filter
          max_depth= -1 #optObj_best$max_depth %>% round() #,
          #bagging_fraction=optObj_best$bagging_fraction,
          #feature_fraction = optObj_best$feature_fraction
        )
        , data = dtrain_pruned_subset
        , nrounds = (optObj_best$nrounds*1) %>% round()
        , verbose=0
        , force_col_wise=T
        , num_threads=32
      )
      
      #Make our final predictions on that test hold out set
      y_hat_test_pruned_optimized <- predict(lightgbm_pruned_optimized, x_test[,vars_final] )
      y_test <- yid_test[,'y_share18plus']$y_share18plus
      summary(abs(y_test-y_hat_test_pruned_optimized)) #0.0524484 bettter than everything
      #      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
      #0.0000119 0.0205543 0.0451527 0.0548780 0.0757547 0.3324835 
      
      yid_test %>% mutate(y_hat_test_pruned_optimized=y_hat_test_pruned_optimized, fold=fold, ablation=ablation) %>% 
        arrow::write_parquet(glue("/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/results_exclude/performance/yid_test_ablation_{ablation}_fold{fold}.parquet"))

      
      
      #And save final shap values for that test hold out set
      #devtools::install_github('ModelOriented/treeshap')
      print("Final Importance")
      library(treeshap)
      unified <- lightgbm.unify(lightgbm_pruned_optimized, x_train[,vars_final] %>% as.data.frame()  )
      #head(unified$model)
      treeshap1 <- treeshap(unified,  x_test[,vars_final] %>% as.data.frame() , verbose =1)
      
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
          mutate(ablation=ablation)
      )
      suppressMessages(
        treeshap_long %>% 
          mutate_if(is.logical, as.numeric) %>%
          mutate_if(is.integer, as.numeric) %>%
          arrow::write_parquet(shap_out_file, version="2.0") #2.0 did not fix it, now trying
      )
      treeshap_long <- NULL;    gc()
      toc()
    }
    
    #After each var, fire off a script to knit the results so you can look at them while it goes
    #command <- "Rscript -e 'library(rmarkdown); rmarkdown::render(\"/mnt/8tb_a/rwd_github_private/TrumpSupportVaccinationRates/docs/Douglass_et_al_2021_WhatExplainsVaccinationRates_SummarizeResults.Rmd\", \"html_document\")'"
    #system(command, wait = F, ignore.stdout = T, show.output.on.console =F)

    
  }
  

  stopCluster(cl)
  registerDoSEQ()



