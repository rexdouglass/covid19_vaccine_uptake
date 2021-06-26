

library(janitor)
library(tidylog)
library(stringr)

setwd("/home/skynet3/Downloads/vacines/")

#a <- fread("1976-2020-president.csv")

b <- fread("2012pres.csv") %>% clean_names() %>%
     mutate(romney_perc=100*willard_mitt_romney / (barack_h_obama + willard_mitt_romney)) %>%
    dplyr::select(fips,romney_perc)

c <- fread("2020pres.csv") %>% clean_names() %>% 
     mutate(trump_perc=100*donald_j_trump / (joseph_r_biden_jr + donald_j_trump)) %>%
     dplyr::select(fips,trump_perc)

d <- fread("cc-est2019-alldata.csv") %>% clean_names() %>%
     filter(year==12, agegrp==0) %>%
     mutate(black_perc = 100*(bac_male + bac_female)/tot_pop) %>%
     mutate(native_perc = 100*(iac_male + iac_female)/tot_pop) %>%
     mutate(hispanic_perc = 100*(h_male + h_female)/tot_pop) %>%
     mutate(fips=paste0(state,str_pad(county, 3, pad = "0") ) %>% as.numeric()  ) %>%
     dplyr::select(fips,tot_pop,black_perc,native_perc,hispanic_perc, state_name=stname, county_name=ctyname)
  

f <- fread("COVID-19_Vaccinations_in_the_United_States_County.csv")  %>% 
     clean_names() %>%
     filter(date=="06/16/2021") %>%
     mutate(fips=fips %>% as.numeric()) %>%
     dplyr::select(fips,series_complete_18plus_pop_pct)
dim(f)

library(readxl)
g <- read_excel("ruralurbancodes2013.xls") %>% clean_names() %>% dplyr::select(fips,rucc_2013) %>%
  mutate(fips=fips %>% as.numeric()) 
dim(g)

h  <- fread("https://raw.githubusercontent.com/JieYingWu/COVID-19_US_County-level_Summaries/master/data/counties.csv") %>% 
  janitor::clean_names()  %>% 
  dplyr::select(
  fips
  ,percent_of_adults_with_less_than_a_high_school_diploma_2014_18
  ,percent_of_adults_with_a_bachelors_degree_or_higher_2014_18
  ,percent_of_adults_completing_some_college_or_associates_degree_2014_18
  ,percent_of_adults_with_a_high_school_diploma_only_2014_18
  
  ,median_household_income_2018
  ,active_physicians_per_100000_population_2018_aamc
  ,unemployment_rate_2018
  ,total_hospitals_2019
  ,area_in_square_miles_land_area
  ,density_per_square_mile_of_land_area_population                                                                                                                         
  ,total_male
  ,total_female
  ,total_age0to17
  ,total_age18to64
  ,total_age65plus
  ,total_age85plusr
  ,wa_male	
  ,wa_female	
  ,ba_male
  ,ba_female
  ,aa_male
  ,aa_female
  ,h_male	
  ,h_female
) %>%
  mutate(population_total=total_male+total_female) %>% dplyr::select(-total_male,-total_female) %>%
  mutate(white_perc=(wa_male+wa_female)/population_total) %>% dplyr::select(-wa_male,-wa_female) %>%
  mutate(black_perc=(ba_male+ba_female)/population_total) %>% dplyr::select(-ba_male,-ba_female) %>%
  mutate(asian_perc=(aa_male+aa_female)/population_total) %>% dplyr::select(-aa_male,-aa_female) %>%
  mutate(hispanic_perc=(h_male+h_female)/population_total) %>% dplyr::select(-h_male,-h_female) %>%
  
  mutate(total_age0to17_perc=(total_age0to17)/population_total) %>% dplyr::select(-total_age0to17) %>%
  mutate(total_age18to64_perc=(total_age18to64)/population_total) %>% dplyr::select(-total_age18to64) %>%
  mutate(total_age65plus_perc=(total_age65plus)/population_total) %>% dplyr::select(-total_age65plus) %>%
  mutate(total_age85plusr_perc=(total_age85plusr)/population_total) %>% dplyr::select(-total_age85plusr) 



glimpse(b)
glimpse(c)
glimpse(d)
glimpse(g)
glimpse(f)

XYid_all <- f %>% 
            left_join(g) %>%
            left_join(d) %>%
            left_join(c) %>%
            left_join(b) %>% filter(!is.na(fips))
dim(XYid_all) #3282   11
