cd "___PATH NAME FOR DATA FILES HERE___"
set scheme tpepbw


*****************************************
*  urban/rural continuum codes by county
*****************************************

import excel "ruralurbancodes2013.xls", firstrow clear

labmask RUCC_2013, values(Description)    // --ssc install labutil-- if you don't have labmask
rename RUCC_2013 ruralcode
destring FIPS, generate(fips)
keep fips ruralcode
save urbanrural.dta, replace

*****************************************
* state and county level demographics
*****************************************

import delimited "cc-est2019-alldata.csv", clear

keep if year==12 & agegrp==0

* state data
preserve
collapse (sum) tot_pop bac_male bac_female iac_male iac_female h_male h_female, by(stname)
gen black_state = 100*(bac_male + bac_female)/tot_pop
gen native_state = 100*(iac_male + iac_female)/tot_pop
gen hispanic_state = 100*(h_male + h_female)/tot_pop
drop bac_male bac_female iac_male iac_female h_male h_female
rename tot_pop pop_state
gen logpop_state = ln(pop_state)
rename stnam state_name
save state_race.dta, replace
restore

* county data
gen black_county = 100*(bac_male + bac_female)/tot_pop
gen native_county = 100*(iac_male + iac_female)/tot_pop
gen hispanic_county = 100*(h_male + h_female)/tot_pop
gen fips = state*1000+county

keep fips stname ctyname black_county native_county hispanic_county tot_pop
order fips
rename tot_pop pop_county
gen logpop_county = ln(pop_county)
rename ctyname county_name
rename stname state_name

* merge in urban/rural data 
merge 1:1 fips using urbanrural.dta
drop if _merge !=3
drop _merge
save county_race.dta, replace


*****************************************
* presidential vote data
*****************************************

import delimited "1976-2020-president.csv", clear

preserve
keep if year==2012

keep if candidate=="OBAMA, BARACK H." | candidate=="ROMNEY, MITT" | candidate=="MITT, ROMNEY"
by state, sort: egen votetotal = sum(candidatevotes)
by state candidate, sort: egen candtotal = sum(candidatevotes)
drop if candidate=="OBAMA, BARACK H."
drop if party_detailed!="REPUBLICAN"
gen romney_state = candidatevotes/votetotal

keep state state_po romney_state
rename state state_name
rename state_po state
replace state_name = proper(state_name)
replace state_name = "District of Columbia" if state_name=="District Of Columbia"
save state_vote2012.dta, replace
restore

keep if year==2020

keep if candidate=="BIDEN, JOSEPH R. JR" | candidate=="TRUMP, DONALD J."
by state, sort: egen votetotal = sum(candidatevotes)
by state candidate, sort: egen candtotal = sum(candidatevotes)
drop if candidate=="BIDEN, JOSEPH R. JR"
gen trump_state = candidatevotes/votetotal

keep state state_po trump_state
rename state state_name
rename state_po state
replace state_name = proper(state_name)
replace state_name = "District of Columbia" if state_name=="District Of Columbia"

merge 1:1 state_name using state_vote2012.dta, nogenerate
merge 1:1 state_name using state_race.dta, nogenerate

gen trumpswing_state = trump_state - romney_state
save state_vote.dta, replace

import delimited "2012pres.csv", clear
gen romney_county = 100*willardmittromney / (barackhobama + willardmittromney)
keep fips romney_county

merge 1:1 fips using county_race.dta
keep if _merge==3
drop _merge
save vote_county2012.dta, replace

import delimited "2020pres.csv", clear
gen trump_county = 100*donaldjtrump / (josephrbidenjr + donaldjtrump)
keep fips trump_county
merge 1:1 fips using vote_county2012.dta
keep if _merge==3
drop _merge

merge m:1 state_name using state_vote.dta, nogenerate
drop if fips==.

gen trumpswing_county = trump_county - romney_county

save vote.dta, replace


*****************************************
* vaccination data
*****************************************

import delimited "COVID-19_Vaccinations_in_the_United_States_County.csv", clear 

destring fips, replace force

keep if date == "06/16/2021"
drop if fips==.
rename series_complete_18pluspop_pct vaccinated_18plus
drop if recip_state=="VI" | recip_state=="GU" | recip_state=="DC" | recip_state=="PR" | recip_state=="HI" | recip_state=="TX" | recip_state=="AK"
drop if vaccinated_18plus == 0 | vaccinated_18plus > 99 // these are almost certainly errors

merge 1:1 fips using vote.dta
drop if _merge!=3
drop _merge
drop date mmwr_week recip_county recip_state series_complete_pop_pct series_complete_yes series_complete_12plus ///
	series_complete_12pluspop_pct series_complete_18plus series_complete_65plus series_complete_65pluspop_pct completeness_pct
drop if vaccinated_18plus==.



*****************************************
* clean up old files
*****************************************

rm state_vote.dta 
rm vote.dta
rm state_race.dta
rm county_race.dta
rm vote_county2012.dta
rm urbanrural.dta
rm state_vote2012.dta


*****************************************
* various fixed effects
*****************************************

gen stateid = 0
by state, sort: replace stateid = 1 if _n == 1

gen division = ""
replace division = "New England" if state_name=="Connecticut" | ///
	state_name=="Maine" | ///
	state_name=="Massachusetts" | ///
	state_name=="New Hampshire" | ///
	state_name=="Connecticut" | ///
	state_name=="Rhode Island" | ///
	state_name=="Vermont"
replace division = "Middle Atlantic" if state_name=="New Jersey" | ///
	state_name=="New York" | ///
	state_name=="Pennsylvania"
replace division = "East North Central" if state_name=="Illinois" | ///
	state_name=="Indiana" | ///
	state_name=="Michigan" | ///
	state_name=="Ohio" | ///
	state_name=="Wisconsin"
replace division = "East North Central" if state_name=="Illinois" | ///
	state_name=="Indiana" | ///
	state_name=="Michigan" | ///
	state_name=="Ohio" | ///
	state_name=="Wisconsin"
replace division = "West North Central" if state_name=="Iowa" | ///
	state_name=="Kansas" | ///
	state_name=="Minnesota" | ///
	state_name=="Nebraska" | ///
	state_name=="North Dakota" | ///
	state_name=="South Dakota"
replace division = "South Atlantic" if state_name=="Delaware" | ///
	state_name=="District of Columbia" | ///
	state_name=="Florida" | ///
	state_name=="Georgia" | ///
	state_name=="Maryland" | ///
	state_name=="North Carolina" | ///
	state_name=="South Carolina" | ///
	state_name=="Virginia" | ///
	state_name=="West Virginia"
replace division = "East South Central" if state_name=="Alabama" | ///
	state_name=="Kentucky" | ///
	state_name=="Mississippi" | ///
	state_name=="Tennessee"
replace division = "West South Central" if state_name=="Arkansas" | ///
	state_name=="Louisiana" | ///
	state_name=="Oklahoma" | ///
	state_name=="Texas"
replace division = "Mountain" if state_name=="Arizona" | ///
	state_name=="Colorado" | ///
	state_name=="Idaho" | ///
	state_name=="Montana" | ///
	state_name=="Nevada" | ///
	state_name=="New Mexico" | ///
	state_name=="Utah" | ///
	state_name=="Wyoming"
replace division = "Pacific" if state_name=="Alaska" | ///
	state_name=="California" | ///
	state_name=="Hawaii" | ///
	state_name=="Oregon" | ///
	state_name=="Washington"
encode division, gen(div)

egen stateurbanrural = group(state_name ruralcode)


***** THE ANALYSIS ****

areg vaccinated_18plus trump_county trumpswing_county black_county native_county hispanic_county logpop_county i.ruralcode, absorb(state_name) cluster(state_name)
areg vaccinated_18plus trump_county trumpswing_county black_county native_county hispanic_county logpop_county , absorb(stateurbanrural) cluster(stateurbanrural)


mixed  vaccinated_18plus c.trump_county##i.div trump_state c.trumpswing_county##i.div trumpswing_state ///
	c.black_county##i.div c.native_county##i.div c.hispanic_county##i.div ///
	black_state native_state hispanic_state ///
	c.logpop_county##i.div logpop_state ///
	i.ruralcode || ///
	state_name: trump_county trumpswing_county black_county native_county hispanic_county logpop_county ruralcode
	
margins , dydx(trump_county) at(div=(1 2 3 4 5 6 7 8 9)) plot(ciopt(lwidth(medium)) horizontal recast(scatter) xline(0, lpattern(dash)) ///
	title("Trump Vote") name(trump, replace) ytitle("") xtitle("Coefficient") yscale(reverse)) 
margins , dydx(trumpswing_county) at(div=(1 2 3 4 5 6 7 8 9)) plot(ciopt(lwidth(medium)) horizontal recast(scatter) xline(0, lpattern(dash)) ///
	title("Trump Swing") name(swing, replace) ytitle("") xtitle("Coefficient") yscale(reverse))
margins , dydx(black_county) at(div=(1 2 3 4 5 6 7 8 9)) plot(ciopt(lwidth(medium)) horizontal recast(scatter) xline(0, lpattern(dash)) ///
	title("Black Population Share") name(black, replace) ytitle("") xtitle("Coefficient") yscale(reverse))
margins , dydx(hispanic_county) at(div=(1 2 3 4 5 6 7 8 9)) plot(ciopt(lwidth(medium)) horizontal recast(scatter) xline(0, lpattern(dash)) ///
	title("Hispanic Population Share") name(hispanic, replace) ytitle("") xtitle("Coefficient") yscale(reverse))

graph combine trump swing black hispanic, title("Partisanship, Race, and Vaccination" "by Census Division")


***** GRAPH CORRELATIONS BY STATE ****

levelsof state_name, local(states)
local graphs
foreach c of local states {
	local for_name = strtoname("`c'")
    twoway (scatter trump_county vaccinated_18plus if ///
         state_name == "`c'" [w=pop_county], title(`c') name(`for_name', replace) ytitle("2020 Trump Vote") xtitle("Percent 18+ Completely Vaccinated")) ///
		 (lfit trump_county vaccinated_18plus if state_name == "`c'" [w=pop_county], lcolor(black) lwidth(thick) yline(50, lpattern(dash)) legend(off) scheme(tpepbw))
		 local graphs `graphs' `for_name'
}
graph combine `graphs', xcommon ycommon name(scatters, replace) title("Completed Vaccinations (18+) and 2020 Trump Vote Share") ///
	note("Graph by @tompepinsky. Vaccine data from 6/15/2021 (CDC). Point sizes are proportional to county pop." /// 
	"NB: County vaccine data not available for HI, TX, and CA counties with less than 20,000 residents." ///	
	"AK vaccine data reported for a different geographical unit than are 2020 votes shares. VA cities are weird.") 



