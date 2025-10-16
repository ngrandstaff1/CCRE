*************************************
** Specifications of shocks        **
** Oct.1, 2025                     **
*************************************
clear all

* Globals	
	global dropbox "C:\Users\ngran\Dropbox"
	global BIHS_11  "$dropbox\JHODD - CCRE\BIHS Data\BIHS_11"
	global BIHS_15  "$dropbox\JHODD - CCRE\BIHS Data\BIHS_15"
	global BIHS_19m "$dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Male"
	global Step9   "$dropbox\JHODD - CCRE\Code\Step 9 - Regressions"
	global ModuleA 	"$dropbox\JHODD - CCRE\BIHS Data\module a data"
	global aggregation "$dropbox\JHODD - CCRE\Code\Step 8 - Aggregation"


** Base data append identifiers on isid(a01 WAVE)
	use "$aggregation\All_Identifiers_and_Waves.dta", replace
			//gen decimal = (abs(a01 - round(a01)) > 0) 
			//drop if decimal == 1
		keep a01 a11 dvcode dcode Village WAVE	
		save "$aggregation\shocks_temp.dta", replace
		clear
** Shocks data
	* 2019 data
		use "$BIHS_19m\067_bihs_r3_male_mod_t1b.dta", replace
			gen WAVE = 2019
			replace t1b_01 = 99 if t1b_01 == 999
			gen t = t1b_01
		* Append 2015	
			append using "$BIHS_15\050_r2_mod_t1_male.dta"	
				replace WAVE = 2015 if WAVE == .
				replace t = t1_02 if t1b_01 == .	
		* Append 2011
			append using "$BIHS_11\038_mod_t1_male.dta"
				replace WAVE = 2011 if WAVE == .
				replace t = t1_02 if t1b_01 == .
		* Formatting
			keep a01 t t1_02 t1b_01 WAVE
		* Collapse to one column the shock definitions
			replace t1b_01 = t if WAVE == 2015 & t1b_01 == .
			replace t1b_01 = t1_02 if WAVE == 2011 & t1b_01 ==.			
		* Encode the missing vars from wave 3 (t1b_01)
			label define t1b_01 10 "Major loss of crops due to other reasons (drought, storms, p", add
			label define t1b_01 15 "Loss of productive assets due to other reasons (theft, fire, )", add
			label define t1b_01 17 "Loss of consumption assets (personal) due to factors other t", add
			label define t1b_01 32 "Increase in food prices", add
			label define t1b_01 33 "Increase in prices of inputs", add
			label define t1b_01 0 "No shocks", add			
		* Formatting by filling in the t1b_01
			replace t1b_01 = 0 if t1b_01 == 99
			replace t1b_01 = 0 if t1_02 ==.	& WAVE != 2019	
			drop t t1_02
			ren t1b_01 t1_02			
		* Merge on the identifiers
			merge m:1 a01 WAVE using "$aggregation\shocks_temp.dta"				
				replace t1_02 = 0 if t1_02 == .			
		* Remove decimal households	
			gen decimal = (abs(a01 - round(a01)) > 0 )
			drop if decimal == 1				

	**# Inserted code to remove splits of HHH from tracked households
		** Note that Tracking Household Head is better than tracking respondent
			* Data for HHH:        (6503; 5520; 4076)
			* Data for respondent: (6503; 5212; 3984) or ~2.5% less overall
			sort a01 WAVE
		* HHH identifier
			gen wave_min = (WAVE == 2011)*a11
		* Apply to all waves and HH splits
			gen round_a01 = trunc(a01)
			gen hhh_2011 = (WAVE == 2011)*a11
			bysort round_a01: egen max_hhh_2011 = max(hhh_2011)
			gen same_hhh = (max_hhh == a11)
				drop if a11 != max_hhh	
	**# END of inserted code
		
****************************** RESUME *****************************************
	** Filling in aggregates before collapsing wide to (isid a01)
		* Bysort count shocks by "a01"
			gen n = (t1_02 != 0)
			bysort a01 WAVE: egen shocks_by_indiv = total(n)
			replace shocks_by_indiv = 0 if shocks_by_indiv == 1 & t1_02 == 0			
		* Shock 44 is shock 39 correction
			replace t1_02 = 41 if t1_02 == 44
		* Wide for individuals
			tab t1_02, gen(shock)
			forvalues i = 1/54 {
				bysort a01 WAVE: egen shock_ct`i' = total(shock`i')
			}			
			* Count by geography
				cap drop n
				gen n = 1
				bysort dvcode WAVE: egen count_div = count(n)   // many villages
				bysort dcode WAVE: egen count_dis = count(n)    // 2-6 villages
				bysort Village WAVE: egen count_vil = count(n) 				
			* Intermediate cleaninging
				drop _merge decimal
	** Renaming variables for wide data (making it "k")
		* Code labels
		label variable shock_ct1 "No shocks, null for shock = 0"
		label variable shock_ct2 "Death of a main earner"
		label variable shock_ct3 "Household death of non-main-earner"
		label variable shock_ct4 "Due to illness or injury of HH member"
		label variable shock_ct5 "Medical expenses due to illness or injury"
		label variable shock_ct6 "HH member lost a regular job"
		label variable shock_ct7 "Lose home due to river erosion"
		label variable shock_ct8 "Lose home due to any reason but river erosion"
		label variable shock_ct9 "HH member divorced or seperated"
		label variable shock_ct10 "HH loses crops due to floods"
		label variable shock_ct11 "Loss of crops to other reasons"
		label variable shock_ct12 "HH loses livestock due to floods"
		label variable shock_ct13 "HH loses livestock due to death of livestock"
		label variable shock_ct14 "HH loses livestock due to theft"
		label variable shock_ct15 "HH lose productive assets due to floods"
		label variable shock_ct16 "HH lose productive assets (personal) due to factors other than flood"
		label variable shock_ct17 "HH lose consumption assets due to floods"
		label variable shock_ct18 "HH lose consumption assets (personal) due to factors other than floods"
		label variable shock_ct19 "HH paid dowry"
		label variable shock_ct20 "HH paid other wedding costs"
		label variable shock_ct21 "HH faces division of fathers property"
		label variable shock_ct22 "HH face failure or bankruptcy of business"
		label variable shock_ct23 "HH member extorted by mastans"
		label variable shock_ct24 "HH member imprisoned by the police"
		label variable shock_ct25 "HH member arrested by the police"
		label variable shock_ct26 "HH member paid a big bribe"
		label variable shock_ct27 "HH paid court costs for a HH member"
		label variable shock_ct28 "Experience any loss due to a court case"
		label variable shock_ct29 "Reparations to victim of crime committed by HH member"
		label variable shock_ct30 "Costs from long hartals/strikes/political unrest"
		label variable shock_ct31 "Cut-off or decrease of regular remittances to HH"
		label variable shock_ct32 "Withdrawal of NGO assistance"
		label variable shock_ct33 "Increase in food prices"
		label variable shock_ct34 "Increase in prices of inputs"
		label variable shock_ct35 "Other-1"
		label variable shock_ct36 "Other-2"
		label variable shock_ct37 "HH difficult times, too much rain"
		label variable shock_ct38 "HH difficult times, too little rain"
		label variable shock_ct39 "HH difficult times, land erosion"
		label variable shock_ct40 "HH difficult times, food price inflation"
		label variable shock_ct41 "Someone stealing or destroying HH belongings"
		label variable shock_ct42 "Difficult times, theft of HHs crops"
		label variable shock_ct43 "Not able to access inputs for livestock"
		label variable shock_ct44 "Disease affeting livestock"
		label variable shock_ct45 "In ability to sell crop, livestock, or other HH products at fair prices"
		label variable shock_ct46 "Experience/experiencing severe illness"
		label variable shock_ct47 "Lose crops to cyclone"
		label variable shock_ct48 "Difficult times, crop disease"
		label variable shock_ct49 "Difficult times, pest affecting crops"
		label variable shock_ct50 "Difficult times, non-cyclone or for other reasons"
		label variable shock_ct51 "Lose livestock due to cyclone"
		label variable shock_ct52 "HH lose productive assets due to destruction in fire"
		label variable shock_ct53 "Lose productive assets due to other reasons"
		label variable shock_ct54 "Experience cut-off of benefits from SSN program"							
	* Change data from long to wide on shocks (isid a01)
		drop n t1_02 shock1-shock54 a11 wave_min round_a01 hhh_2011 ///
			max_hhh_2011 same_hhh
		duplicates drop			
	* Fix identifier issues before saving
		replace dvcode	= 60			if a01 == 5100 & WAVE == 2019
		replace dcode 	= 91 			if a01 == 5100 & WAVE == 2019
		replace Village = "91084038001" if a01 == 5100 & WAVE == 2019
**# Bookmark #1
	* Aggregating individual shocks
		* total shock count, by wave
			* Overal (only)
		
		* total shock t-stat, by wave
			* Relative to overall
			
			* Relative to district
			
			* Relative to village
		
		
		

	** Shocks save
		save "$Step9\Shocks_by_Year\Shocks_ALL.dta", replace





