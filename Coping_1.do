************************************
** Merging COPING Strategies Data **
************************************
clear all


* Globals - needs edit *
	global t1_data "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data"
	
	** RECALL: Have coping index sorting Excel file
	
	
* NOTE HHs reporting ZERO SHOCKS NOT RECORDED HERE
	
** Coping and Shocks: Wave 1 Processing 
	use "$t1_data\BIHS_11\038_mod_t1_male.dta", replace	

	
	* Top three shocks and characteristics (cost, count, ongoing)
		* Count
		forval i = 1/3 {
			gen topS`i' = 0 // #incidence of #(1-3) shocks
			replace topS`i' = t1_03 if t1_10 == `i'
		}
		bysort a01: gen topS = topS1+topS2+topS3 // total top3
		* Top[3] Shock Costs
		gen topCo = 0 
			replace topCo = t1_07 if topS != 0
		bysort a01: egen topC = max(topCo)
		* Top[3] Ongoing
		gen ongoing = 0 	
			replace ongoing = 1 if t1_09 == 999
		bysort a01: egen TopOng = total(ongoing)
			
		
		
		
		
	* Total shocks and characteristics (cost, ongoing)
		
		
		
		
		dddddd
		
		* Labels & Fixes
		label variable topS "# incidence of top3 shocks"
		label variable topC "Total cost of top3 shocks"		
		drop topS* topCo
		

		

	
	* Total & top3 shocks and z-scores (winsorizing 97.5%) 
	* AFTER dups removed
		by a01: egen total_shocks_11 =  total(t1_03)
		by a01: egen top3_shocks = rowtotal(S1 S2 S3) // count
		
	

	
	* Total shocks from top three shocks and z-scores
	
	* Create non-parametric distribution of shocks incidence (#)
	
	* Map shocks to an IRT weighting 
	
	
	
	

	
	merge 1:1 a01 using "$t1_data\BIHS_15\050_r2_mod_t1_male.dta"
	
	merge 1:1 a01 using "$t1_data\BIHS_19\BIHSRound3\Male\067_bihs_r3_male_mod_t1b.dta"

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	global XYC_temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\XYC_Temp_files"
	global folder "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data"	