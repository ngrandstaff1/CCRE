*******************************************
** COMMUNITY VARIABLES - BROADLY DEFINED ** 2019
*******************************************
clear all

* Set globals for data
	global BIHS_19c "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Community"	
	global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars\Community Temp Files"
	global folderc "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars"

** Community Data Merge
	* BIHS 2019
		* Community file 2019 - ca_1 (unique "community" to merge ModA)
			use "$BIHS_19c\140_r3_com_mod_ca_1.dta", replace	  
		* Community file 2019 - ca_2 (unique "community") 
			use "$BIHS_19c\141_r3_com_mod_ca_2.dta", replace	  
		* Community file 2019 - cb_1 (unique "community")
			use "$BIHS_19c\142_r3_com_mod_cb_1.dta", replace	  
			reshape wide cb03 cb04 cb05 cb06 cb07, i(community) j(cb01)
			forvalues i = 1/24 {
				drop cb03`i' cb05`i'
				replace cb04`i' = 0 if cb04`i' == .
			} 			
			ren (cb041 cb061 cb071) (market_avail market_lat market_lon)		
			ren (cb042 cb062 cb072)(bazaar_avail bazaar_lat bazaar_lon)			
			ren (cb046 cb066 cb076)(teleph_avail teleph_lat teleph_lon)			
			ren (cb047 cb067 cb077)(internet_avail internet_lat internet_lon)	
			ren (cb048 cb068 cb078)(commbank_avail commbank_lat commbank_lon)
			ren (cb0411 cb0611 cb0711)(fert_depot_avail fert_depot_lat ///
			fert_depot_lon)					
			ren (cb0412 cb0612 cb0712)(local_supply_depot_avail ///
			local_supply_depot_lat local_supply_depot_lon)					
			ren (cb0414 cb0614 cb0714)(grain_storage_avail grain_storage_lat ///
			grain_storage_lon)					
			ren (cb0417 cb0617 cb0717)(livestock_feed_avail ///
			livestock_feed_lat livestock_feed_lon)					
			ren (cb0418 cb0618 cb0718)(vet_avail vet_lat vet_lon)
			drop cb*	
			save "$temp\142_r3_com_mod_cb_1_edit19.dta", replace		  
		 * Community file 2019 - cb_2 (unique "community")
			use "$BIHS_19c\143_r3_com_mod_cb_2.dta", replace				
		 * Community file 2019 - cc (unique "community")
			use "$BIHS_19c\144_r3_com_mod_cc.dta", replace
		 * Community file 2019 - cd (unique "community")
			use "$BIHS_19c\145_r3_com_mod_cd.dta", replace			
			* Reshape and go
				reshape wide cd02 cd03 cd04 cd05 cd06, i(comm) j(cd01)
				drop cd02* cd04*
				ren (cd031 cd051 cd061)(priv_clin_avail priv_clin_lon priv_clin_lat)
				ren (cd032 cd052 cd062)(gov_clin_avail gov_clin_lon gov_clin_lat)
				ren (cd033 cd053 cd063)(pharma_avail pharma_lon pharma_lat)	
				save "$temp\145_r3_com_mod_cd_edit19.dta", replace
		 * Community file 2019 - ce (unique "community")
			use "$BIHS_19c\146_r3_com_mod_ce.dta", replace
		 * Community file 2019 - cf (unique "community")
			//use "$BIHS_19c\147_r3_com_mod_cf.dta", replace		
		 * Community file 2019 - cg (unique "community") 
			//use "$BIHS_19c\148_r3_com_mod_cg.dta", replace
		 * Community file 2019 - ci (unique "community")
			use "$BIHS_19c\149_r3_com_mod_ci.dta", replace			
			* Messy recode
				reshape wide ci03, i(comm) j(ci01)				
				label variable ci031 "ananda school"
				label variable ci032 "stipend for primary students"
				label variable ci033 "school feeding program"
				label variable ci034 "stipend for dropout students"		
				label variable ci035 "stipend for secondary and higher second"
				label variable ci036 "stipend for poor boys in secondary school"		
				label variable ci037 "stipend for disabled students"
				label variable ci038 "old age allowance"	
				label variable ci039 "allowances for distressed cultural persons"
				label variable ci0310 "allowances for beneficiaries in ctg hil"		
				label variable ci0311 "allowances for the widowed deserted an"			
				label variable ci0312 "allowances for financially insolvent"			
				label variable ci0313 "maternity allowances prog. for poor"
				label variable ci0314 "maternal health voucher scheme"				
				label variable ci0316 "honorarium for insolvent freedom fighters"		
				label variable ci0315 "honorarium for injured freedom fighters"		
				label variable ci0317 "gratuitous relief (cash)"					
				label variable ci0318 "gratuitious relief (gr)- food"				
				label variable ci0319 "general relief activities"				
				label variable ci0320 "cash for work" 		
				label variable ci0321 "agricultural rehabilitation"				
				label variable ci0322 "subsidy for open market sales"
				label variable ci0323 "vulnerable group development"				
				label variable ci0324 "vgd-up (8 dist. on monga area)"		
				label variable ci0325 "vulnerable group feeding (vgf)"				
				label variable ci03261 "test relief (tr) food"				
				label variable ci03262 "test relief (tr) cash"				
				label variable ci0327 "food assitance in ctg-hill tracts area"	
				label variable ci0328 "food for work (ffw)"				
				label variable ci0329 "special fund for employment generation"	
				label variable ci0330 "fund for the welfare of acid burnt and"			
				label variable ci0331 "100 days employment scheme"				
				label variable ci0332 "rural empl opportunities for prot"				
				label variable ci0333 "rural employment and rural maitenence"
				label variable ci0334 "community nutrition program"
				label variable ci0335 "char livelihood program"
				label variable ci0336 "shouhardo program (care)"		
				label variable ci0337 "accommodation (poverty alleviation & re"			
				label variable ci0338 "Housing Support"					
				label variable ci0339 "tup (brac)"
				label variable ci0340 "one house one farm"		
				ren ci0343 ngo_43a
				label variable ngo_43a "TMRI program"
				label variable ci0344 "other (specify)"
				label variable ci0345 "Proshar Program (ACDI VOCA)"
				label variable ci0346 "Nabajibon Program (Save the Children)"
				label variable ci0347 "improving maternal and child nutrition"			
				label variable ci0348 "Pension program for retired government"			
				label variable ci0349 "Ration Program for Martyr Family and Wo"			
				label variable ci0350 "Program for improving the living standa"
				label variable ci0351 "Climate Rehabilitation Program (Gucchog"
				label variable ci0352 "Social Security Policy Support (SSSS) P"
				forvalues i = 1/25 {
					ren ci03`i' ngo_`i'
				}
				forvalues i = 27/40 {
					ren ci03`i' ngo_`i'
				}
				forvalues i = 44/52 {
					ren ci03`i' ngo_`i'
				}	  
				save "$temp\149_r3_com_mod_ci_edit19.dta", replace
		 * Community file 2019 - ck (unique "community") 
			use "$BIHS_19c\150_r3_com_mod_ck.dta", replace	  
				gen f_mis = 0
					replace f_mis = 1 if ck_04 == . | ck_05 == .
				gen m_mis = 0 
					replace m_mis = 1 if ck_02 == . | ck_03 == .			
				replace ck_02 = 0 if ck_02 == .
				replace ck_03 = 0 if ck_03 == .
				replace ck_04 = 0 if ck_04 == .		
				replace ck_05 = 0 if ck_05 == .						
				gen m_wage = ck_02 + ck_03
				gen f_wage = ck_04 + ck_05 // changed to zeroes bc no value if "."	
				drop ck_02-ck_05 		
				reshape wide m_wage f_wage f_mis m_mis, i(community) j(ck_01)
				forvalues i = 1/15 {
					replace m_wage`i' = . if m_mis`i' == 1
					replace f_wage`i' = . if f_mis`i' == 1				
				}
				drop f_mis* m_mis*
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
				ren (m_wage6 f_wage6) (m_wage6a f_wage6a)
					ren (m_wage7 f_wage7) (m_wage6 f_wage6)
					ren (m_wage8 f_wage8) (m_wage7 f_wage7)
					ren (m_wage9 f_wage9) (m_wage8 f_wage8)
					ren (m_wage10 f_wage10) (m_wage9 f_wage9)
					ren (m_wage11 f_wage11) (m_wage10 f_wage10)
					ren (m_wage12 f_wage12) (m_wage11 f_wage11)
					ren (m_wage13 f_wage13) (m_wage12 f_wage12)
					ren (m_wage14 f_wage14) (m_wage13 f_wage13)
					ren (m_wage15 f_wage15) (m_wage14 f_wage14)
				label variable m_wage6 "normal wage+meal taka/day, applying fert/pest"
				label variable f_wage6 "normal wage+meal taka/day, applying fert/pest"
				label variable m_wage6a "normal wage+meal taka/day, apply guti urea"
				label variable f_wage6a "normal wage+meal taka/day, apply guti urea"
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
				save "$temp\150_r3_com_mod_ck_edit19.dta", replace
		 * Community file 2019 - k1 (unique "community")
			use "$BIHS_19c\151_r3_com_mod_k1.dta", replace		
				ren k1_02 price
				reshape wide price, i(comm) j(k1_01)
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
					save "$temp\151_r3_com_mod_k1_edit19.dta", replace
		 * Community file 2019 - k2 (unique "community") - Non-food prices
			//use "$BIHS_19c\152_r3_com_mod_k2.dta", replace
		 * Community file 2019 - l1 (unique "community") - Detail on seed suppliers
			//use "$BIHS_19c\153_r3_com_mod_l1.dta", replace			
		 * Community file 2019 - l1_20 (unique "community") - Seed pricing
			//use "$BIHS_19c\154_r3_com_mod_l1_20.dta", replace						
		 * Community file 2019 - l2 (unique "community") - Fertilizer dealer detail
			//use "$BIHS_19c\155_r3_com_mod_l2.dta", replace			
		 * Community file 2019 - l2_16 (unique "community") - fertilizer pricing
			//use "$BIHS_19c\156_r3_com_mod_l2_16.dta", replace

	** Merge 2019 Community-level Files		
		use "$BIHS_19c\140_r3_com_mod_ca_1.dta", replace	  
			merge 1:1 community_id using "$BIHS_19c\141_r3_com_mod_ca_2.dta"
			drop _merge
			merge 1:1 community_id using "$temp\142_r3_com_mod_cb_1_edit19.dta"
			drop _merge
			merge 1:1 community_id using "$BIHS_19c\143_r3_com_mod_cb_2.dta"
			drop _merge
			merge 1:1 community_id using "$BIHS_19c\144_r3_com_mod_cc.dta"
			drop _merge
			merge 1:1 community_id using "$temp\145_r3_com_mod_cd_edit19.dta"
			drop _merge
			merge 1:1 community_id using "$BIHS_19c\146_r3_com_mod_ce.dta"
			drop _merge
			merge 1:1 community_id using "$temp\149_r3_com_mod_ci_edit19.dta"
			drop _merge
			merge 1:1 community_id using "$temp\150_r3_com_mod_ck_edit19.dta"
			drop _merge
			merge 1:1 community_id using "$temp\151_r3_com_mod_k1_edit19.dta"
			drop _merge
			gen WAVE = 2019 
		save "$temp\CommM3.dta", replace

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		