*clear all
*use "/The path of the .dta file is located/Syphilis_working_data.dta",clear

drop if year <= 2015
*For the analysis of the COVID-19 period, execute the following code to exclude data from years prior to 2019:
*drop if year <= 2019


*--------------------------------------------------------------------------------------------------------
*"rate":Incidence rate of syphilis per 100,000 people
*"lm_lag1":Lag of 1 period in search scores for matching applications.
*"bankrupt_lag1":Lag of 1 period in bankrupt.
*"inner_lag1":Lag of 1 period in internal migration within the prefecture.
*"move_lag1":Lag of 1 period in migration inflow into the prefecture.
*"out_lag1":Lag of 1 period in foreign visitor inflow into the prefecture through international border gates.
*"japan_lag1":Lag of 1 period in japanese inflow into the prefecture through international border gates.
*"ymsq":square of year-month
*"pref":prefecture code
*"lw_lag1":Lag of 1 period in search scores for weather.
*--------------------------------------------------------------------------------------------------------

*Analysis of Confirmed Surveillance Data
reghdfe rate lm_lag1 bankrupt_lag1 inner_lag1 move_lag1  out_lag1 japan_lag1 ymsq ,absorb(year#pref month#pref) cluster(pref)

ivreghdfe rate bankrupt_lag1  inner_lag1  move_lag1  out_lag1 japan_lag1 ymsq   (  lm_lag1 =  lw_lag1  ),absorb(year#pref month#pref) cluster(pref) first endog(lm_lag1)



*Analysis of Sentinel Surveillance Data
reghdfe rate_sentinel lm_lag1 bankrupt_lag1  inner_lag1  move_lag1  out_lag1 japan_lag1 ymsq ,absorb(year#pref month#pref) cluster(pref)

ivreghdfe rate_sentinel bankrupt_lag1  inner_lag1  move_lag1   out_lag1 japan_lag1 ymsq   (  lm_lag1 =  lw_lag1  ),absorb(year#pref month#pref) cluster(pref) first endog(lm_lag1)




*Heterogeneity Analysis
gen rate_male = (syphilis_male/male_pop_total)*100
gen rate_female = (syphilis_female/female_pop_total)*100

reghdfe rate_male lm_lag1 bankrupt_lag1  inner_lag1  move_lag1  out_lag1 japan_lag1 ymsq ,absorb(year#pref month#pref) cluster(pref)

ivreghdfe rate_male bankrupt_lag1  inner_lag1  move_lag1   out_lag1 japan_lag1 ymsq   (  lm_lag1 =  lw_lag1  ),absorb(year#pref month#pref) cluster(pref) first endog(lm_lag1)


reghdfe rate_female lm_lag1 bankrupt_lag1  inner_lag1  move_lag1  out_lag1 japan_lag1 ymsq ,absorb(year#pref month#pref) cluster(pref)

ivreghdfe rate_female bankrupt_lag1  inner_lag1  move_lag1   out_lag1 japan_lag1 ymsq   (  lm_lag1 =  lw_lag1  ),absorb(year#pref month#pref) cluster(pref) first endog(lm_lag1)
