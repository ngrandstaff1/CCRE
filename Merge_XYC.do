***********************************
** Merging Several Files at Once **
***********************************
clear all

* Globals *	
	global XYC_temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\XYC_Temp_files"
	global folder "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data"	
	

*---------------------------------*
* Merge XYC Variables             *  
*---------------------------------*
	* SET X
		use "$XYC_temp\X_data_temp.dta", replace
	* check skip 
		drop if mid != a10	
	* SET Y
			merge m:1 a01 WAVE using "$XYC_temp\Y_data_temp.dta", gen(merge1)
	* Crosswalk
		tostring div, replace
		gen dcode0 = dcode
			drop dcode
			ren dcode0 dcode
		gen uzcode0 = uzcode
			drop uzcode
			ren uzcode0 uzcode 	
		merge m:1 a01 Village WAVE using "$folder\Crosswalk_2015.dta", gen(merge2B)		
		
** OBTAINING DATA FROM 
	* SET C - only 2015
		tostring ca07, gen(div0)
			tostring div, replace
			replace div = div0 if WAVE != 2019		
		gen dcode0 = ca06 
			replace dcode = dcode0 if WAVE == 2015
		replace uzcode = . if WAVE == 2015
		gen uzcode0 = (100*dcode)+ca05
			gen zero = "0"	
			gen length = (uzcode<1000)		
			tostring uzcode, replace
			egen uzcode1 = concat(zero uzcode0)
			replace uzcode = uzcode1 if length ==1
			destring uzcode, replace
			drop uzcode1 uzcode0 zero length
			destring Union, replace			
	** Merge ** 
		drop if mid != resp
		keep if mid == a10
		merge m:1 a01 WAVE using "$XYC_temp\C_data_temp.dta", force gen(merge3)
		drop if mid != resp
		keep if mid == a10	
	
	** Save MergeXYC **
		save "$folder\Merge_XYC.dta", replace
		

	
		(cut)