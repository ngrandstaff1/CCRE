*******************************************
** COMMUNITY VARIABLES - BROADLY DEFINED ** 2011
*******************************************
clear all

* Set globals for data
	global BIHS_11c "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_11"	
	global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars\Community Temp Files"
	global folderc "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars"
	global new2011 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_11\New Comm2011"
	
** Community Data Merge
		* BIHS 2011
			* Community file 2011 - ca/cb/cc/ce (includes sl)
			use "$new2011\identity_other_001.dta"
			save "$BIHS_11c\001_mod_ca_cb_cc_ce_community_EDIT.dta", replace	
			* Community file 2011 - ca08-ca011 (includes sl) - who was contacted
				//use "$BIHS_11c\002_mod_ca08-ca011_community.dta"
			* Community file 2011 - cb02-cb07 (includes sl)
			use "$new2011\module_cb.dta", replace
				* Reshape and go
				reshape wide cb03 cb04 cb05 cb06 cb07, i(sl) j(cb02)
					forvalues i = 1/17 {
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
				ren (cb0416 cb0616 cb0716)(livestock_feed_avail ///
					livestock_feed_lat livestock_feed_lon)					
				ren (cb0417 cb0617 cb0717)(vet_avail vet_lat vet_lon)					
				drop cb*		
				save "$temp\003_mod_cb02-cb07_community_edit11.dta", replace
				* Community file 2011 - cd (inlcudes sl)
			use "$BIHS_11c\004_mod_cd_community.dta", replace
				* Reshape and go
				reshape wide cd02 cd03 cd04 cd05 cd06, i(sl) j(cd01)
				drop cd02* cd04*
				ren (cd031 cd051 cd061)(priv_clin_avail priv_clin_lon priv_clin_lat)
				ren (cd032 cd052 cd062)(gov_clin_avail gov_clin_lon gov_clin_lat)
				ren (cd033 cd053 cd063)(pharma_avail pharma_lon pharma_lat)
				save "$temp\004_mod_cd_community_edit11.dta", replace			
			* Community file 2011 - cf (includes sl) - EDUCATION INSTITUTIONS
				//use "$BIHS_11\005_mod_cf_community.dta"
			* Community file 2011 - cg (includes sl) NGO Presence
				//use "$BIHS_11\006_mod_cg_community.dta"			
			* Community file 2011 - ci (includes sl) Social Safety Net
			use "$new2011\module_ci.dta", replace	
				* Messy recode
				reshape wide c103, i(sl) j(c101)
				label variable c1031 ">0p village benefitted from: ananda school"
				label variable c1032 ">0p village benefitted from: stipend for primary students"
				label variable c1033 ">0p village benefitted from: school feeding program"
				label variable c1034 ">0p village benefitted from: stipend for dropout students"		
				label variable c1035 ">0p village benefitted from: stipend for secondary and higher second"
				label variable c1036 ">0p village benefitted from: stipend for poor boys in secondary school"
				label variable c1037 "stipend for disabled students"
				label variable c1038 "old age allowance"	
				label variable c1039 "allowances for distressed cultural persons"
				label variable c10310 "allowances for beneficiaries in ctg hil"		
				label variable c10311 ">0p village benefitted from: allowances for the widowed deserted an"		
				label variable c10312 ">0p village benefitted from: allowances for financially insolvent"		
				label variable c10313 ">0p village benefitted from: maternity allowances prog. for poor"
				label variable c10314 ">0p village benefitted from: maternal health voucher scheme"				
				label variable c10316 ">0p village benefitted from: honorarium for insolvent freedom fighters"	
				label variable c10315 ">0p village benefitted from: honorarium for injured freedom fighters"		
				label variable c10317 ">0p village benefitted from: gratuitous relief (cash)"					
				label variable c10318 ">0p village benefitted from: gratuitious relief (gr)- food"				
				label variable c10319 ">0p village benefitted from: general relief activities"				
				label variable c10320 ">0p village benefitted from: cash for work" 		
				label variable c10321 ">0p village benefitted from: agricultural rehabilitation"				
				label variable c10322 ">0p village benefitted from: subsidy for open market sales"
				label variable c10323 ">0p village benefitted from: vulnerable group development"				
				label variable c10324 ">0p village benefitted from: vgd-up (8 dist. on monga area)"		
				label variable c10325 ">0p village benefitted from: vulnerable group feeding (vgf)"				
				label variable c10326 ">0p village benefitted from: test relief (tr) food"				
				label variable c10327 ">0p village benefitted from: food assitance in ctg-hill tracts area"	
				label variable c10328 ">0p village benefitted from: food for work (ffw)"				
				label variable c10329 ">0p village benefitted from: special fund for employment generation"	
				label variable c10330 ">0p village benefitted from: fund for the welfare of acid burnt and"		
				label variable c10331 ">0p village benefitted from: 100 days employment scheme"				
				label variable c10332 ">0p village benefitted from: rural empl opportunities for prot"			
				label variable c10333 ">0p village benefitted from: rural employment and rural maitenence"
				label variable c10334 ">0p village benefitted from: community nutrition program"
				label variable c10335 ">0p village benefitted from: char livelihood program"
				label variable c10336 ">0p village benefitted from: shouhardo program (care)"		
				label variable c10337 ">0p village benefitted from: accommodation (poverty alleviation & re"
				label variable c10338 ">0p village benefitted from: Housing Support"					
				label variable c10339 ">0p village benefitted from: tup (brac)"
				label variable c10340 ">0p village benefitted from: one house one farm"			
				label variable c10341 ">0p village benefitted from: improving maternal and child nutrition"
				label variable c10342 ">0p village benefitted from: enhancing resilience to disasters and t"		
				label variable c10343 ">0p village benefitted from: other (specify)"
				forvalues i = 1/43 {
					ren c103`i' ngo_`i'
				}
				save "$temp\007_mod_ci_community_edit11.dta", replace	
	 * Community file 2011 - ck (includes sl)
		use "$new2011\module_ck.dta", replace
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
			reshape wide m_wage f_wage, i(sl) j(ag_labor)					
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
			save "$temp\008_mod_ck_community_edit11.dta", replace
	
	** Merge 2011 Community-level Files
		use "$BIHS_11c\001_mod_ca_cb_cc_ce_community_EDIT.dta", replace		
		merge 1:1 sl using "$temp\003_mod_cb02-cb07_community_edit11.dta"
		drop _merge
		merge 1:1 sl using "$temp\004_mod_cd_community_edit11.dta"
		drop _merge
		merge 1:1 sl using "$temp\007_mod_ci_community_edit11.dta"
		drop _merge
		merge 1:1 sl using "$temp\008_mod_ck_community_edit11.dta"
		drop _merge
		gen WAVE = 2011
		
		* Generate vcode0
		tostring ca01, gen(ca01_0)
		gen zeros = "00"
		egen vcode = concat(village zeros ca01_0)
		destring vcode, gen(vcode0)
		format vcode0 %16.0f
		
		* Save file
		save "$temp\CommM1.dta", replace
		
		
		
		

		
	 

	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	