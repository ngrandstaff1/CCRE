***********************************
** Merging Several Files at Once ** Mini-step 1: Create/clean X, Y, Crwlk15
***********************************
clear all

* Globals *
	global X_data "C:\Users\ngran\Dropbox\JHODD - CCRE\Code"
	global Y_data "C:\Users\ngran\Dropbox\JHODD - CCRE\Code"
	global C_data "C:\Users\ngran\Dropbox\JHODD - CCRE\Code"
	global XYC_temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\XYC_Temp_files"
	global folder "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data"
	* Specifically for C
	global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars\Community Temp Files"
	* By year
	global BIHS_15 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_15"
	global BIHS_11 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_11"
	
*---------------------------------*
* Clean XYC Variables for Merging *  
*---------------------------------*
************
** X Data ** (isid mid a01 WAVE)
************
	use "$X_data\Step 2 - Merging by HH\Big_Append.dta", replace
		isid mid a01 WAVE
		save "$XYC_temp\X_data_temp.dta", replace

************
** Y Data ** (isid a01 WAVE)      [m:1 with X Data]
************
	use "$Y_data\Step 3 - Prep Outcome Vars\Outcome_Vars.dta", replace
		sort a01 WAVE // drop if more than one duplicate
        quietly by a01 WAVE: gen dup = cond(_N==1,0,_n)
			drop if dup > 1
			cap drop _merge
	save "$XYC_temp\Y_data_temp.dta", replace
	
********************
** Crosswalk 2015 ** [XWalk] to add to [XY] onto [C] ONLY IN 2015
******************** 
	* Step 1: Build crosswalk for C15	
		use "$BIHS_15\109_module_identity_other_community.dta", replace
			gen WAVE = 2015
			tostring ca07, gen(div)
			gen dcode = ca06
			gen uzcode0 = (100*dcode)+ca05
				gen zero = "0"
				gen length = (uzcode<1000)
				gen uzcode = uzcode0
				tostring uzcode, replace
				egen uzcode1 = concat(zero uzcode0)
				replace uzcode = uzcode1 if length ==1
				destring uzcode, replace
				drop uzcode1 uzcode0 zero length
			gen Union = union
			tostring Union, replace
			gen vcode_n = ca01
	* Step 2: Eureka; merge key for union assumption and villages
		merge 1:m div dcode uzcode Union Village using "$BIHS_15\001_r2_mod_a_male.dta", force	
	* Step 3: Solve the missing 30 a01 codes
		* have to drop outright bc later/before merges don't work
		drop if a01 ==.
	* Step 4: Save crosswalk
		save "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\Crosswalk_2015.dta", replace
	* Step 5: create a key
		//gen WAVE == 2015
		keep a01 ca01 ca04 ca05 ca06 ca07 vcode_n Village div dcode uzcode Union
		save "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\Crosswalk_2015_key.dta", replace 
		
********************
** Crosswalk 2011 ** from [C] to [XY] ONLY IN 2011
********************		
	* Step 1: Build crosswalk for C11
		use "$BIHS_11\109_module_identity_other_community.dta", replace
		gen WAVE = 2011
	* Step 2: Use intermediate crosswalk 2015 key
		merge 1:m Village ca01 ca04 ca05 ca06 ca07 using "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\Crosswalk_2015_key.dta"
	* Step 3: Eureka
		destring div, replace
		merge m:1 a01 using "$BIHS_11\001_mod_a_male.dta", force gen(merge1)	
	* Save crosswalk
		drop if a01 == .
		gen village = substr(Village, 1, 8)
		save "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\Crosswalk_2011.dta", replace
		
		
********************
** Crosswalk 2019 ** from [C] to [XY] ONLY IN 2011
********************
	* Step 1: Build crosswalk for C19
		use "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Community\140_r3_com_mod_ca_1.dta", replace		
		// contains div (10, ... 60); district (1,...65); upazila (1,...372); 
		// union (1,...428); village (1,...447)
		** need mapping from community to individual HH data (a01)
	* Step 2: Create intermediate for community to HH (a01)
		merge 1:m community_id using "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Male\009_bihs_r3_male_mod_a.dta", force gen(merge5)
	* Step 3: Edit of identifying variables
		gen ca01 = village
		gen ca04 = union
		gen ca05 = upazila
		gen ca06 = district
		gen ca07 = div
	* Step 4: Save a merge file for crosswalk
		drop if a01 == .
		gen WAVE = 2019
		destring ca07, replace
		save "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\Crosswalk_2019.dta", replace		
	
	
**********************
** C Data (2011-19) ** 
**********************
	* C Data 2015 (isid WAVE) can match m:1 on [ca01 ca04 ca05 ca06 ca07]
		use "$C_data\Step 4 - Prep Community Vars\CommVars.dta", replace	
		* drop 2019 and 2011
			//drop if WAVE == 2019
			replace Village = village if Village ==""
			replace village = Village if village ==""
			drop if village =="" & Village ==""
		* Merge with crosswalk 15
			merge 1:m Village WAVE using "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\Crosswalk_2015.dta", force gen(mergeC2015)	
			drop if mergeC2015 == 1
		* testing 
			drop if a01 ==.
			gen village0 = substr(Village, 1, 8)
	* Save relevant file
		save "$XYC_temp\C_data_temp_2015.dta", replace	
	* Save a merge file
		keep a01 ca01 ca04 ca05 ca06 ca07 village village0 vcode
		save "$XYC_temp\C_data_midmerge_2015.dta", replace
		
		
		
*/* *** More Code *** *
** CommVars 2011 ** might not need later
*******************
want: [CommVar2011] to merge with [001_mod_a_male]	
	
Community Vars:
	CommVars incl: ca01 (1-25); Village (10-11dig); village (8dig str), village_name

	C_data_midmerge_2011 incl (2011): ca01 (1-4); village (8dig str); 	

	001_mod_ca_cb_cc_ce_community incl (2011): ca01 (1-4) village (8dig str)
	
	109_module_identity_other_community incl (2011): ca01 (1-35); Village (10-11dig)
	
	
Household Vars:
	001_mod_a_male (2011) incl: a01, vcode_n (1-318)
	
	C_data_midmerge_2015 incl (2015): a01, vcode_n (1-318)
	
	C_data_midmerge_2011 incl (2011): ca01(1-4); village (8dig str)
	
		
Both:
	Crosswalk_2011 incl (2011): a01, ca01 (1-35); village (8dig str); Village (10-11 dig) // at most merge = 1,151 with [CommVars subset 2011]
	
	C_data_temp_2015 incl (2015): ca01 (1-25); village (10-11dig)=Village=vcode; village0 (8dig str) // no matches with [CommVars subset 2011] via village/ca01
		
	[CommVar11] => [001_mod_a_male] doesn't fit any way	
		
		
		
	
use "$C_data\Step 4 - Prep Community Vars\CommVars.dta", replace	
*/
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		