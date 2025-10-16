*******************
** BIHS Append 2 ** Part of Step 2
*******************
clear all

* Globals
global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 2 - Merging by HH\Temp Files"
global folder "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 2 - Merging by HH"

* The job
	use "$temp\Big_Merge_11.dta", replace
		gen WAVE = 2011
		append using "$temp\Big_Merge_15.dta", force
		append using "$temp\Big_Merge_19.dta", force
	tab WAVE

* Key choice for unique identifiers
	drop if mid ==. 
	isid mid WAVE a01
	
* Save files
	save "$folder\Big_Append.dta", replace














