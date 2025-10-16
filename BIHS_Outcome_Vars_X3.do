///////////////////////////////////////////////////////////
///  OUTCOME VARIABLES HARMONIZATION ACROSS BIHS WAVES  ///
///////////////////////////////////////////////////////////
clear all 

*--------------------*
*  Wave Directories  *
*--------------------*
	global code "C:\Users\ngran\Dropbox\JHODD - CCRE\Code"
	global BIHS "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data"
		* Directory for 2011 *
			global BIHS_11 "$BIHS\BIHS_11"
		* Directory for 2015 *
			global BIHS_15 "$BIHS\BIHS_15"
		* Directory for 2019 *
			global BIHS_19m "$BIHS\BIHS_19\BIHSRound3\Male"
			global BIHS_19f "$BIHS\BIHS_19\BIHSRound3\Female"
			global BIHS_19comm "$BIHS\BIHS_19\BIHSRound3\Community"
	* Directory for Step 3 DTAs
		global S3_DTA "$code\Step 3 - Prep Outcome Vars\Step 3 DTAs" 

	
******************************************************
** HH FCS, HDDS, and Food Security Questions - BIHS **
******************************************************
	* WAVE 1: 2010-2011
	use "$BIHS_11\051_mod_x3_female.dta", replace
		* FCS11 Addition
			egen FCSst_max = rowmax(x3_07_1 x3_07_2 x3_07_4)          // staples
			egen FCSpu_max = rowmax(x3_07_7 x3_07_16)                 // pulses
			egen FCSve_max = rowmax(x3_07_3 x3_07_5)                  // vege
			egen FCSme_max = rowmax(x3_07_8 x3_07_10 x3_07_11 x3_07_12) // meats
			gen FCSst_opt=x3_07_1 +x3_07_2 +x3_07_4 // staples
				replace FCSst_opt = 7 if FCSst_opt > 7				
			gen FCSpu_opt= x3_07_7 + x3_07_16 		// pulses
				replace FCSpu_opt = 7 if FCSpu_opt > 7		
			gen FCSve_opt= x3_07_3 + x3_07_5 		// vegetables
				replace FCSve_opt = 7 if FCSve_opt > 7		
			gen FCSme_opt= x3_07_3 + x3_07_5 		// meats
				replace FCSme_opt = 7 if FCSme_opt > 7						
			gen FCS_max = (2*(FCSst_max)) + 		/// Main Staples
						  (3*(FCSpu_max)) + 		/// Pulses
						  (1*(FCSve_max)) +  		/// Vegetables
						  (1*(x3_07_6))   +         /// Fruit
						  (4*(FCSme_max)) + 		/// Meat
						  (0.5*(x3_07_9)) +         /// Sugar
						  (0.5*(x3_07_14)) +        /// Oil
						  (4*(x3_07_9))              // Milk				
			gen FCS_opt = (2*(FCSst_opt))+(3*(FCSpu_opt))+(1*(FCSve_opt))+ ///	
			(1*(x3_07_6))+(4*(FCSme_opt))+(0.5*(x3_07_9))+(0.5*(x3_07_14))+ ///
			(4*(x3_07_9))			
				drop x3_07_* x3_08_*
				drop FCSst_max FCSpu_max FCSve_max FCSme_max FCSst_opt ///
					FCSpu_opt FCSve_opt FCSme_opt
			save "$S3_DTA\BIHS_y_W1.dta", replace
									
	* WAVE 2: 2015-2016
	use "$BIHS_15\068_r2_mod_x3_female.dta", replace
		* FCS15 Addition
			egen FCSst_max = rowmax(x3_07_1 x3_07_2 x3_07_4)          // staples
			egen FCSpu_max = rowmax(x3_07_7 x3_07_16)                 // pulses
			egen FCSve_max = rowmax(x3_07_3 x3_07_5)                  // vege
			egen FCSme_max = rowmax(x3_07_8 x3_07_10 x3_07_11 x3_07_12) // meats
			gen FCSst_opt=x3_07_1 +x3_07_2 +x3_07_4 // staples
				replace FCSst_opt = 7 if FCSst_opt > 7				
			gen FCSpu_opt= x3_07_7 + x3_07_16 		// pulses
				replace FCSpu_opt = 7 if FCSpu_opt > 7		
			gen FCSve_opt= x3_07_3 + x3_07_5 		// vegetables
				replace FCSve_opt = 7 if FCSve_opt > 7		
			gen FCSme_opt= x3_07_3 + x3_07_5 		// meats
				replace FCSme_opt = 7 if FCSme_opt > 7						
			gen FCS_max = (2*(FCSst_max)) + 		/// Main Staples
						  (3*(FCSpu_max)) + 		/// Pulses
						  (1*(FCSve_max)) +  		/// Vegetables
						  (1*(x3_07_6))   +         /// Fruit
						  (4*(FCSme_max)) + 		/// Meat
						  (0.5*(x3_07_9)) +         /// Sugar
						  (0.5*(x3_07_14)) +        /// Oil
						  (4*(x3_07_9))              // Milk				
			gen FCS_opt = (2*(FCSst_opt))+(3*(FCSpu_opt))+(1*(FCSve_opt))+ ///	
			(1*(x3_07_6))+(4*(FCSme_opt))+(0.5*(x3_07_9))+(0.5*(x3_07_14))+ ///
			(4*(x3_07_9))			
				drop x3_07_* x3_08_*
				drop FCSst_max FCSpu_max FCSve_max FCSme_max FCSst_opt ///
					FCSpu_opt FCSve_opt FCSme_opt   
		* HDDS15---09 (<2 year old) ---Addition
			forvalues i = 1/17 {
				replace x3_09_`i' = . if x3_09_`i' == 9
				replace x3_09_`i' = 0 if x3_09_`i' == 2
			}
			egen HDDce_max = rowmax(x3_09_1 x3_09_2 x3_09_4) // cereals			
			egen HDDme_max = rowmax(x3_09_10 x3_09_11 ) // meats			
			egen HDDpu_max = rowmax(x3_09_7 x3_09_16 )  // pulses
			egen HDDmi_max = rowmax(x3_09_15 x3_09_17 ) // miscellaneous
			gen HDD_09 = (HDDce_max)+(x3_09_3)+(x3_09_5)+(x3_09_6)+  /// 
						(HDDme_max)+(x3_09_8)+(x3_09_12)+(HDDpu_max) + ///
						(x3_09_9)+(x3_09_13)+(x3_09_14)+(HDDmi_max) 	
			drop HDDce_max HDDme_max HDDpu_max HDDmi_max x3_09_*
		* HDDS15---10 (<2 year old's mother)---Addition		
			forvalues i = 1/17 {
				replace x3_10_`i' = . if x3_10_`i' == 9
				replace x3_10_`i' = 0 if x3_10_`i' == 2
			}
			egen HDDce_max = rowmax(x3_10_1 x3_10_2 x3_10_4) // cereals			
			egen HDDme_max = rowmax(x3_10_10 x3_10_11 ) // meats			
			egen HDDpu_max = rowmax(x3_10_7 x3_10_16 )  // pulses
			egen HDDmi_max = rowmax(x3_10_15 x3_10_17 ) // miscellaneous
			gen HDD_10 = (HDDce_max)+(x3_10_3)+(x3_10_5)+(x3_10_6)+  /// 
						(HDDme_max)+(x3_10_8)+(x3_10_12)+(HDDpu_max) + ///
						(x3_10_9)+(x3_10_13)+(x3_10_14)+(HDDmi_max)
			drop HDDce_max HDDme_max HDDpu_max HDDmi_max x3_10_*
		* HDDS15---11 (14-49 y.o. women)---Addition		
			forvalues i = 1/17 {
				replace x3_11_`i' = . if x3_11_`i' == 9
				replace x3_11_`i' = 0 if x3_11_`i' == 2
			}
			egen HDDce_max = rowmax(x3_11_1 x3_11_2 x3_11_4) // cereals			
			egen HDDme_max = rowmax(x3_11_10 x3_11_11 ) // meats			
			egen HDDpu_max = rowmax(x3_11_7 x3_11_16 )  // pulses
			egen HDDmi_max = rowmax(x3_11_15 x3_11_17 ) // miscellaneous
			gen HDD_11 = (HDDce_max)+(x3_11_3)+(x3_11_5)+(x3_11_6)+  /// 
						(HDDme_max)+(x3_11_8)+(x3_11_12)+(HDDpu_max) + ///
						(x3_11_9)+(x3_11_13)+(x3_11_14)+(HDDmi_max)
			drop HDDce_max HDDme_max HDDpu_max HDDmi_max x3_11_*	
		* HDDS15---12 (Other members of HH)---Addition		
			forvalues i = 1/17 {
				replace x3_12_`i' = . if x3_12_`i' == 9
				replace x3_12_`i' = 0 if x3_12_`i' == 2
			}
			egen HDDce_max = rowmax(x3_12_1 x3_12_2 x3_12_4) // cereals			
			egen HDDme_max = rowmax(x3_12_10 x3_12_11 ) // meats			
			egen HDDpu_max = rowmax(x3_12_7 x3_12_16 )  // pulses
			egen HDDmi_max = rowmax(x3_12_15 x3_12_17 ) // miscellaneous
			gen HDD_12 = (HDDce_max)+(x3_12_3)+(x3_12_5)+(x3_12_6)+  /// 
						(HDDme_max)+(x3_12_8)+(x3_12_12)+(HDDpu_max) + ///
						(x3_12_9)+(x3_12_13)+(x3_12_14)+(HDDmi_max)
			drop HDDce_max HDDme_max HDDpu_max HDDmi_max x3_12_*
			save "$S3_DTA\BIHS_y_W2.dta", replace

	* WAVE 3: 2018-2019 (X31 - for 01-06) - Food security questions
	use "$BIHS_19f\108_bihs_r3_female_mod_x31.dta", replace				

	* WAVE 3: 2018-2019 (X32 - for 07-12)
	use "$BIHS_19f\109_bihs_r3_female_mod_x32.dta", replace
		* Fixing things
			drop if x3 == .	
			drop flag_x3_11_1 hhid2 round
			ren (x3_07 x3_08 x3_09_1 x3_09_2 x3_09_3 x3_10_1 x3_10_2 x3_10_3 ///
				x3_11_1 x3_11_2 x3_11_3 x3_11_4 x3_11_5 x3_12)(x3_07_ x3_08_ ///
				x3_09_1_ x3_09_2_ x3_09_3_ x3_10_1_ x3_10_2_ x3_10_3_ x3_11_1_ ///
				x3_11_2_ x3_11_3_ x3_11_4_ x3_11_5_ x3_12_)			
			reshape wide x3_07 x3_08 x3_09_1 x3_09_2 x3_09_3 x3_10_1 ///
				x3_10_2 x3_10_3 x3_11_1 x3_11_2 x3_11_3 x3_11_4 ///
				x3_11_5 x3_12, i(a01) j(x3)
		* FCS Fix Wave 3 (max and optimistic)
			egen FCSpu_max=rowmax(x3_07_16 x3_07_17)   // Pulses
			gen FCSpu_opt = x3_07_16+x3_07_17
			egen FCSve_max=rowmax(x3_07_2 x3_07_3 x3_07_5 x3_07_6 x3_07_7) // Veg
			gen FCSve_opt=x3_07_2+x3_07_3+x3_07_5+x3_07_6+x3_07_7 
			egen FCSfr_max = rowmax(x3_07_4 x3_07_8 x3_07_9)   // Fruit
			gen FCSfr_opt=x3_07_4+x3_07_8+x3_07_9
			egen FCSme_max=rowmax(x3_07_10 x3_07_11 x3_07_12 x3_07_13 ///
				x3_07_14 x3_07_15)
			gen FCSme_opt=x3_07_10+x3_07_11+x3_07_12+x3_07_13+x3_07_14+x3_07_15
				replace FCSpu_opt = 7 if FCSpu_opt > 7
				replace FCSve_opt = 7 if FCSve_opt > 7		
				replace FCSfr_opt = 7 if FCSfr_opt > 7	
				replace FCSme_opt = 7 if FCSme_opt > 7		
			gen FCS_max = (2*(x3_07_1)) +    /// Staples				
						  (3*(FCSpu_max)) +  /// Pulses
						  (1*(FCSve_max)) +  /// Vegetables
						  (1*(FCSfr_max)) +  /// Fruit				  
						  (4*(FCSme_max)) +  /// Meat & Fish
						  (0.4*(x3_07_20)) + /// Sugar
						  (0.5*(x3_07_19)) + /// Oil
						  (4*(x3_07_18))      // Milk
			gen FCS_opt = (2*(x3_07_1))+(3*(FCSpu_opt))+(1*(FCSve_opt))+ ///
						 (1*(FCSfr_opt))+(4*(FCSme_opt))+(0.4*(x3_07_20))+ ///
						 (0.5*(x3_07_19))+(4*(x3_07_18))    
			drop x3_07_* x3_08_* FCSpu_max FCSpu_opt FCSve_max FCSve_opt ///
					FCSfr_max FCSfr_opt FCSme_max FCSme_opt				
		* Fixing more things
			forvalues j = 1/25 {
				forvalues i = 1/3 {
					replace x3_09_`i'_`j' = 0 if x3_09_`i'_`j' == 2
					replace x3_10_`i'_`j' = 0 if x3_10_`i'_`j' == 2
					replace x3_11_`i'_`j' = 0 if x3_11_`i'_`j' == 2
				}
			}
		*HDD Fix Wave 3 BY GROUP [09] 
			forvalues i = 1/3 {		
			egen HDDro_max=rowmax(x3_09_`i'_2 x3_09_`i'_3)
			egen HDDve_max=rowmax(x3_09_`i'_5 x3_09_`i'_6 x3_09_`i'_7)			
			egen HDDfr_max=rowmax(x3_09_`i'_4 x3_09_`i'_8 x3_09_`i'_9)			
			egen HDDme_max=rowmax(x3_09_`i'_10 x3_09_`i'_11 x3_09_`i'_12 x3_09_`i'_13)	
			egen HDDpu_max=rowmax(x3_09_`i'_16 x3_09_`i'_17)	
			egen HDDms_max=rowmax(x3_09_`i'_21 x3_09_`i'_22 x3_09_`i'_23 ///
				x3_09_`i'_24 	x3_09_`i'_25)
			drop x3_09_`i'_2 x3_09_`i'_3 x3_09_`i'_5 x3_09_`i'_6 ///
				x3_09_`i'_7 x3_09_`i'_4 x3_09_`i'_8 x3_09_`i'_9 x3_09_`i'_10 ///
				x3_09_`i'_11 x3_09_`i'_12 x3_09_`i'_16 x3_09_`i'_17 ///
				x3_09_`i'_21 x3_09_`i'_22 x3_09_`i'_23 x3_09_`i'_24 ///
				x3_09_`i'_25 x3_09_`i'_13	
			replace x3_09_`i'_1  = 0 if x3_09_`i'_1 == 2  // cereals
			replace x3_09_`i'_14 = 0 if x3_09_`i'_14 == 2 // eggs
			replace x3_09_`i'_15 = 0 if x3_09_`i'_15 == 2 // fish
			replace x3_09_`i'_18 = 0 if x3_09_`i'_18 == 2 // milk
			replace x3_09_`i'_19 = 0 if x3_09_`i'_19 == 2 // oil
			replace x3_09_`i'_20 = 0 if x3_09_`i'_20 == 2 //sugar 
			gen HDD`i'_09 = (x3_09_`i'_1) + /// Cereals
						(HDDro_max) +  /// Roots, tubers
						(HDDve_max) +  /// Vegetables
						(HDDfr_max) +  /// Fruit
						(HDDme_max) +  /// Meat & Poultry
						(x3_09_`i'_14) + /// Eggs
						(x3_09_`i'_15) + /// Fish & Seafood
						(HDDpu_max) +  /// Pulses
						(x3_09_`i'_18) + /// Milk
						(x3_09_`i'_19) + /// Oil				
						(x3_09_`i'_20) + /// Sugar
						(HDDms_max)     // Miscellaneous
			drop HDDro_max HDDve_max HDDfr_max HDDme_max HDDpu_max HDDms_max
			drop x3_09_`i'_1 x3_09_`i'_14 x3_09_`i'_15 x3_09_`i'_18 ///
			x3_09_`i'_19 x3_09_`i'_20
			}		
		*HDD Fix Wave 3 BY GROUP [10]
			forvalues i = 1/3 {		
			egen HDDro_max=rowmax(x3_10_`i'_2 x3_10_`i'_3)
			egen HDDve_max=rowmax(x3_10_`i'_5 x3_10_`i'_6 x3_10_`i'_7)			
			egen HDDfr_max=rowmax(x3_10_`i'_4 x3_10_`i'_8 x3_10_`i'_9)			
			egen HDDme_max=rowmax(x3_10_`i'_10 x3_10_`i'_11 x3_10_`i'_12 x3_10_`i'_13)	
			egen HDDpu_max=rowmax(x3_10_`i'_16 x3_10_`i'_17)	
			egen HDDms_max=rowmax(x3_10_`i'_21 x3_10_`i'_22 x3_10_`i'_23 ///
				x3_10_`i'_24 	x3_10_`i'_25)
			drop x3_10_`i'_2 x3_10_`i'_3 x3_10_`i'_5 x3_10_`i'_6 ///
				x3_10_`i'_7 x3_10_`i'_4 x3_10_`i'_8 x3_10_`i'_9 x3_10_`i'_10 ///
				x3_10_`i'_11 x3_10_`i'_12 x3_10_`i'_16 x3_10_`i'_17 ///
				x3_10_`i'_21 x3_10_`i'_22 x3_10_`i'_23 x3_10_`i'_24 ///
				x3_10_`i'_25 x3_10_`i'_13	
			replace x3_10_`i'_1  = 0 if x3_10_`i'_1 == 2  // cereals
			replace x3_10_`i'_14 = 0 if x3_10_`i'_14 == 2 // eggs
			replace x3_10_`i'_15 = 0 if x3_10_`i'_15 == 2 // fish
			replace x3_10_`i'_18 = 0 if x3_10_`i'_18 == 2 // milk
			replace x3_10_`i'_19 = 0 if x3_10_`i'_19 == 2 // oil
			replace x3_10_`i'_20 = 0 if x3_10_`i'_20 == 2 //sugar 
			gen HDD`i'_10 = (x3_10_`i'_1) + /// Cereals
						(HDDro_max) +  /// Roots, tubers
						(HDDve_max) +  /// Vegetables
						(HDDfr_max) +  /// Fruit
						(HDDme_max) +  /// Meat & Poultry
						(x3_10_`i'_14) + /// Eggs
						(x3_10_`i'_15) + /// Fish & Seafood
						(HDDpu_max) +  /// Pulses
						(x3_10_`i'_18) + /// Milk
						(x3_10_`i'_19) + /// Oil				
						(x3_10_`i'_20) + /// Sugar
						(HDDms_max)     // Miscellaneous
			drop HDDro_max HDDve_max HDDfr_max HDDme_max HDDpu_max HDDms_max
			drop x3_10_`i'_1 x3_10_`i'_14 x3_10_`i'_15 x3_10_`i'_18 ///
			x3_10_`i'_19 x3_10_`i'_20
			}
		*HDD Fix Wave 3 BY GROUP [11] 
			forvalues i = 1/3 {		
			egen HDDro_max=rowmax(x3_11_`i'_2 x3_11_`i'_3)
			egen HDDve_max=rowmax(x3_11_`i'_5 x3_11_`i'_6 x3_11_`i'_7)			
			egen HDDfr_max=rowmax(x3_11_`i'_4 x3_11_`i'_8 x3_11_`i'_9)			
			egen HDDme_max=rowmax(x3_11_`i'_11 x3_11_`i'_11 x3_11_`i'_12 x3_11_`i'_13)	
			egen HDDpu_max=rowmax(x3_11_`i'_16 x3_11_`i'_17)	
			egen HDDms_max=rowmax(x3_11_`i'_21 x3_11_`i'_22 x3_11_`i'_23 ///
				x3_11_`i'_24 	x3_11_`i'_25)
			drop x3_11_`i'_2 x3_11_`i'_3 x3_11_`i'_5 x3_11_`i'_6 ///
				x3_11_`i'_7 x3_11_`i'_4 x3_11_`i'_8 x3_11_`i'_9 x3_11_`i'_11 ///
				x3_11_`i'_11 x3_11_`i'_12 x3_11_`i'_16 x3_11_`i'_17 ///
				x3_11_`i'_21 x3_11_`i'_22 x3_11_`i'_23 x3_11_`i'_24 ///
				x3_11_`i'_25 x3_11_`i'_13	
			replace x3_11_`i'_1  = 0 if x3_11_`i'_1 == 2  // cereals
			replace x3_11_`i'_14 = 0 if x3_11_`i'_14 == 2 // eggs
			replace x3_11_`i'_15 = 0 if x3_11_`i'_15 == 2 // fish
			replace x3_11_`i'_18 = 0 if x3_11_`i'_18 == 2 // milk
			replace x3_11_`i'_19 = 0 if x3_11_`i'_19 == 2 // oil
			replace x3_11_`i'_20 = 0 if x3_11_`i'_20 == 2 //sugar 
			gen HDD`i'_11 = (x3_11_`i'_1) + /// Cereals
						(HDDro_max) +  /// Roots, tubers
						(HDDve_max) +  /// Vegetables
						(HDDfr_max) +  /// Fruit
						(HDDme_max) +  /// Meat & Poultry
						(x3_11_`i'_14) + /// Eggs
						(x3_11_`i'_15) + /// Fish & Seafood
						(HDDpu_max) +  /// Pulses
						(x3_11_`i'_18) + /// Milk
						(x3_11_`i'_19) + /// Oil				
						(x3_11_`i'_20) + /// Sugar
						(HDDms_max)     // Miscellaneous
			drop HDDro_max HDDve_max HDDfr_max HDDme_max HDDpu_max HDDms_max
			drop x3_11_`i'_*
			}
		* Fixing things before looping over [12]
			drop x3_11_*
			forvalues i = 1/25 {
				replace x3_12_`i' = 0 if x3_12_`i' == 2
			}
		*HDD Fix Wave 3 BY GROUP [12] ("rowmin" here bc "No" = 2)
			egen HDDro_max=rowmax(x3_12_2 x3_12_3)
			egen HDDve_max=rowmax(x3_12_5 x3_12_6 x3_12_7)			
			egen HDDfr_max=rowmax(x3_12_4 x3_12_8 x3_12_9)			
			egen HDDme_max=rowmax(x3_12_10 x3_12_11 x3_12_12 x3_12_13)	
			egen HDDpu_max=rowmax(x3_12_16 x3_12_17)	
			egen HDDms_max=rowmax(x3_12_21 x3_12_22 x3_12_23 ///
					x3_12_24 x3_12_25)		
			gen HDD_12 = (x3_12_1)+(HDDro_max)+(HDDve_max)+(HDDfr_max)+ ///
					(HDDme_max)+(x3_12_14)+(x3_12_15)+(HDDpu_max) +  /// 
					(x3_12_18)+(x3_12_19)+(x3_12_20)+(HDDms_max) 
			drop x3_12*	HDDro_max HDDve_max HDDfr_max HDDme_max ///
				HDDpu_max HDDms_max
			save "$S3_DTA\BIHS_y_W3.dta", replace			
	
**************************************
** FOOD SECURITY TRANSITIONS MATRIX ** PART 1: TRANSITION STATISTICS
**************************************	
	* Merging W3 together
		use "$S3_DTA\BIHS_y_W3.dta", replace
			merge 1:1 a01 using "$BIHS_19f\108_bihs_r3_female_mod_x31.dta"
			drop _merge
			save "$S3_DTA\BIHS_y_W3a.dta", replace
	* Appending ALL WAVES datafiles together
		use "$S3_DTA\BIHS_y_W1.dta", replace
			append using "$S3_DTA\BIHS_y_W2.dta"
			append using "$S3_DTA\BIHS_y_W3a.dta"
	* Organize Waves, Samples, individuals, and Dropping Things
		gen WAVE = .
			replace WAVE = 2019 if round == 3
			replace WAVE = 2011 if sample_type != .
			replace WAVE = 2015 if WAVE == .
			drop round
			drop stime_h_x3 stime_m_x3 consent_x3
		gen SAMPLE = ""
			replace SAMPLE = "FTF" if hh_type == 1
			replace SAMPLE = "FTF" if sample_type == 1			
			replace SAMPLE = "FTF_A" if hh_type == 2
			replace SAMPLE = "FTF_A" if sample_type == 2
			replace SAMPLE = "NAT" if hh_type == 3
			replace SAMPLE = "NAT" if sample_type == 3		
		label variable SAMPLE "FTF_A = Feed the Future Additional; NAT = Nationally representative sample"
			drop hh_type sample_type
	* Combine all respondent IDs (rid) to one column	
		gen rid = .
			replace rid = x3_rid if WAVE == 2015		
			replace rid = x3_rid if WAVE == 2011		
			replace rid = res_id_x3 if WAVE == 2019
		* Organize Households by number of waves available
			* Stable for 3 Waves (stable3)
			sort a01 WAVE
			gen rounder = trunc(a01)
			gen diff = (a01 - trunc(a01))		
				bysort rounder: egen test1 = max(diff)
			gen stable123 = 0  // code for HHs responding for three rounds
				replace stable123 = 1 if test1 == 0	
				* Cleaning Stable123 for Respondent ID
				gen temp = rid
					replace temp = 0 if WAVE != 2011
				bysort rounder: egen temp1 = max(temp)
				replace stable123 = 1 if temp1 == rid
				bysort rounder: egen temp2 = total(stable123)
				replace stable123 = 0 if temp2 < 3
				drop temp temp1 temp2
			gen stable12 = 0   // code for HHs responding for first two rounds
				replace stable12 = 1 if stable123 == 1				
				sort stable12 a01 
				gen wave12 = 0
					replace wave12 = 1 if WAVE == 2011 | WAVE == 2015	
					replace test1 = 0 if WAVE == 2015			
				sort wave12 a01			
				gen A01 = a01
					replace A01 = 0 if WAVE != 2011
				gen temp = 0
				replace temp = rid if A01 != 0
				sort rounder wave12
				bysort rounder wave12: egen max = max(temp)
				gen temp12 = 0
					replace temp12 = 1 if max==rid
				bysort rounder: egen test3 = total(temp12)
				replace temp12 = 0 if test3 == 1
				replace stable12 = temp12 if WAVE != 2019
				replace stable12 = 0 if WAVE == 2019
				drop wave12-test3 test1
			* Number of waves
				bysort rounder: egen rid_count3 = total(stable123)
				bysort rounder: egen rid_count2 = total(stable12)
				
	** Thresholds for FCS metrics
		gen FCS_max_thres = 0
		gen FCS_opt_thres = 0
			replace FCS_max_thres = 1 if FCS_max < 21.5    // Poor
			replace FCS_max_thres = 2 if FCS_max > 21.49   // Borderline
			replace FCS_max_thres = 3 if FCS_max > 35      // Acceptable
			replace FCS_opt_thres = 1 if FCS_opt < 21.5
			replace FCS_opt_thres = 2 if FCS_opt > 21.49
			replace FCS_opt_thres = 3 if FCS_opt > 35		
			replace FCS_max_thres = 0 if FCS_max == .
			replace FCS_opt_thres = 0 if FCS_opt == .	
	** Thresholds for HDDS metric	
		* Maximum among groups		
			gen data1 = 0
				replace data1 = 1 if HDD1_09!=. | HDD2_09!=. | HDD3_09!=.
			gen data2 = 0
				replace data2 = 1 if HDD1_10!=. | HDD2_10!=. | HDD3_10!=.
			gen data3 = 0
				replace data3 = 1 if HDD1_11!=. | HDD2_11!=. | HDD3_11!=.			
			forvalues i = 1/3 {
				gen a`i' = HDD`i'_09 
				gen b`i' = HDD`i'_10
				gen c`i' = HDD`i'_11
				replace a`i' = 0 if a`i' == .
				replace b`i' = 0 if b`i' == .
				replace c`i' = 0 if c`i' == .
			}
			egen HDD_09_max = rowmax(a1 a2 a3)
			egen HDD_10_max = rowmax(b1 b2 b3)
			egen HDD_11_max = rowmax(c1 c2 c3)		
				replace HDD_09_max = . if data1 == 0 
				replace HDD_10_max = . if data2 == 0 		
				replace HDD_11_max = . if data3 == 0 						
			cap drop a1-c3 data1-data3
			cap drop HDD1_09 HDD2_09 HDD3_09 HDD1_10 HDD2_10 HDD3_10 ///
				 HDD1_11 HDD2_11 HDD3_11
			gen x = .
				replace x = HDD_09 if WAVE == 2015
				replace x = HDD_09_max if WAVE == 2019
				ren x HDD_09_a
				cap drop x
			gen x = .
				replace x = HDD_10 if WAVE == 2015
				replace x = HDD_10_max if WAVE == 2019
				ren x HDD_10_a
				cap drop x
			gen x = .
				replace x = HDD_11 if WAVE == 2015
				replace x = HDD_11_max if WAVE == 2019
				ren x HDD_11_a
				cap drop x
			cap drop HDD_09 HDD_10 HDD_11 HDD_09_max HDD_10_max HDD_11_max
			sum HDD_09_a HDD_10_a HDD_11_a HDD_12
		* HDDS Thresholds
			gen HDD_09_thres = .
				replace HDD_09_thres = 0 if HDD_09_a < 6
				replace HDD_09_thres = 1 if HDD_09_a > 5
				replace HDD_09_thres = . if HDD_09_a == .
			gen HDD_10_thres = .
				replace HDD_10_thres = 0 if HDD_10_a < 6
				replace HDD_10_thres = 1 if HDD_10_a > 5
				replace HDD_10_thres = . if HDD_10_a == .
			gen HDD_11_thres = .
				replace HDD_11_thres = 0 if HDD_11_a < 6
				replace HDD_11_thres = 1 if HDD_11_a > 5
				replace HDD_11_thres = . if HDD_11_a == .
			gen HDD_12_thres = .
				replace HDD_12_thres = 0 if HDD_12 < 6
				replace HDD_12_thres = 1 if HDD_12 > 5
		save "$S3_DTA\CHECKPOINT_X3.dta", replace	
	
	
**************************************
** FOOD SECURITY TRANSITIONS MATRIX ** PART 2: TRANSITION STATISTICS
**************************************
	**Three Year Transitions - FOOD CONSUMPTION SCORE
		use "$S3_DTA\CHECKPOINT_X3.dta", replace	
			keep a01 rid rid_count3 WAVE stable123 FCS* // FOR THREE YEARS
			*keep a01 rid rid_count3 WAVE stable12 FCS* // FOR TWO YEARS
			drop if rid_count3 == 0
			gen a01_a = round(a01)
			bysort a01_a: egen count = count(a01)
				drop if count <3
				drop if count >3
			replace a01 = a01_a
			drop a01_a rid rid_count3 count
			reshape wide FCS_max FCS_opt FCS_max_thres FCS_opt_thres, i(a01) j(WAVE)
			gen trunc_set = 1
		* Metrics within Three Year Transitions
			gen FCS3_ss_b_max = 0  // FCS3, stable-stable, binary, max assumption
				replace FCS3_ss_b_max = 1 if FCS_max_thres2011 == FCS_max_thres2015 & ///
											FCS_max_thres2015 == FCS_max_thres2019
			gen FCS3_dd_b_max = 0  // FCS3, drop-drop, binary, max assumption
				replace FCS3_dd_b_max = 1 if FCS_max_thres2011 > FCS_max_thres2015 & ///
											FCS_max_thres2015 > FCS_max_thres2019
			gen FCS3_uu_b_max = 0  // FCS3, up-up, binary, max assumption
				replace FCS3_uu_b_max = 1 if FCS_max_thres2011 < FCS_max_thres2015 & ///
											FCS_max_thres2015 < FCS_max_thres2019
			gen FCS3_su_b_max = 0  // FCS3, stable-up, binary, max assumption
				replace FCS3_su_b_max = 1 if FCS_max_thres2011 == FCS_max_thres2015 & ///
											FCS_max_thres2015 < FCS_max_thres2019
			gen FCS3_us_b_max = 0  // FCS3, up-stable, binary, max assumption 
				replace FCS3_us_b_max = 1 if FCS_max_thres2011 < FCS_max_thres2015 & ///
											FCS_max_thres2015 == FCS_max_thres2019
			gen FCS3_sd_b_max = 0  // FCS3, stable-down, binary, max assumption
				replace FCS3_sd_b_max = 1 if FCS_max_thres2011 == FCS_max_thres2015 & ///
											FCS_max_thres2015 > FCS_max_thres2019
			gen FCS3_ds_b_max = 0  // FCS3, down-stable, binary, max assumption 
				replace FCS3_ds_b_max = 1 if FCS_max_thres2011 > FCS_max_thres2015 & ///
											FCS_max_thres2015 == FCS_max_thres2019	
			gen FCS3_ss_b_opt = 0  // FCS3, stable-stable, binary, opt assumption
				replace FCS3_ss_b_opt = 1 if FCS_opt_thres2011 == FCS_opt_thres2015 & ///
											FCS_opt_thres2015 == FCS_opt_thres2019
			gen FCS3_dd_b_opt = 0  // FCS3, drop-drop, binary, opt assumption
				replace FCS3_dd_b_opt = 1 if FCS_opt_thres2011 > FCS_opt_thres2015 & ///
											FCS_opt_thres2015 > FCS_opt_thres2019
			gen FCS3_uu_b_opt = 0  // FCS3, up-up, binary, opt assumption
				replace FCS3_uu_b_opt = 1 if FCS_opt_thres2011 < FCS_opt_thres2015 & ///
											FCS_opt_thres2015 < FCS_opt_thres2019
			gen FCS3_su_b_opt = 0  // FCS3, stable-up, binary, opt assumption
				replace FCS3_su_b_opt = 1 if FCS_opt_thres2011 == FCS_opt_thres2015 & ///
											FCS_opt_thres2015 < FCS_opt_thres2019
			gen FCS3_us_b_opt = 0  // FCS3, up-stable, binary, opt assumption 
				replace FCS3_us_b_opt = 1 if FCS_opt_thres2011 < FCS_opt_thres2015 & ///
											FCS_opt_thres2015 == FCS_opt_thres2019
			gen FCS3_sd_b_opt = 0  // FCS3, stable-down, binary, opt assumption
				replace FCS3_sd_b_opt = 1 if FCS_opt_thres2011 == FCS_opt_thres2015 & ///
											FCS_opt_thres2015 > FCS_opt_thres2019
			gen FCS3_ds_b_opt = 0  // FCS3, down-stable, binary, opt assumption 
				replace FCS3_ds_b_opt = 1 if FCS_opt_thres2011 > FCS_opt_thres2015 & ///
											FCS_opt_thres2015 == FCS_opt_thres2019
		* Metrics within Two Year Transitions
			gen FCS2_s_b_max = 0  // FCS2, stable, binary, max assumption
				replace FCS2_s_b_max = 1 if FCS_max_thres2011 == FCS_max_thres2015
				replace FCS2_s_b_max = 1 if FCS_max_thres2015 == FCS_max_thres2019
			gen FCS2_d_b_max = 0  // FCS2, stable, binary, max assumption
				replace FCS2_d_b_max = 1 if FCS_max_thres2011 > FCS_max_thres2015
				replace FCS2_d_b_max = 1 if FCS_max_thres2015 > FCS_max_thres2019
			gen FCS2_u_b_max = 0  // FCS2, stable, binary, max assumption
				replace FCS2_u_b_max = 1 if FCS_max_thres2011 < FCS_max_thres2015
				replace FCS2_u_b_max = 1 if FCS_max_thres2015 < FCS_max_thres2019
			gen FCS2_s_b_opt = 0  // FCS2, stable, binary, opt assumption
				replace FCS2_s_b_opt = 1 if FCS_opt_thres2011 == FCS_opt_thres2015
				replace FCS2_s_b_opt = 1 if FCS_opt_thres2015 == FCS_opt_thres2019
			gen FCS2_d_b_opt = 0  // FCS2, stable, binary, opt assumption
				replace FCS2_d_b_opt = 1 if FCS_opt_thres2011 > FCS_opt_thres2015
				replace FCS2_d_b_opt = 1 if FCS_opt_thres2015 > FCS_opt_thres2019
			gen FCS2_u_b_opt = 0  // FCS2, stable, binary, opt assumption
				replace FCS2_u_b_opt = 1 if FCS_opt_thres2011 < FCS_opt_thres2015
				replace FCS2_u_b_opt = 1 if FCS_opt_thres2015 < FCS_opt_thres2019
		* Save the file
			reshape long
			keep a01 WAVE trunc_set FCS3* FCS2*
			save "$S3_DTA\CHECKPOINT_FCS.dta", replace	

	**Two Year Transitions - HOUSEHOLD DIET DIVERSITY SCORE
		use "$S3_DTA\CHECKPOINT_X3.dta", replace	
			keep a01 rid WAVE HDD*
			drop if WAVE == 2011  // HDDI only recorded in 2015 & 2019
			gen a01_a = round(a01)			
			drop HDD_09_a HDD_10_a HDD_11_a HDD_12 
			reshape wide rid HDD_09_thres HDD_10_thres HDD_11_thres ///
				HDD_12_thres, i(a01) j(WAVE)
			drop if rid2015 != rid2019			
			//drop rid2015 rid2019	
			gen trunc_set = 2
		* Metrics within Two Year Transitions 
			gen HDD2_s_b_09 = 0  // Children<2y.o., HDD, 2yr, binary
				replace HDD2_s_b_09 = 1 if HDD_09_thres2015 == ///
					HDD_09_thres2019 & HDD_09_thres2015 != .
			gen HDD2_d_b_09 = 0  
				replace HDD2_d_b_09 = 1 if HDD_09_thres2015 > ///
					HDD_09_thres2019 & HDD_09_thres2015 != .		
			gen HDD2_u_b_09 = 0  
				replace HDD2_u_b_09 = 1 if HDD_09_thres2015 < ///
					HDD_09_thres2019 & HDD_09_thres2015 != .
			gen HDD2_s_b_10 = 0  // Mothers of children, HDD, 2yr, binary
				replace HDD2_s_b_10 = 1 if HDD_10_thres2015 == ///
					HDD_10_thres2019 & HDD_10_thres2015 != .
			gen HDD2_d_b_10 = 0  
				replace HDD2_d_b_10 = 1 if HDD_10_thres2015 > ///
					HDD_10_thres2019 & HDD_10_thres2015 != .		
			gen HDD2_u_b_10 = 0  
				replace HDD2_u_b_10 = 1 if HDD_10_thres2015 < ///
					HDD_10_thres2019 & HDD_10_thres2015 != .
			gen HDD2_s_b_11 = 0  // F14-49, HDD, 2yr, binary
				replace HDD2_s_b_11 = 1 if HDD_11_thres2015 == ///
					HDD_11_thres2019 & HDD_11_thres2015 != .
			gen HDD2_d_b_11 = 0  
				replace HDD2_d_b_11 = 1 if HDD_11_thres2015 > ///
					HDD_11_thres2019 & HDD_11_thres2015 != .		
			gen HDD2_u_b_11 = 0 
				replace HDD2_u_b_11 = 1 if HDD_11_thres2015 < ///
					HDD_11_thres2019 & HDD_11_thres2015 != .
			gen HDD2_s_b_12 = 0  // Others, HDD, 2yr, binary
				replace HDD2_s_b_12 = 1 if HDD_12_thres2015 == ///
					HDD_12_thres2019 & HDD_12_thres2015 != .
			gen HDD2_d_b_12 = 0  
				replace HDD2_d_b_12 = 1 if HDD_12_thres2015 > ///
					HDD_12_thres2019 & HDD_12_thres2015 != .		
			gen HDD2_u_b_12 = 0  
				replace HDD2_u_b_12 = 1 if HDD_12_thres2015 < ///
					HDD_12_thres2019 & HDD_12_thres2015 != .					
		* Split household conditions
			gen split = ((abs(round(a01)-a01)) > 0)
			gen high_split = round(a01)-a01
			bysort a01_a: egen min_split = min(high_split)
			drop if high_split != min_split & split == 1
		* Save the file
			reshape long			
			replace a01 = a01_a		
		* Duplicates drop
			duplicates drop			
			keep a01 WAVE trunc_set HDD2* rid
		* ISID issue
			drop if rid == .
			bysort a01 WAVE: egen min_rid = min(rid)
			drop if rid != min_rid
			duplicates drop 
		* Further ISID issue
			isid WAVE a01
			drop min
			save "$S3_DTA\CHECKPOINT_HDD.dta", replace			
		
**************************************
** FOOD SECURITY TRANSITIONS MATRIX ** PART 3: MERGE STUFF
**************************************
	clear all
	** Base Data
		use "$S3_DTA\CHECKPOINT_X3.dta", replace
			merge m:1 a01 WAVE using "$S3_DTA\CHECKPOINT_FCS.dta"
				drop _merge
				ren trunc_set trunc_set1
			merge 1:m a01 WAVE rid using "$S3_DTA\CHECKPOINT_HDD.dta"
				drop _merge rounder diff
				ren trunc_set trunc_set2
	** Add Labels
		label variable FCS_max "FCS with maximum assumption for collapsed food groups"
		label variable FCS_opt "FCS with maximum assumption for collapsed food groups (sum all)"
		label variable FCS_max "FCS with maximum assumption for collapsed food groups (rowmax by group)"
		label variable HDD_12 "HH diet diversity; rowmax by group (waves 2 & 3)"
		label variable WAVE "Wave: either 2011, 2015, 2019"
		label variable rid "Respondent ID within HH"
		label variable stable123 "Respondent stable for 3 years"
		label variable stable12 "Respondent stable for first 2 years"
		label variable FCS_max_thres "Poor < 21.5; Borderline < 35; Acceptable > 35"
		label variable FCS_opt_thres "Poor < 21.5; Borderline < 35; Acceptable > 35"
		label variable HDD_09_a "HHD for < 2 y.o."
		label variable HDD_10_a "HHD for < 2 y.o. mothers"
		label variable HDD_11_a "HHD for women 14-49 y.o."
		label variable HDD_09_thres "Above threshold, < 2 y.o."
		label variable HDD_10_thres "Above threshold, < 2 y.o. mother"
		label variable HDD_11_thres "Above threshold, F14-49 y.o."
		label variable HDD_12_thres "Above threshold, all other members"
		label variable FCS3_ss_b_max "FCS stable-stable"
		label variable FCS3_dd_b_max "FCS down-down"
		label variable FCS3_uu_b_max "FCS up-up"
		label variable FCS3_su_b_max "FCS stable-up"
		label variable FCS3_us_b_max "FCS up-stable"
		label variable FCS3_sd_b_max "FCS stable-down"
		label variable FCS3_ds_b_max "FCS down-stable"
		label variable FCS3_ss_b_opt "FCS stable-stable"
		label variable FCS3_dd_b_opt "FCS down-down"
		label variable FCS3_uu_b_opt "FCS up-up"
		label variable FCS3_su_b_opt "FCS stable-up"
		label variable FCS3_us_b_opt "FCS up-stable"
		label variable FCS3_sd_b_opt "FCS stable-down"
		label variable FCS3_ds_b_opt "FCS down-stable"
		label variable FCS2_s_b_max "FCS stable"
		label variable FCS2_d_b_max "FCS down"
		label variable FCS2_u_b_max "FCS up"
		label variable FCS2_s_b_opt "FCS stable"
		label variable FCS2_d_b_opt "FCS down"
		label variable FCS2_u_b_opt "FCS up"		
		label variable HDD2_s_b_09 "HDD stable, < 2 y.o."
		label variable HDD2_d_b_09 "HDD down, < 2 y.o."
		label variable HDD2_u_b_09 "HDD up, < 2 y.o." 
		label variable HDD2_s_b_10 "HDD stable, < 2 y.o. mother"
		label variable HDD2_d_b_10 "HDD down, < 2 y.o. mother"
		label variable HDD2_u_b_10 "HDD up, < 2 y.o. mother"
		label variable HDD2_s_b_11 "HH stable, F14-49"
		label variable HDD2_d_b_11 "HH down, F14-49" 
		label variable HDD2_u_b_11 "HH up, F14-49"
		label variable HDD2_s_b_12 "HH stable, other members"
		label variable HDD2_d_b_12 "HH down, other members"
		label variable HDD2_u_b_12 "HH up, other members"

	** Save a File	
		save "$S3_DTA\OutcomeVars_X3.dta", replace

			


//////////////////////////////////// APPENDIX /////////////////////////////////
* Visualize
	hist FCS_max, by(WAVE)

	/* IRT Sampling - Graded
			** IRT BINARY **
			gen irt1 = 0 
				replace irt1 = 1 if x3_01 == 1
			gen irt2 = 0 
				replace irt2 = 1 if x3_03 == 1
			gen irt3 = 0 
				replace irt3 = 1 if x3_05 == 1
			** IRT GRADED **
			gen y1 = 0
			gen y2 = 0
			gen y3 = 0
			replace y1 = x3_02 if x3_02 != .
			replace y2 = x3_04 if x3_04 != .
			replace y3 = x3_06 if x3_06 != .
			// irt grm y1-y3     // not concave
			// irt 1pl irt1-irt3 // not concave
			drop irt* y*
			*/






