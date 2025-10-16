************************
** PostMerge Analysis ** Add consumption data, fix community matches, ID samples
************************
clear all

* Globals *	
	global XYC_temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data\XYC_Temp_files"
	global folder7 "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 7 - Identifying Data"
	global folder6 "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 6 - Post Merge Fixes"
	global folder5 "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 5 - Merge HH Data"	
	global folder4 "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars"
	
******************************
** ADD CPI & AGG.CONS. DATA	**
******************************
	* Create a basis for conversions to the USD $1.90 poverty line
		import excel "$folder6\Currency_Conversions_taka_usd.xlsx", sheet("Sheet1") clear
			split A, p(/)
				destring A1, replace
				destring A2, replace
				ren A1 a16_mm
				ren A2 a16_yy
				drop A
				ren B EXR
				drop if a16_yy>2020
			save "$folder6\Currency_Conversions_taka_usd.dta", replace	
	* Open CPI Data from Walid at IFPRI; id(period e.g. 01sep2010 format)
		import excel "$folder6\Monthly_CPI_Base_2005-06_2010-11_2021_22_NR_edited.xlsx", ///
			sheet("Monthly_Base_05-06") firstrow clear
		save "$folder6\Monthly_CPI_base.dta", replace					
	* Open aggregated consumption data; id(a01)
		use "$folder6\BIHS_hh_expenditure_r123.dta", replace
			gen WAVE = .
				replace WAVE = 2011 if round == 1
				replace WAVE = 2015 if round == 2
				replace WAVE = 2019 if round == 3		
			* Merge in conversion to USD factor
				merge m:1 a16_mm a16_yy using "$folder6\Currency_Conversions_taka_usd.dta"  
				drop if _merge == 2
				drop _merge
		save "$folder6\BIHS_hh_expenditure_r123_EDIT.dta", replace					
	* Merge to base dataset
		use "$folder5\Merge_XYC.dta", replace
		drop if mid==.
		cap drop _merge]	
		merge 1:1 a01 WAVE using "$folder6\BIHS_hh_expenditure_r123_EDIT.dta", force gen(merge0)	
			// note the expenditure data only records non-FTF household data
			cap drop merge0
			gen date_dd = 1
			gen period = .			
			* Create dates, using first of month the interview took place in
			gen date2011 = mdy(a16_mm, date_dd, a16_yy)
			gen date2015 = mdy(ca12mm, date_dd, ca12yy) // use CommVar
			gen date2019 = mdy(a16_1_mm, date_dd, a16_1_yy)			
			* Generate matched merging column
			replace period = date2011 if WAVE == 2011
			replace period = date2015 if WAVE == 2015
			replace period = date2019 if WAVE == 2019
			* Reformat
			format period %td
			* Merge
			cap drop _merge
			merge m:1 period using "$folder6\Monthly_CPI_base.dta" 			
				gen Has_Expend_Data = (_merge == 3)
			* CPI adjustments (all in general terms)			
				* Per capita expenditures (taka)
				gen pc_expm_real_gen   = (pc_expm/(gencpi/171.23))
				gen pc_expm_real_gen_r = (pc_expm/(gencpi_r/174.32))
				gen pc_expm_real_gen_u = (pc_expm/(gencpi_u/165.61))
				
				gen pc_foodxm_real_gen   = pc_foodxm/(gencpi/171.23)
				gen pc_foodxm_real_gen_r = pc_foodxm/(gencpi_r/174.32)
				gen pc_foodxm_real_gen_u = pc_foodxm/(gencpi_u/165.61)
				gen pc_foodxm_real_food  = pc_foodxm/(foodcpi/188.34)
				gen pc_foodxm_real_food_r= pc_foodxm/(foodcpi_r/187.76)
				gen pc_foodxm_real_food_u= pc_foodxm/(foodcpi_u/189.77)
				
				gen pc_nonfxm_real_gen     = pc_nonfxm/(gencpi/171.23)
				gen pc_nonfxm_real_gen_r   = pc_nonfxm/(gencpi_r/174.32)
				gen pc_nonfxm_real_gen_u   = pc_nonfxm/(gencpi_u/165.61)
				gen pc_nonfxm_real_nonf    = pc_nonfxm/(nonfoodcpi/149.28)
				gen pc_nonfxm_real_nonf_r  = pc_nonfxm/(nonfoodcpi_r/152.92)
				gen pc_nonfxm_real_nonf_u  = pc_nonfxm/(nonfoodcpi_u/144.42)

				gen pcx_rce_real_gen   = pcx_rce/(gencpi/171.23)
				gen pcx_rce_real_gen_r = pcx_rce/(gencpi_r/174.32)
				gen pcx_rce_real_gen_u = pcx_rce/(gencpi_u/165.61)
				gen pcx_rce_real_food  = pcx_rce/(foodcpi/188.34)
				gen pcx_rce_real_food_r= pcx_rce/(foodcpi_r/187.76)
				gen pcx_rce_real_food_u= pcx_rce/(foodcpi_u/189.77)
				
				* Per capita expenditures (USD)		
				
				gen fake_pc_expm_real = pc_expm/EXR
				gen pc_expm_real_gen_USD   = (pc_expm/(gencpi/171.23))*(1/EXR)
				gen poverty_line_real_gen_USD = (1.90*30.5)/(gencpi/171.23)
				gen poverty_line_150p = 1.5 * poverty_line_real_gen_USD
		save "$folder6\MergeXYCE.dta", replace

		
**********************************************
** MATCH ON COMMUNITY VARIABLES FOR MISSING	**
**********************************************
	/* Data Checks
		* Village identifiers
			tab ca01 WAVE    // (7370 in 3 waves, 1-30)
			tab village WAVE // (5605 in 2019, 1-447)
			tab Village WAVE // (6964 in 2011-2015, 11dig strings)
			tab vcode_n WAVE // (7037 in 2011-2015, 1-318)
			tab vcode WAVE   // (6568 in 2015, 11dig strings)
		* Union identifiers
			tab uncode WAVE  // (13071, 2011-2015, 6dig strings)
			tab Union WAVE   // (13071, 2011-2015, 6dig strings)
			tab union WAVE   // (6641, 2011-2015, 6dig strings)
			tab ca04 WAVE    // (7370 in 3 waves, 1-428)
		* Upazila identifiers
			tab Upazila WAVE // (13467, 2011-2015, 4dig strings)
			tab upazila WAVE // (6503, 2011, 4dig strings)
			tab ca05 WAVE    // (7370, 2011-2019, 2-370) DID NOT MATCH
	*/
	* Get data
	use "$folder6\MergeXYCE.dta", replace	
	** Fill in information with a reshape
		keep a01 mid x1 ca01 ca04 ca05 ca06 ca07 village vcode_n community_id WAVE	
			bysort a01 WAVE: gen dup = cond(_N==1,0,_n)
			drop if dup>0
			drop dup
			reshape wide x1 mid ca01 ca04 ca05 ca06 ca07 village ///
				vcode_n community_id, i(a01) j(WAVE)
		* Replace values as fit
			* Village
				replace ca012011 = ca012015 if x12019 == 1		
				replace ca012019 = ca012015 if x12019 == 1		
			* Union
				replace ca042011 = ca042015 if x12019 == 1		
				replace ca042019 = ca042015 if x12019 == 1					
			* Upazila
				replace ca052011 = ca052015 if x12019 == 1		
				replace ca052019 = ca052015 if x12019 == 1
			* District
				replace ca062011 = ca062015 if x12019 == 1		
				replace ca062019 = ca062015 if x12019 == 1		
			* Division	
				replace ca072011 = ca072015 if x12019 == 1		
				replace ca072019 = ca072015 if x12019 == 1
			* village
				replace village2011 = village2019 if x12019 == 1		
				replace village2015 = village2019  if x12019 == 1			
			* vcode_n
				replace vcode_n2019 = vcode_n2011 if x12019 == 1		
				replace vcode_n2015 = vcode_n2011 if x12019 == 1
			* community_id
				replace community_id2011 = community_id2019 if x12019 == 1
				replace community_id2015 = community_id2019 if x12019 == 1

		* Mark original HH, keep original households
			gen a01_round = round(a01)	// rounded a01	
			gen stableHH = 1
			replace stableHH = . if a01 != a01_round & x12019 == 2		
			bysort a01_round: egen HH_loc1 = min(ca012015)			
			bysort a01_round: egen HH_loc4 = min(ca042015)
			bysort a01_round: egen HH_loc5 = min(ca052015)
			bysort a01_round: egen HH_loc6 = min(ca062015)
			bysort a01_round: egen HH_loc7 = min(ca072015)
		* Replace missing values within the ca0 family
			* Village
			replace ca012011 = HH_loc1 if x12019 == 1
			replace ca012019 = HH_loc1 if x12019 == 1 
			* Union
			replace ca042011 = HH_loc4 if x12019 == 1
			replace ca042019 = HH_loc4 if x12019 == 1 
			* Upazila 
			replace ca052011 = HH_loc5 if x12019 == 1
			replace ca052019 = HH_loc5 if x12019 == 1 
			* District
			replace ca062011 = HH_loc6 if x12019 == 1
			replace ca062019 = HH_loc6 if x12019 == 1 
			* Division
			replace ca072011 = HH_loc7 if x12019 == 1
			replace ca072019 = HH_loc7 if x12019 == 1 
		* Drop things
			reshape long
				//keep if stableHH ==1
				drop if mid ==. 
				drop HH_loc1-HH_loc7				
				//drop if x1 == 2
			* Fill-in things
				reshape wide			
				//keep if x12019 != .				
				foreach i in 1 4 5 6 7 {
					replace ca0`i'2011 = ca0`i'2019
					replace ca0`i'2015 = ca0`i'2019
				}
				replace village2011 = village2019
				replace village2015 = village2019							
		* In unit max
			reshape wide
			// keep a01 x12019 a01_round vcode* village* // drop later
				* replace empties in vcode_n and village
					replace vcode_n2011 = 0 if vcode_n2011 == .
					replace vcode_n2015 = 0 if vcode_n2015 == .
					replace vcode_n2015 = 0 if vcode_n2019 == .
					replace village2011 = 0 if village2011 == .
					replace village2015 = 0 if village2015 == .
					replace village2019 = 0 if village2019 == .
				* vcode_n by 2011 and 2019 to trace 
					bysort a01_round: egen vc2011 = max(vcode_n2011)
					bysort a01_round: egen vc2015 = max(vcode_n2015)
					bysort a01_round: egen vc2019 = max(vcode_n2019)
				* village by 2011 and 2019 to trace
					bysort a01_round: egen vill2011 = max(village2011)
					bysort a01_round: egen vill2015 = max(village2015)
					bysort a01_round: egen vill2019 = max(village2019)
					bysort a01_round: egen x1_round = max(x12019)
				* Generate rowmax for groups, conditional on 
					egen vc_max   = rowmax(vc2011 vc2015 vc2019)
					egen vill_max = rowmax(vill2011 vill2015 vill2019)
			* Fill in x12019 if relevant
					replace x12019 = x1_round if x12019 == .
					replace x12019 = -99 if x12019 ==.
			* Replace village2011 and village 2015 if
				replace village2011 = vill_max if x12019==1
				replace village2015 = vill_max if x12019==1
				replace village2019 = vill_max if x12019==1
				replace vcode_n2011 = vc_max if x12019==1
				replace vcode_n2015 = vc_max if x12019==1
				replace vcode_n2019 = vc_max if x12019==1
			* Similar fix but for ca family
				egen ca01_max=rowmax(ca012011 ca012015 ca012019)
				egen ca04_max=rowmax(ca042011 ca042015 ca042019)
				egen ca05_max=rowmax(ca052011 ca052015 ca052019)
				egen ca06_max=rowmax(ca062011 ca062015 ca062019)
				egen ca07_max=rowmax(ca072011 ca072015 ca072019)
				replace ca01_max = 0 if ca01_max == .
				replace ca04_max = 0 if ca04_max == .
				replace ca05_max = 0 if ca05_max == .
				replace ca06_max = 0 if ca06_max == .
				replace ca07_max = 0 if ca07_max == .
				bysort a01_round: egen ca01max = max(ca01_max)
				bysort a01_round: egen ca04max = max(ca04_max)
				bysort a01_round: egen ca05max = max(ca05_max)
				bysort a01_round: egen ca06max = max(ca06_max)
				bysort a01_round: egen ca07max = max(ca07_max)				
				replace ca012011 = ca01max if x12019==1
				replace ca042011 = ca04max if x12019==1
				replace ca052011 = ca05max if x12019==1
				replace ca062011 = ca06max if x12019==1
				replace ca072011 = ca07max if x12019==1
			* Reshape long one time, clean a bit
				reshape long
				//drop if mid ==.
				//replace stableHH = 0 if village == 0
				//replace x1 = 1 if stableHH ==1
				//replace x1 = 2 if stableHH ==0
				gen stable_x1 = 1
			* Fix for tracking mid values
				gen mid2011 = 0
				replace mid2011 = mid if WAVE == 2011
				bysort a01_round: egen mid2011max = max(mid2011)
				replace stableHH = 0 if mid != mid2011max
			* Stats for how many households are actually in play
				tab WAVE if stableHH == 1
				drop vc2011-mid2011max
			* Saving the dataset 
			save "$folder6\stable_crosswalk.dta", replace
	

***************************************
** MERGE DATA WITH STABLE CROSSWALK	 **
***************************************
	use "$folder6\MergeXYCE.dta", replace
		gen set1 = 1
		drop merge1 
		drop ca01 ca04 ca05 ca06 ca07 vcode_n village				
		merge m:1 a01 WAVE using "$folder6\stable_crosswalk.dta", gen(merge_cw)
		drop dcode-merge3
	* Fill in missing shocks/coping
			set trace on
			foreach j in 5y 2y ONG ML 1y {
				replace shock_count_`j' = 0 if shock_count_`j' == . 
				replace health_shocks_`j' = 0 if health_shocks_`j' == .
				replace weather_shocks_`j' = 0 if weather_shocks_`j' == .
				replace ag_shocks_`j' = 0 if ag_shocks_`j' == .
				replace coping_count_`j' = 0 if coping_count_`j' == .
			}	
			set trace off
			//drop if ca07 == 0		
	* Filling in 
		replace ca07 = 10 if div_name == "Barisal"
		replace ca07 = 20 if div_name == "Chittagong"
		replace ca07 = 30 if div_name == "Dhaka"
		replace ca07 = 40 if div_name == "Khulna"
		replace ca07 = 50 if div_name == "Rajshahi"
		replace ca07 = 55 if div_name == "Rangpur"
		replace ca07 = 60 if div_name == "Syhlet"
	* A last attempt at saving the community variables
		drop if mid == .
		* Via "ca__"
			drop if mid ==. 
			cap drop c1 c4 c5 c6 c7
			foreach i in 1 4 5 6 7 {
				bysort a01_round: egen mode_c`i' = median(ca0`i')
				replace ca0`i' = mode_c`i' if ca0`i' == .
			}
	* Merge in Community Variables 
		cap drop _merge
		merge m:1 ca01 ca04 ca05 ca06 ca07 WAVE ///
			using "$folder4\CommVars.dta", force
		drop _merge
		drop if mid ==. 
		drop stable123
		
*******************************
** Fix missing village codes **
*******************************
	* Split uncode/Union - assume if same union then same village
		gen uncode1 = uncode
			replace uncode1 = 0 if WAVE == 2015
		gen uncode2 = uncode
			replace uncode2 = 0 if WAVE == 2011				
		bysort a01_round: egen max_un1 = max(uncode1)
		bysort a01_round: egen max_un2 = max(uncode2)			
			gen un_test = 0
			replace un_test = 1 if max_un1 == max_un2 & WAVE != 2019
		gen vcode_2011 = vcode_n
			replace vcode_2011 = . if WAVE != 2011
			bysort a01_round: egen max_uncode_2011 = max(vcode_2011)
		replace vcode_n	= max_uncode_2011 if WAVE == 2015 & un_test ==1
	* Intermediate save		
		save "$folder7\Step7a_data.dta", replace
		
/*		EXTRA: USED TO CREATE 7B but no longer required
**************************************
** Attempt to fix one more district **		
**************************************	
	clear
		use "$folder7\Step7a_data.dta", replace
		keep a01 District District_Name ca07 ca06 WAVE x1 ca05 ca04 ca01
	* Reshape
		reshape wide District* ca* x1, i(a01) j(WAVE)
		drop x12011 x12015
		ren x12019 x1
		drop District*
	* Splits
		gen split = (a01 - round(a01) > 0)
	* Missing or zero value ca* entries
		gen missing1 = (ca062019 == 0) // if 2019 missing
		gen missing2 = 0 // if 2015 missing
			replace missing2 = 1 if ca062011 == . & ///
				ca062015 == . & ca062019 == .
	* Switch zeroes to "missing" in 2019 (since reflected to other columns next via "x1" variable
		replace ca072019 = . if ca072019 == 0
		replace ca062019 = . if ca062019 == 0
		replace ca052019 = . if ca052019 == 0
		replace ca042019 = . if ca042019 == 0
		replace ca012019 = . if ca012019 == 0
	* Groups - reflecting to previous years by "x1" status
		* Division
		replace ca072011 = ca072019 if x1 == 1 & ///
			ca072011 == . & split != 1
		replace ca072015 = ca072019 if x1 == 1 & ///
			ca072015 == .			
		* District
		replace ca062011 = ca062019 if x1 == 1 & ///
			ca062011 == . & split != 1
		replace ca062015 = ca062019 if x1 == 1 & ///
			ca062015 == .	
		* Upazila (05)
		replace ca052011 = ca052019 if x1 == 1 & ///
			ca052011 == . & split != 1
		replace ca052015 = ca052019 if x1 == 1 & ///
			ca052015 == .	
		* Union (04)
		replace ca042011 = ca042019 if x1 == 1 & ///
			ca042011 == . & split != 1
		replace ca042015 = ca042019 if x1 == 1 & ///
			ca042015 == .	
		* Village
		replace ca012011 = ca012019 if x1 == 1 & ///
			ca012011 == . & split != 1
		replace ca012015 = ca012019 if x1 == 1 & ///
			ca012015 == .
	* Replace if zeros
		replace ca012011 = . if ca012011 == 0
		replace ca042011 = . if ca042011 == 0
		replace ca052011 = . if ca052011 == 0
		replace ca062011 = . if ca062011 == 0
		replace ca072011 = . if ca072011 == 0
	* Drop "missing" condition identifiers for reshape
		drop missing*
	** Conditions for data identifier availability
		* 2011
			gen da2011 = (ca072011 == 1)
				replace da2011 = 1 if split == 0
		* 2015
			gen da2015 = (ca072015 != .)
			
		* 2019
			gen da2019 = (ca072019 != .)
	** Conditions for split timing
		* Split 2015
			gen sp2015 = (split == 1 & ca072015 !=.)
		* Split 2019
			gen sp2019 = (split == 1 & sp2015 == 0 ///
				& ca072019 !=.)
	** Clean and reshape
		drop split
		gen x12011 = . 
		gen x12015 = .
		ren x1 x12019
		reshape long stub, i(i) j(j)
	
	
	
	
	
	
	

		
	(cut)
	
********************
** Step7b Dataset ** APPENDIX
********************		

	* Save the data file with a creative name (end of PostMerge Fixes)
		save "$folder7\Step7b_data.dta", replace
	* Remove duplicates, first with missing village
		//drop if ca01 == .
	* Remove duplicates, second with HH with >3 units per group		
		bysort a01_round: egen HH_rep = count(a01_round)			
		gen test0 = 0
			replace test0 = mid if WAVE == 2011
			bysort a01_round: egen test1 = max(test0)		
		drop if mid != test1
		drop test1 test0
		drop if mem_stat == 10 & HH_rep > 3		
		bysort a01_round: egen HH_rep1 = count(a01_round)		
		drop HH_rep*	
	* Merge in Community Variables 
		cap drop _merge
		merge m:1 ca01 ca04 ca05 ca06 ca07 WAVE ///
			using "$folder4\CommVars.dta", force

		* Removed the merge function	
		
		replace ca01 =. if ca01 == 0
		replace ca04 =. if ca04 == 0
		replace ca05 =. if ca05 == 0
		replace ca06 =. if ca06 == 0
		replace ca07 =. if ca07 == 0
		drop if a01 == .
		// drop if WAVE == 2019 // change later
		drop if ca07 == 0
		tab _merge WAVE		
		tab vcode_n _merge if WAVE == 2011
		tab vcode_n WAVE if vcode_n != . & WAVE == 2011 
		tab vcode_n WAVE if WAVE == 2011 & _merge == 3
	* Save the data file with a creative name (end of PostMerge Fixes)
		save "$folder7\Step7b_data.dta", replace
	
*/	
	
	
