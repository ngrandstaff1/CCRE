** All identifiers and outcomes **
clear all

****************************** PRIORS *****************************************
* Globals
	global sum_stats "C:\Users\ngran\Dropbox\JHODD - CCRE\Summary Stats"
	global aggregation "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 8 - Aggregation"
	global regressors "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 7 - Identifying Data"
	global outcomes "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 3 - Prep Outcome Vars"
	global folder9 "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 9 - Regressions"

****************************** WORK   *****************************************
* Base data
	use "$aggregation\All_Identifiers_and_Waves.dta", replace
	
** IDENTIFIERS MERGE **	
	* Individ: Merge - No Splits binary
		merge 1:1 a01 WAVE using "$sum_stats\No_Splits_BIHS.dta"
			gen No_Splits = (_merge == 3)
			cap drop _merge
	* Individ: Merge - Stable and Stationary binary
		merge 1:1 a01 WAVE using "$sum_stats\stable_stationary_DATA.dta"
			gen Stable_Stat = (_merge == 3)
			cap drop all3 _merge
	* Village: Merge - ALL DATA AVAILABLE
		merge m:1 Village WAVE using "$aggregation\Identifiers_Villages.dta"
			cap drop _merge
	
** REGRESSOR MERGE **
	* Individ: Regressor Set
		merge 1:1 a01 WAVE using "$regressors\Step7a_data.dta", force
		tab WAVE _merge
		cap drop _merge

** SHOCKS MERGE **		
	* Aggregated Shocks
		merge 1:1 a01 WAVE using "$aggregation\Shocks_by_type.dta"
			tab _merge WAVE
			gen having_shock = (_merge ==3)
			drop _merge
	
** OUTCOME MERGE **
	* Add HDD, FCS, FIES questions
		merge 1:1 a01 WAVE using "$outcomes\Outcome_Vars.dta"
			gen has_outcomes = (_merge == 3)
			cap drop _merge
		merge 1:1 a01 WAVE using "$folder9\Step9_AddnOutcomes.dta"
			gen has_addn_outcomes = (_merge == 3)
			cap drop _merge
	

** FULL DATA
	save "$folder9\FullData.dta", replace