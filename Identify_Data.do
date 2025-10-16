**********************
** IDENTIFYING DATA ** Only exists as a sandbox to id stableABC datasets
**********************
clear all

* Globals
global folder7 "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 7 - Identifying Data"
global folderc "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars"

***************************
** Identify 3 year panel ** stable12 households
***************************
	* Fetch data
		use "$folder7\Step7a_data.dta", replace // the XYE dataset (no ca01)
	* stable123/stable12: all with XYE, not tracked, unstable
		// keep if WAVE != 2019
		keep if mid != .
			//tab stable123 WAVE
			tab stable12 WAVE
	* stableHH	(can't move, must be stable)
		
	* all with XYCE	(not stable, can move)
	

** Code in PowerPoint
	* Quick fixes
		drop if mid == . // using (7a) dataset
	/* HH: Demographics of Primary Respondent
	foreach i in 2011 2015 2019 {
		tab b1_01 if WAVE == `i'
	} 
	tabstat b1_02, statistic(mean sd) by(WAVE)
	tabstat b1_03, statistic(mean sd) by(WAVE)
	foreach i in 2011 2015 2019 {
		tab b1_04 if WAVE == `i'
		tab b1_04a if WAVE == `i'
		tab b1_05 if WAVE == `i'
		tab b1_06 if WAVE == `i'
		tab b1_07 if WAVE == `i'
		tab b1_08 if WAVE == `i'
		tab b1_09 if WAVE == `i'
	} 
	sum b1_04b if WAVE == 2015
	sum b1_04b if WAVE == 2019
	*/
	
	/* HH: Demographics of Primary Respondent (labor1)
		foreach i in 2011 2015 2019 {
			tab b1_10 if WAVE == `i'
			tab b1_11 if WAVE == `i'
			tab b1_12 if WAVE == `i'
			tab b1_13 if WAVE == `i'
		}
	*/
	
	/* HH: Demographics of Primary Respondent (labor2)
		foreach i in 2011 2015 2019 {
			tab c01 if WAVE == `i'
			tab c05 if WAVE == `i'
		}
			tabstat c07_a , by(WAVE) statistic(mean sd n)
			tabstat c08_a , by(WAVE) statistic(mean sd n)	
	*/
	
	/* HH: Demographics of Primary Respondent (labor3)
			tabstat c10 , by(WAVE) statistic(mean sd n)
			tabstat c11 , by(WAVE) statistic(mean sd n)
			tab c12 WAVE
			tabstat c13_a c14_a, by(WAVE) stat(mean sd)
	*/
	
	/* HH: Household Assets and Savings (saving1)
		tabstat c10 , by(WAVE) statistic(mean sd n)
		tabstat c11 , by(WAVE) statistic(mean sd n)
		tab c12 WAVE
		tabstat d2_10_a, by(WAVE) stat(mean sd p10 p25 p90 max)
		tab e02_a if WAVE == 2011
		tab e02_a if WAVE == 2015
		tab e02_a if WAVE == 2019
	*/
	
	/* HH: Household Assets and Savings (saving2)
		tabstat d2_10_a, by(WAVE) stat(mean sd p10 p25 p90)
		tab e02_a WAVE
		tab e06_a WAVE 
	*/
	
	/* HH: Household Loans
		foreach i in 2011 2015 2019 {
			tab f01_a if WAVE == `i'
			tab f02_min if WAVE == `i'
		}
		tab f06_a WAVE		
		tabstat f07_a, by(WAVE) stat(mean sd p10 p25 p90 n) // (4226 and 4416)
		tabstat f09_a, by(WAVE) stat(mean sd p10 p25 p90 n) // (4226 and 4416)
	*/
	
	/* HH: Household Landholdings
		tabstat g02_a, by(WAVE) stat(mean sd p10 p25 p90 n) 
		tabstat g03_a, by(WAVE) stat(mean sd p10 p25 p90 n)
		tabstat g04_a, by(WAVE) stat(mean sd p10 p25 p90 n)
		tabstat g07_a, by(WAVE) stat(mean sd p10 p25 p90 n)
	*/
	
	/* HH: Household Planting
		tabstat h1_03_a if h1_03_a !=0 , by(WAVE) stat(mean sd n p10 p25 p90)
		tab h1_03_a WAVE if h1_03_a < 10
		tabstat h1_06_a if h1_06_a !=0 , by(WAVE) stat(mean sd n p10 p25 p90)
		tabstat h1_07, by(WAVE) stat(mean sd)
		tabstat h1_08, by(WAVE) stat(mean sd)
	*/
	
	/* HH: Household Agricultural Inputs Numbers
		tabstat h2_05_a if h2_05_a !=0, by(WAVE) stat(mean sd n p10 p90)
		tabstat h3_10_a if h3_10_a !=0, by(WAVE) stat(mean sd n p10 p90)
		tabstat h3_11_a if h3_11_a !=0, by(WAVE) stat(mean sd n p10 p90)
	*/
				
	/* HH: Household Machinery Use - Land Preparation 
		tabstat h4_04_a if h4_04_a !=0, by(WAVE) stat(mean sd n)
		tabstat h4_05_a if h4_05_a !=0, by(WAVE) stat(mean sd n)
		tabstat h4_06_a if h4_06_a !=0, by(WAVE) stat(mean sd n)
		tabstat h4_07_a if h4_07_a !=0, by(WAVE) stat(mean sd n)
		tabstat h4_08_a if h4_08_a !=0, by(WAVE) stat(mean sd n)
		tabstat h4_09_a if h4_09_a !=0, by(WAVE) stat(mean sd n)
		tabstat h4_10_a if h4_10_a !=0, by(WAVE) stat(mean sd n)
	*/
	
	/* HH: Fertilizer Types
		tab h7_npks_br WAVE
		tab h7_npks_b1 WAVE
		tab h7_npks_b2 WAVE
		tab h7_DAP_br WAVE
		tab h7_DAP_b1 WAVE
		tab h7_DAP_b2 WAVE
		tab h7_urea_br WAVE
		tab h7_urea_b1 WAVE
		tab h7_urea_b2 WAVE
	*/
	
	/* HH: Agricultural Rentals/Purchases
		tab h8_01 WAVE
		tab h8_02 WAVE
		tab h8_03 WAVE
		tab h8_04 WAVE
	*/
	
	/* HH: Expenditures
		tabstat pc_expm pc_foodxm pc_nonfxm, by(WAVE) stat(mean sd n) notot
		graph bar pc_expm_real_gen pc_foodxm_real_gen pc_nonfxm_real_gen ///
			if ca07 != 0, title("Pooled Real Expenditures Across Rounds") over(WAVE)
		
		ssc install egenmore
		egen quintiles = xtile(pc_expm_real_gen), by(WAVE) nq(5)

		
	
	*/
	
	/* Community statistics
		use "$folderc\CommVars", replace
			tab vcode_n WAVE
			keep if ca07 != .
			tabstat ca02 ca03 if WAVE == 2011, stat(mean sd n) by(ca07)
			tabstat ca02 ca03 if WAVE == 2015, stat(mean sd n) by(ca07)
			tabstat ca02 ca03 if WAVE == 2019, stat(mean sd n) by(ca07)
	* C: Community Endowments
		use "$folderc\CommVars", replace
		keep if ca07 != .
		* Continuing - road surfaces
			* Main type
				foreach i in 10 20 30 40 50 55 60 {
					tab cb08 if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
				tab cb08 if WAVE == 2019 & ca07 == `i'				
			}
			* Passable WITHIN village
				foreach i in 10 20 30 40 50 55 60 {
					tab cb10 if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab cb10 if WAVE == 2019 & ca07 == `i'				
				}
			* Passable TO village
				foreach i in 10 20 30 40 50 55 60 {
					tab cb12 if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab cb12 if WAVE == 2019 & ca07 == `i'				
				}
		* Continuing - main mode of transportation
				foreach i in 10 20 30 40 50 55 60 {
					tab cb13 if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab cb13 if WAVE == 2019 & ca07 == `i'				
				}
		* Continuing - public goods at community level, non-agricultural
			* Market avail
				foreach i in 10 20 30 40 50 55 60 {
					tab market_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab market_avail if WAVE == 2019 & ca07 == `i'				
				}
			* Bazaar avail
				foreach i in 10 20 30 40 50 55 60 {
					tab bazaar_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab bazaar_avail if WAVE == 2019 & ca07 == `i'				
				}		
			* Telephone available
				foreach i in 10 20 30 40 50 55 60 {
					tab teleph_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab teleph_avail if WAVE == 2019 & ca07 == `i'				
				}	
			* Internet available
				foreach i in 10 20 30 40 50 55 60 {
					tab internet_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab internet_avail if WAVE == 2019 & ca07 == `i'				
				}
			* Commercial bank available
				foreach i in 10 20 30 40 50 55 60 {
					tab commbank_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab commbank_avail if WAVE == 2019 & ca07 == `i'				
				}							
			* Fertilizer depot
				foreach i in 10 20 30 40 50 55 60 {
					tab fert_depot_avail  if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab fert_depot_avail  if WAVE == 2019 & ca07 == `i'				
				}							
			* Local supply depot
				foreach i in 10 20 30 40 50 55 60 {
					tab local_supply_depot_avail if WAVE == 2011 & ca07 == `i'	
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab local_supply_depot_avail if WAVE == 2019 & ca07 == `i'		
				}				
			* Grain storage 
				foreach i in 10 20 30 40 50 55 60 {
					tab grain_storage_avail if WAVE == 2011 & ca07 == `i'			
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab grain_storage_avail if WAVE == 2019 & ca07 == `i'	
				}				
			* Livestock feed
				foreach i in 10 20 30 40 50 55 60 {
					tab livestock_feed_avail if WAVE == 2011 & ca07 == `i'			
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab livestock_feed_avail if WAVE == 2019 & ca07 == `i'			
				}				
			* Vet available
				foreach i in 10 20 30 40 50 55 60 {
					tab vet_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab vet_avail if WAVE == 2019 & ca07 == `i'				
				}				
		* Continuing - medical services
			priv_clin_avail gov_clin_avail pharma_avail
			* Private clinic	
				foreach i in 10 20 30 40 50 55 60 {
					tab priv_clin_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab priv_clin_avail if WAVE == 2019 & ca07 == `i'				
				}				
			* Government clinic
				foreach i in 10 20 30 40 50 55 60 {
					tab gov_clin_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab gov_clin_avail if WAVE == 2019 & ca07 == `i'				
				}	
			* Pharmacy 
				foreach i in 10 20 30 40 50 55 60 {
					tab pharma_avail if WAVE == 2011 & ca07 == `i'				
				}
				foreach i in 10 20 30 40 50 55 60 {
					tab pharma_avail if WAVE == 2019 & ca07 == `i'				
				}			
		*/

	* Shocks - T1 module, only stable units (no overhang 2019 villages 318-442)
		* Fetch data
			use "$folder7\Step7a_data.dta", replace // the XYE dataset (no ca01)
			* stable123/stable12: all with XYE, not tracked, unstable
			keep if mid != .
		
		/* SHOCKS1 - Count
		
			* Set 1: 2011/2015 - Shock counts
				** 2011 - 5 year
					tab shock_count_5y if WAVE == 2011 & stable123 == 1
					tab shock_count_5y if WAVE == 2011 & stableHH  == 1
					tab shock_count_5y if WAVE == 2011 
				* 2015 - 5 year
					tab shock_count_5y if WAVE == 2015 & stable123 == 1
					tab shock_count_5y if WAVE == 2015 & stableHH  == 1
					tab shock_count_5y if WAVE == 2015
					
				** 2011 - 2 year
					tab shock_count_2y if WAVE == 2011 & stable123 == 1
					tab shock_count_2y if WAVE == 2011 & stableHH  == 1
					tab shock_count_2y if WAVE == 2011 
				* 2015 - 2 year
					tab shock_count_2y if WAVE == 2015 & stable123 == 1
					tab shock_count_2y if WAVE == 2015 & stableHH  == 1
					tab shock_count_2y if WAVE == 2015	
				
				** 2011 - Ongoing
					tab shock_count_ONG if WAVE == 2011 & stable123 == 1
					tab shock_count_ONG if WAVE == 2011 & stableHH  == 1
					tab shock_count_ONG if WAVE == 2011 
				* 2015 - Ongoing
					tab shock_count_ONG if WAVE == 2015 & stable123 == 1
					tab shock_count_ONG if WAVE == 2015 & stableHH  == 1
					tab shock_count_ONG if WAVE == 2015					
				
			* Set 2: 2019	
				** 2011 - since midline 2015
					tab shock_count_ML if WAVE == 2019 & stable123 == 1
					tab shock_count_ML if WAVE == 2019 & stableHH  == 1
					tab shock_count_ML if WAVE == 2019 
				* 2015 - 1 year
					tab shock_count_1y if WAVE == 2019 & stable123 == 1
					tab shock_count_1y if WAVE == 2019 & stableHH  == 1
					tab shock_count_1y if WAVE == 2019
			*/
				
		/* SHOCKS2 - binary
			* Ag Shocks - binary
				* 2011
					tab ag_shocks_5y if WAVE == 2011 & stable123 == 1
					tab ag_shocks_5y if WAVE == 2011 & stableHH  == 1
					tab ag_shocks_5y if WAVE == 2011 
				* 2015
					tab ag_shocks_5y if WAVE == 2015 & stable123 == 1
					tab ag_shocks_5y if WAVE == 2015 & stableHH  == 1
					tab ag_shocks_5y if WAVE == 2015
			* Weather Shocks - binary
				* 2011
					tab weather_shocks_5y if WAVE == 2011 & stable123 == 1
					tab weather_shocks_5y if WAVE == 2011 & stableHH  == 1
					tab weather_shocks_5y if WAVE == 2011 
				* 2015
					tab weather_shocks_5y if WAVE == 2015 & stable123 == 1
					tab weather_shocks_5y if WAVE == 2015 & stableHH  == 1
					tab weather_shocks_5y if WAVE == 2015		
			* Health Shocks - binary
				* 2011
					tab health_shocks_5y if WAVE == 2011 & stable123 == 1
					tab health_shocks_5y if WAVE == 2011 & stableHH  == 1
					tab health_shocks_5y if WAVE == 2011 
				* 2015
					tab health_shocks_5y if WAVE == 2015 & stable123 == 1
					tab health_shocks_5y if WAVE == 2015 & stableHH  == 1
					tab health_shocks_5y if WAVE == 2015 		
		*/
		
		/* SHOCKS3 - Incidence of shocks by category and district
				* 2011/2015 shocks
					foreach i in health weather ag { 
							tabstat `i'_shocks_5y `i'_shocks_2y /// 
							`i'_shocks_ONG if WAVE == 2011, by(ca07)
					}
					foreach i in health weather ag { 
							tabstat `i'_shocks_5y `i'_shocks_2y /// 
							`i'_shocks_ONG if WAVE == 2015, by(ca07)
					}
				* 2019 shocks
					foreach i in health weather ag { 
							tabstat `i'_shocks_ML `i'_shocks_1y /// 
							if WAVE == 2019, by(ca07)
					}				
			*/
						
		/* COPING1 - Coping Strategies
			** 2011/2015
				tab coping_count_5y if WAVE == 2011 & stable123 == 1
				tab coping_count_5y if WAVE == 2011 & stableHH  == 1
				tab coping_count_5y if WAVE == 2011 
			* Distributions of coping strategies employed, 2011
			twoway (histogram coping_count_5y if WAVE==2011 & coping_count_5y != 0 , color(red%30)) ///
				(histogram coping_count_2y if WAVE==2011 & coping_count_2y != 0 ,color(green%30)) ///
				(histogram coping_count_ONG if WAVE==2011 & coping_count_ONG != 0 ,color(blue%30)) ///
				, legend(order(1 "5 year" 2 "2 year" 3 "Ongoing")) ///
				title("Coping strategies across frames of reference, 2011")	
			* Distributions of coping strategies employed, 2015			
			twoway (histogram coping_count_5y if WAVE==2015 & coping_count_5y != 0 , color(red%30)) ///
				(histogram coping_count_2y if WAVE==2015 & coping_count_2y,color(green%30)) ///
				(histogram coping_count_ONG if WAVE==2015 & coping_count_ONG,color(blue%30)) ///
				, legend(order(1 "5 year" 2 "2 year" 3 "Ongoing")) ///
				title("Coping strategies across frames of reference, 2015")
			* Distributions of coping strategies employed, 2015			
			twoway (histogram coping_count_ML if WAVE==2019 & coping_count_ML, color(red%30)) ///
				(histogram coping_count_1y if WAVE==2019  & coping_count_1y,color(green%30)) ///
				, legend(order(1 "Since Midline" 2 "1 year")) ///
				 title("Coping strategies across frames of reference, 2019")
			* Coping rate tables
				* 2011/2015 coping by NUMBER OF COPING STRATEGIES EMPLOYED
					tabstat coping_count_5y coping_count_2y coping_count_ONG if WAVE == 2011, by(ca07)
					tabstat coping_count_5y coping_count_2y coping_count_ONG if WAVE == 2015, by(ca07)
				* 2019 coping by NUMBER OF COPING STRATEGIES EMPLOYED
					tabstat coping_count_ML coping_count_1y if WAVE == 2019, by(ca07)
			*/		
		** TO DO - GENERATE shocks overall t-score (bysort WAVE)
		** TO DO - GENERATE shocks within WAVE and DIVISION (div/ca07)	

		* Remittances
		misstable sum more_remit_shock any_remit1 any_remit2 ///
			domest_remit_b foreig_remit_b total_remit_q ///
			remit_out_count remit_out_foreig remit_out_domest
				
		* Access to government programs
		sum ngo*

