clear all

*--------------------------*
* Directory for Everything *
*--------------------------*
	global BIHS_11 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_11"
	global BIHS_15 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_15"
	global BIHS_19m "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Male"
	global aggregation "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 8 - Aggregation"
	global ModuleA "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\module a data"

******************************* WAVE 1 *************************************
	* Shocks - WAVE 1
	use "$BIHS_11\038_mod_t1_male.dta", replace  // ct: 4897
		* Merge in village
		merge m:1 a01 using "$ModuleA\r1_male_mod_a_007_n.dta"
			gen WAVE = 2011		
			keep a01-t1_10 div Village WAVE
		* Generals
			sort a01
			quietly by a01 : gen dup = cond(_N==1, 0, _n)			
			* Classify
				gen shock_type_HH = 1
					replace shock_type_HH = 0 if t1_02 == 9
					replace shock_type_HH = 0 if t1_02 == 10
					replace shock_type_HH = 0 if t1_02 == 11
					replace shock_type_HH = 0 if t1_02 == 14
					replace shock_type_HH = 0 if t1_02 == 31
					replace shock_type_HH = 0 if t1_02 == 32
					replace shock_type_HH = 0 if t1_02 == 33
						replace shock_type_HH = 0 if t1_02 == 15 // new additions
						replace shock_type_HH = 0 if t1_02 == 16
						replace shock_type_HH = 0 if t1_02 == 17
						replace shock_type_HH = 0 if t1_02 == 6
				gen shock_type_comm = (shock_type_HH != 1)
			* COUNT HH Shocks
				bysort a01: egen HH_shock_count = total(shock_type_HH)
				bysort a01: egen comm_shock_count = total(shock_type_comm)
				gen shock_count_both = HH_shock_count + comm_shock_count
			* OCCURENCES HH Shocks
				gen occurences_shock_HH = t1_03*shock_type_HH
					replace occurences_shock_HH = 10 /// right-censor if >10
						if occurences_shock_HH > 10
				gen occurences_shock_comm = t1_03*shock_type_comm
					replace occurences_shock_comm = 10 /// right-censor if >10
						if occurences_shock_comm > 10
				* Total occurences within shock type
					bysort a01: egen total_occurences_shock_HH ///
						= total(occurences_shock_HH)
					bysort a01: egen total_occurences_shock_comm ///
						= total(occurences_shock_comm)
			* COSTS HH Shocks
				gen costs_shock_HH = t1_07*shock_type_HH
					replace costs_shock_HH = 0 if t1_07 == .
				gen costs_shock_comm = t1_07*shock_type_comm
					replace costs_shock_comm = 0 if t1_07 == . 
				bysort a01: egen total_costs_HH ///
					= total(costs_shock_HH)
				bysort a01: egen total_costs_comm ///
					= total(costs_shock_comm)	
			* ONGOING
				gen ongoing = (t1_09 == 999)
				bysort a01: egen total_shock_ongoing = total(ongoing)
				drop ongoing
		* KEEP and DROP DUPLICATES
			keep a01 shock_count_both HH_shock_count comm_shock_count ///
				total_occurences_* total_costs_HH total_costs_comm ///
				total_shock_ongoing
			duplicates drop				
		* SAVE
			save "$BIHS_11\038_mod_t1_male_ADDENDUM.dta", replace
		
				
******************************* WAVE 2 *************************************
	* Shocks - WAVE 2
	use "$BIHS_15\050_r2_mod_t1_male.dta", replace
		* Generals
			sort a01
			quietly by a01 : gen dup = cond(_N==1, 0, _n)	
		* Drop if no negative shocks
			drop if t1_02 == 99
	** Types of shocks
			* Total shocks
				bysort a01: egen shock_count_both = count(a01)
			* Classify
				gen shock_type_HH = 1
					replace shock_type_HH = 0 if t1_02 == 9
					replace shock_type_HH = 0 if t1_02 == 10
					replace shock_type_HH = 0 if t1_02 == 11
					replace shock_type_HH = 0 if t1_02 == 14
					replace shock_type_HH = 0 if t1_02 == 31
					replace shock_type_HH = 0 if t1_02 == 32
					replace shock_type_HH = 0 if t1_02 == 33
					replace shock_type_HH = 0 if t1_02 == 101
					replace shock_type_HH = 0 if t1_02 == 111
					replace shock_type_HH = 0 if t1_02 == 151
						replace shock_type_HH = 0 if t1_02 == 15
						replace shock_type_HH = 0 if t1_02 == 16				
						replace shock_type_HH = 0 if t1_02 == 17
						replace shock_type_HH = 0 if t1_02 == 6				
				gen shock_type_comm = (shock_type_HH != 1)
			* COUNT HH Shocks
				bysort a01: egen HH_shock_count = total(shock_type_HH)
				bysort a01: egen comm_shock_count = total(shock_type_comm)
			* OCCURENCES HH Shocks
				gen occurences_shock_HH = t1_03*shock_type_HH
					replace occurences_shock_HH = 10 /// right-censor if >10
						if occurences_shock_HH > 10
				gen occurences_shock_comm = t1_03*shock_type_comm
					replace occurences_shock_comm = 10 /// right-censor if >10
						if occurences_shock_comm > 10
				* Total occurences within shock type
					bysort a01: egen total_occurences_shock_HH ///
						= total(occurences_shock_HH)
					bysort a01: egen total_occurences_shock_comm ///
						= total(occurences_shock_comm)
			* COSTS HH Shocks
				gen costs_shock_HH = t1_07*shock_type_HH
					replace costs_shock_HH = 0 if t1_07 == .
				gen costs_shock_comm = t1_07*shock_type_comm
					replace costs_shock_comm = 0 if t1_07 == . 
				bysort a01: egen total_costs_HH ///
					= total(costs_shock_HH)
				bysort a01: egen total_costs_comm ///
					= total(costs_shock_comm)	
			* ONGOING
				gen ongoing = (t1_09 == 999)
				bysort a01: egen total_shock_ongoing = total(ongoing)
				drop ongoing		
	** KEEP 
		keep a01 shock_count_both HH_shock_count comm_shock_count ///
			total_occurences_shock_HH total_occurences_shock_comm ///
			total_costs_HH total_costs_comm total_shock_ongoing
	** SAVE
		save "$BIHS_15\050_r2_mod_t1_male_ADDENDUM.dta", replace

	
******************************* WAVE 3 *************************************	
	*Shocks - WAVE 3
    use "$BIHS_19m\067_bihs_r3_male_mod_t1b.dta", replace	
		* Generals
			sort a01
			quietly by a01 : gen dup = cond(_N==1, 0, _n)		
			ren (t1b_01 t1b_02 t1b_03 t1b_04 t1b_05 t1b_06a t1b_06b t1b_06c) ///
				(t1_01 t1_02 t1_03 t1_04 t1_05 t1_06a t1_06b t1_06c)
		* Remove if no negative shocks
			drop if t1_01 == 999
	** Types of shocks
			* Total shocks
				bysort a01: egen shock_count_both = count(a01)				
			* Classify
				gen shock_type_HH = 1
					replace shock_type_HH = 0 if t1_01 == 9
					replace shock_type_HH = 0 if t1_01 == 11
					replace shock_type_HH = 0 if t1_01 == 14
					replace shock_type_HH = 0 if t1_01 == 31
					replace shock_type_HH = 0 if t1_01 == 41
					replace shock_type_HH = 0 if t1_01 == 42
					replace shock_type_HH = 0 if t1_01 == 43
					replace shock_type_HH = 0 if t1_01 == 44				
					replace shock_type_HH = 0 if t1_01 == 45
					replace shock_type_HH = 0 if t1_01 == 49					
					replace shock_type_HH = 0 if t1_01 == 50
					replace shock_type_HH = 0 if t1_01 == 51
					replace shock_type_HH = 0 if t1_01 == 101
					replace shock_type_HH = 0 if t1_01 == 102
					replace shock_type_HH = 0 if t1_01 == 103
					replace shock_type_HH = 0 if t1_01 == 104	
					replace shock_type_HH = 0 if t1_01 == 521
						replace shock_type_HH = 0 if t1_01 == 12
						replace shock_type_HH = 0 if t1_01 == 152
						replace shock_type_HH = 0 if t1_01 == 16
						replace shock_type_HH = 0 if t1_01 == 6
						
				gen shock_type_comm = (shock_type_HH != 1)
			* COUNT HH Shocks
				bysort a01: egen HH_shock_count = total(shock_type_HH)
				bysort a01: egen comm_shock_count = total(shock_type_comm)
			* OCCURENCES - data missing
			* COSTS - data missing			
		* Total number of shocks experienced since midline
			bysort a01: egen shock_count_ML = total(t1_01)		
			* Clean-up
				drop if dup > 1				
				keep a01 shock_count_both ///
					HH_shock_count comm_shock_count shock_count_ML
		* Save
			save "$BIHS_19m\067_bihs_r3_male_mod_t1b_ADDENDUM.dta", replace		


******************************* COMBO  *************************************
* COMBINE DATASETS	
	use "$BIHS_11\038_mod_t1_male_ADDENDUM.dta", replace
		gen WAVE = 2011
		append using "$BIHS_15\050_r2_mod_t1_male_ADDENDUM.dta"
			replace WAVE = 2015 if WAVE == .
		append using "$BIHS_19m\067_bihs_r3_male_mod_t1b_ADDENDUM.dta"
			replace WAVE = 2019 if WAVE == .
		duplicates drop 
	* Save
		save "$aggregation\Shocks_by_type.dta", replace
		
	
	
	