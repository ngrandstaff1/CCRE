*------------------------------------------------------*
** Combining the identifier files from Wahid at IFPRI **
*------------------------------------------------------*
clear all

* Priors
	global CCRE "C:\Users\ngran\Dropbox\JHODD - CCRE"
	global ModA "$CCRE\BIHS Data\module a data"
	global folder "$ModA\Clean_Identifiers"
	global aggregation "$CCRE\Code\Step 8 - Aggregation"
	
** Prepare Wave-specific identifiers **	
	* WAVE 1: 2011-2012
		use "$ModA\r1_male_mod_a_007_n.dta", replace
			gen WAVE = 2011
		* Save Wave 1
			save "$folder\W1_identifiers.dta", replace
	* WAVE 2: 2015
		use "$ModA/001_r2_mod_a_male_n.dta", replace
			gen WAVE = 2015
		* Keep if survey completed
			keep if flag_a == 1
		* Save Wave 2
			save "$folder\W2_identifiers.dta", replace
	* WAVE 3: 2018-2019
		use "$ModA\r3_male_mod_a_001_n.dta", replace
			drop if hh_type == 7 // drop GFSS since onltab y 2018
			// drop if hh_type == 1 // drop FTF "only" HHs
			gen WAVE = 2019
			drop gfss_* a16* a02
		* Keep if survey completed
			keep if a27 == 1
		* Save Wave 3
			save "$aggregation\W3_identifiers.dta", replace		
			
** Append the data files
	* Open WAVE 1
		use "$folder\W1_identifiers.dta", replace // n = 6503
	* Append WAVE 2
		append using "$folder\W2_identifiers.dta" // n = 6436
	* Append WAVE 3
		append using "$folder\W3_identifiers.dta" // n = 6617 (1049 split)
		
** Save as full dataset (n = 19,556; all waves)
	* Minor edits
		drop sample_type
***** Save *********************************************************************
	save "$aggregation\All_Identifiers_and_Waves.dta", replace
	
*-----------------------------*
** Create a no split dataset ** CREATE A DATASET NO SPLITS
*-----------------------------*	
	use "$aggregation\All_Identifiers_and_Waves.dta", replace
		* Identify splits
			gen split = (abs(a01 - round(a01)) > 0)
			gen num_split = (abs(a01-round(a01)))*(split == 1)			
		* Split stats
			tab num_split WAVE
			tab split WAVE
			table split div
		* Drop HH splits
			drop if num_split != 0
** Save as full dataset (n = 19,229; all waves)
	* Minor edits
		drop num_split split
***** Save // n = **************************************************************
		save "$aggregation\No_Splits_BIHS.dta", replace
		tab hh_type WAVE
	
*-------------------------*
** Create a wide dataset ** CREATE A DATASET OF STABLE HHs {2,3}
*-------------------------*
	** STEPS
		* 1. Create list of which HHs are stable 2
		* 2. Create list of which HHs are stable 3
		* 3. Merge full "No_Splits_BIHS.dta" with lists
		* 4. Create two (?) datasets
	* Use dataset
		use "$aggregation\No_Splits_BIHS.dta", replace	
			* Filter
				keep a01 a10 a11 Village mouza WAVE x1
	* Reshape with (isid a01)
		reshape wide Village mouza x1 a10 a11, i(a01) j(WAVE)		
			drop x12011 x12015
			ren x12019 x1
	* Stable HH Head
		gen round = round(a01)
		* Periods 1 & 2
			gen a10_temp = a102011 // a10: primary respondent
				replace a10_temp = 0 if a102011 == .
			gen a11_temp = a112011 // a11: HH father's name (if HHH=F, still)
				replace a11_temp = 0 if a112011 == .
			bysort round: egen a10_max_2011 = max(a102011)
			bysort round: egen a11_max_2011 = max(a112011)
			drop a10_temp a11_temp
	* WAVE-specific binaries
		gen W1_data = 0
			replace W1_data = 1 if a01==round
		gen W2_data = 0
			replace W2_data = 1 if mouzacode2015 != ""
		gen W3_data = 0
			replace W3_data = 1 if mouzacode2019 != ""
	* Conditions
		gen all3 = W1_data==1 & W2_data==1 & W3_data==1
		tab x1 all3 // 5,165 same location, no splits, 3 waves of data
					// 70 obs with 3> waves data AND not moved
					// 306 obs with 3 waves data and move
					// 18 obs with 3> waves data AND moved (worst outcome)		
	* Keep Conditions
		keep if x1 ==  1
		keep if all3 == 1
		* Check
			misstable sum // should be empty
	* Create stable & stationary list
		keep a01 all3  // n = 5,165
	* Save
		save "$aggregation\LIST_stable_stationary.dta", replace
	* Re-open full identifiers data
		use "$aggregation\No_Splits_BIHS.dta", replace
		* Merge back in
			merge m:1 a01 using "$aggregation\LIST_stable_stationary.dta"
	* Create stable & stationary data
		keep if _merge == 3  // n = 5,165
		drop _merge flag_a consent_a x1
***** Save**********************************************************************
		save "$aggregation\stable_stationary_DATA.dta", replace
		
		
		(cut)			