*******************************************
** COMMUNITY VARIABLES - BROADLY DEFINED ** 2015
*******************************************
clear all

* Set globals for data
	global BIHS_15c "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_15"	
	global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars\Community Temp Files"
	global folderc "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars"

** Community Data Merge
		* BIHS 2015
		  * Community file 2015 - cb (unique sl, by 323 SL values)
			use "$BIHS_15c\111_module_cb_community.dta", replace
		  * Community file 2015 - cc (unique slno) - Ag Practices, input supply	
			use "$BIHS_15c\112_module_cc_community.dta", replace
		  * Community file 2015 - cd (unique slno) - Healthcare access
			use "$BIHS_15c\113_module_cd_community.dta", replace
				* Reshape and go
				reshape wide cd02 cd03 cd04 cd05 cd06, i(sl) j(cd01)
				drop cd02* cd04*
				ren (cd031 cd051 cd061)(priv_clin_avail priv_clin_lon priv_clin_lat)
				ren (cd032 cd052 cd062)(gov_clin_avail gov_clin_lon gov_clin_lat)
				ren (cd033 cd053 cd063)(pharma_avail pharma_lon pharma_lat)
				save "$temp\113_module_cd_community_edit15.dta", replace	
	  * Community file 2015 - ce (unique slno) - Informal Credit availability
		use "$BIHS_15c\114_module_ce_community.dta", replace	  
	  * Community file 2015 - cf (includes slno) - Education facilities
		//use "Z:\nwg6\CCRE\Raw Data\BIHS\BIHS_15\115_module_cf_community.dta", replace			
	  * Community file 2015 - cg (includes slno) - NGO dev't programs
		//use "Z:\nwg6\CCRE\Raw Data\BIHS\BIHS_15\116_module_cg_community.dta", replace
	  * Community file 2015 - ci (includes slno)
		use "$BIHS_15c\117_module_ci_community.dta", replace
		* Messy recode
			drop flag				
			reshape wide c103, i(sl) j(c102)
			label variable c1031 "ananda school"
			label variable c1032 "stipend for primary students"
			label variable c1033 "school feeding program"
			label variable c1034 "stipend for dropout students"		
			label variable c1035 "stipend for secondary and higher second"
			label variable c1036 "stipend for poor boys in secondary school"		
			label variable c1037 "stipend for disabled students"
			label variable c1038 "old age allowance"	
			label variable c1039 "allowances for distressed cultural persons"
			label variable c10310 "allowances for beneficiaries in ctg hil"		
			label variable c10311 "allowances for the widowed deserted an"			
			label variable c10312 "allowances for financially insolvent"			
			label variable c10313 "maternity allowances prog. for poor"
			label variable c10314 "maternal health voucher scheme"				
			label variable c10316 "honorarium for insolvent freedom fighters"		
			label variable c10315 "honorarium for injured freedom fighters"		
			label variable c10317 "gratuitous relief (cash)"					
			label variable c10318 "gratuitious relief (gr)- food"				
			label variable c10319 "general relief activities"				
			label variable c10320 "cash for work" 		
			label variable c10321 "agricultural rehabilitation"				
			label variable c10322 "subsidy for open market sales"
			label variable c10323 "vulnerable group development"				
			label variable c10324 "vgd-up (8 dist. on monga area)"		
			label variable c10325 "vulnerable group feeding (vgf)"				
			label variable c10326 "test relief (tr) food"				
			label variable c10327 "food assitance in ctg-hill tracts area"	
			label variable c10328 "food for work (ffw)"				
			label variable c10329 "special fund for employment generation"	
			label variable c10330 "fund for the welfare of acid burnt and"			
			label variable c10331 "100 days employment scheme"				
			label variable c10332 "rural empl opportunities for prot"				
			label variable c10333 "rural employment and rural maitenence"
			label variable c10334 "community nutrition program"
			label variable c10335 "char livelihood program"
			label variable c10336 "shouhardo program (care)"		
			label variable c10337 "accommodation (poverty alleviation & re"
			label variable c10338 "Housing Support)"					
			label variable c10339 "tup (brac)"
			label variable c10340 "one house one farm"			
			label variable c10341 "improving maternal and child nutrition"
			label variable c10342 "enhancing resilience to disasters and t"			 
			ren c10343 ngo_43a // change names because extra program added
			ren c10344 c10343 // Harmonizing 2011 and 2015 forms			
			label variable ngo_43a "TMRI program"
			label variable c10343 "other (specify)"
			forvalues i = 1/43 {
				ren c103`i' ngo_`i'
			}
			save "$temp\117_module_ci_community_edit15.dta", replace	
	  * Community file 2015 - ck (includes slno)
		use "$BIHS_15c\118_module_ck_community.dta", replace
			forvalues i = 1/4 {
				replace q`i' = . if q`i' == 999
			}
			replace q2 = . if q1 == .
			replace q4 = . if q3 == .		
			gen m_wage = q1 + q2
			gen f_wage = q3 + q4
			drop if q1 == 999
			drop if q2 == 999
			drop if q3 == 999
			drop if q4 == 999
			drop q1-q4
			reshape wide m_wage f_wage, i(sl) j(Ag_labor)					
			label variable m_wage1 "normal wage+meal taka/day, manual land prep"
			label variable f_wage1 "normal wage+meal taka/day, manual land prep"	
			label variable m_wage2 "normal wage+meal taka/day, planting"
			label variable f_wage2 "normal wage+meal taka/day, planting"	
			label variable m_wage3 "normal wage+meal taka/day, irrig. work"
			label variable f_wage3 "normal wage+meal taka/day, irrig. work"				
			label variable m_wage4 "normal wage+meal taka/day, seed broadcast"
			label variable f_wage4 "normal wage+meal taka/day, seed broadcast"		
			label variable m_wage5 "normal wage+meal taka/day, transplanting"
			label variable f_wage5 "normal wage+meal taka/day, transplanting"		
			label variable m_wage6 "normal wage+meal taka/day, applying fert/pest"
			label variable f_wage6 "normal wage+meal taka/day, applying fert/pest"	
			label variable m_wage7 "normal wage+meal taka/day, weeding"
			label variable f_wage7 "normal wage+meal taka/day, weeding"				
			label variable m_wage8 "normal wage+meal taka/day, harvesting"
			label variable f_wage8 "normal wage+meal taka/day, harvesting"				
			label variable m_wage9 "normal wage+meal taka/day, earth/mud work"
			label variable f_wage9 "normal wage+meal taka/day, earth/mud work"		
			label variable m_wage10 "normal wage+meal taka/day, labor brick field"
			label variable f_wage10 "normal wage+meal taka/day, labor brick field"		 
			label variable m_wage11 "normal wage+meal taka/day, brick/stone breaking"	
			label variable f_wage11 "normal wage+meal taka/day, brick/stone breaking"	
			label variable m_wage12 "normal wage+meal taka/day, wood chopping"	
			label variable f_wage12 "normal wage+meal taka/day, wood chopping"	
			label variable m_wage13 "normal wage+meal taka/day, masonry"	
			label variable f_wage13 "normal wage+meal taka/day, masonry"	
			label variable m_wage14 "normal wage+meal taka/day, helper"	
			label variable f_wage14 "normal wage+meal taka/day, helper"
			save "$temp\118_module_ck_community_edit15.dta", replace	
	  * Community file 2015 - k1 (includes slno) - food item prices
		use "$BIHS_15c\119_module_k1_community.dta", replace
			drop flag unit
			drop if code == . //drops one uncoded observation
			reshape wide price, i(sl) j(code)
				label variable price1 "Parboiled rice (coarse), by KG"
				label variable price2 "Non-parboiled rice (coarse), by KG"			
				label variable price3 "Fine Rice, by KG"			
				label variable price4 "Wheat, by KG"		
				label variable price5 "Atta, by KG"  
				label variable price6 "Chira (flattened rice), by KG"
				label variable price7 "Muri/Khoi (puffed rice), by KG"			
				label variable price8 "Lentil, by KG"			
				drop price9-price30
				label variable price31 "Egg, by piece"		
				label variable price32 "Milk, by KG" 
				drop price33-price46  
				save "$temp\119_module_k1_community_edit15.dta", replace	
	  * Community file 2015 - k2 (includes slno) - non-food item prices
			//use "$BIHS_15c\120_module_k2_community.dta", replace	
	** Merge 2015 Community-level Files
		use "$BIHS_15c\111_module_cb_community.dta", replace
		ren sl slno
			merge 1:1 slno using "$BIHS_15c\112_module_cc_community.dta"
			drop _merge
			merge 1:1 slno using "$temp\113_module_cd_community_edit15.dta"			
			drop _merge
			merge 1:1 slno using "$BIHS_15c\114_module_ce_community.dta"
			drop _merge		
			merge 1:1 slno using "$temp\117_module_ci_community_edit15.dta"
			drop _merge
			merge 1:1 slno using "$temp\118_module_ck_community_edit15.dta"
			drop _merge		
			merge 1:1 slno using "$temp\119_module_k1_community_edit15.dta"
			drop _merge		
			gen WAVE = 2015
			
		* Merge with crosswalk
			gen c1 = ca01
			gen c4 = ca04
			gen c5 = ca05
			gen c6 = ca06
			gen c7 = ca07
		
		
		
			save "$temp\CommM2.dta", replace
		
		

		
		
		
			
			

		
		
		
		
		
		
		
		
/* Unused Code

			gen c1 = 0
				replace c1 = 10000000*ca01 if ca01 < 10
				replace c1 = 10000000*ca01 if ca01 > 9
			gen c4 = 0
				replace c4 = 1000000*ca04 if ca04 < 10
				replace c4 = 100000*ca04 if ca04 > 9				
			gen c5 = 0
				replace c5 = 10000*ca05 if ca05 < 10
				replace c5 = 1000*ca05 if ca05 > 9				
			gen c6 = 0
				replace c6 = 1000*ca06 if ca06 < 10
				replace c6 = 100*ca06 if ca06 > 9	
			gen c7 = 0
				replace c7 = 1000*ca07 if ca07 < 10
				replace c7 = 100*ca07 if ca07 > 9		
			gen c0 = c1+c4+c5+c6+c7	
				tab c0
				format c0 %16.0f
				tab c0



*/	
		
		
		
		
		
		
		
		
		