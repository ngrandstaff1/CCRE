*********************
** Outcome Merging ** on identifier (a01, WAVE)
*********************
clear all

* Global
	global STEP3 "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 3 - Prep Outcome Vars\Step 3 DTAs"
	global folder "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 3 - Prep Outcome Vars"
	
** Merge together X3, O1, and T1_neg
	use "$STEP3\OutcomeVars_X3.dta", replace	
		* Check uniqueness of identifying variables
			sort a01 WAVE
			misstable sum a01 WAVE
		* Assume a01 has rid of == 2, "rid" now non-empty
			replace rid = 2 if a01 == 252 & WAVE == 2015
		* Merge O1 data and check (m:1)
			merge m:1 a01 WAVE using "$STEP3\OutcomeVars_O1.dta"
				tab _merge WAVE
				tab WAVE if _merge == 3
				gen _merge_outcome = 1
					replace _merge_outcome = . if _merge == 1
				cap drop _merge			

		/* Merge T1_neg data and check (m:1) - A-EXAM SHOCKS
			merge m:m a01 WAVE using "$STEP3\OutcomeVars_T1_neg.dta"
				replace _merge_outcome = 2 if _merge == 3
				tab _merge WAVE
				cap drop _merge
		*/
		* drop duplicates

* Saving a file
	save "$folder\Outcome_Vars.dta", replace




(cut for time)



