********************
** Community Data ** Combining the CommM# Files
********************
clear all

* Set global for temp files
	global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars\Community Temp Files"
	global folderc "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars"

* Big Append of Community Variables
	use "$temp\CommM1.dta", replace
		append using "$temp\CommM2.dta", force
			replace WAVE = 2015 if WAVE == .
		append using "$temp\CommM3.dta", force
			replace WAVE = 2019 if WAVE == .
			
	* Combine columns - Cleaning first
		*keep community_id div div_name district upazila union mouza ///
			area_type Village slno WAVE ca07 district_name ca06 ///
			upazila_name ca05 union_name ca04 ca03 ca02 village_name ///
			ca01 village smpl_type sl
		* drop if ca02 == . & ca03 ==.
			gen ca04_h = ""
			gen ca05_h = ""			
			gen ca06_h = ""
		* 2011 Crosswalk
			replace ca05_h = "0" if ca05 <100 & ca05 > 9 & WAVE == 2011
			replace ca05_h = "00" if ca05 < 10 & WAVE == 2011
			replace ca06_h = "0" if ca06 < 10 & WAVE == 2011		
		* 2015 Crosswalk
			replace ca05_h = "0" if ca05 <100 & ca05 > 9 & WAVE == 2015
			replace ca05_h = "00" if ca05 < 10 & WAVE == 2015		
			replace ca06_h = "0" if ca06 < 10 & WAVE == 2015
		* 2019 Crosswalk
			destring div, replace
				replace ca07 = div if ca07 == . & WAVE == 2019
				replace ca06 = district if ca06 == . & WAVE == 2019
				replace ca05 = upazila if ca05 == . & WAVE == 2019 
				replace ca04 = union if ca04 == . & WAVE == 2019
				replace ca04_h = "0" if ca04 <100 & ca04 > 9 & WAVE == 2019
				replace ca04_h = "00" if ca04 < 10	& WAVE == 2019
				replace ca05_h = "0" if ca05 <100 & ca05 > 9& WAVE == 2019
				replace ca05_h = "00" if ca05 < 10	& WAVE == 2019
				replace ca06_h = "0" if ca06 < 10& WAVE == 2019		
		* Create a code
			tostring ca04 ca05, replace
				tostring ca06 ca07, replace force
			egen comm_ID = concat(ca04_h ca04 ca05_h ca05 ca06_h ca06)
			destring ca04 ca05 ca06 ca07, replace
			
		* Drop missing ca01 observations in 2015
			drop if ca01 == . & WAVE == 2015
		
		* Replace for ca01, not currently possible since no matching
		// drop if WAVE == 2019
		gen n = 1
		bysort ca01 ca04 ca05 ca06 ca07 WAVE: egen HH_rep = count(n)
		bysort ca01 ca04 ca05 ca06 ca07 WAVE: gen N = _n
		drop if N == 2
		
		* Save the full file
			save "$folderc\CommVars", replace
		


























