///////////////////////////////////////////////////////////
///  OUTCOME VARIABLES HARMONIZATION ACROSS BIHS WAVES  ///
///////////////////////////////////////////////////////////
clear all 

*--------------------*
*  Wave Directories  *
*--------------------*
* Directory for 2011 *
	global BIHS_11 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_11"
* Directory for 2015 *
	global BIHS_15 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_15"
* Directory for 2019 *
	global BIHS_19m "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Male"
	global BIHS_19f "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Female"
	global BIHS_19comm "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Community"
	
* Directory for Step 3 DTAs
	global S3_DTA "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 3 - Prep Outcome Vars\Step 3 DTAs" 
	
*--------*
*  Data  *
*--------*	
	* Create Merged O1 Dataset	
		use "$BIHS_11\031_mod_o1_female.dta", replace	
			gen WAVE = 2011
		append using "$BIHS_15\042_r2_mod_o1_female.dta"	
			replace WAVE = 2015 if WAVE == .
		append using "$BIHS_19f\096_bihs_r3_female_mod_o1.dta"
			drop if consent_o1 == 2
			keep a01 WAVE o1* hhid2 res_id_o1 sample hh_type round
			decode o1_01, gen(o1_01_code)
			replace WAVE = 2019 if WAVE == .
		merge m:1 o1_01 o1_01_code using "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 3 - Prep Outcome Vars\Step 3 DTAs\food_group_merge.dta"
			drop _merge
			replace food_group_code = 8 if o1_01 == 164
			replace food_group_code = 10 if o1_01 == 237
			replace food_group_code = 13 if o1_01 == 269
			replace food_group_code = 11 if o1_01 == 323
			replace food_group_code = 4 if o1_01 == 621
			replace food_group_code = 4 if o1_01 == 622
			replace food_group_code = 4 if o1_01 == 441
			replace food_group_code = 11 if o1_01 == 2521
			replace food_group_code = 11 if o1_01 == 2522
			replace food_group_code = 11 if o1_01 == 2524
			replace food_group_code = 11 if o1_01 == 3231
			replace food_group_code = 11 if o1_01 == 3232
			replace food_group_code = 13 if o1_01 == 272
	* Calculate Quantity Consumed IN GRAMS by Item
		gen o1_03a = o1_03 // kg to grams
			replace o1_03a = 1000*o1_03 if o1_04 == 1
		gen o1_04a = o1_04	
			replace o1_04a = 2 if o1_04 == 1
		replace o1_03a = o1_05*o1_03 if o1_04 == 4 // count to grams
		label variable o1_03a "total quantity consumed, in grams"
		* drop o1_03 o1_04 o1_05 // can keep if needed
	* Calculate Quantity Consumed IN GRAMS by Item for PURCHASED ITEMS
		gen o1_06a = o1_06 // kg to g
			replace o1_06a = o1_06*1000 if o1_04 == 1
		gen o1_10a = o1_10
			replace o1_10a = o1_10*1000 if o1_04 == 1
	* Aggregate by food group
		bysort WAVE a01 food_group: egen tot_consump_g = total(o1_03a)
		bysort WAVE a01 food_group: egen tot_purchas_g = total(o1_06a)
		bysort WAVE a01 food_group: egen tot_purchas_p = total(o1_08)
		bysort WAVE a01 food_group: egen tot_produce_g = total(o1_10a)
	* Sort for Reshape 
		replace food_group = "cereal" if food_group_code ==1
		replace food_group = "pulses" if food_group_code ==2
		replace food_group = "oilseed" if food_group_code ==3
		replace food_group = "vegetable" if food_group_code ==4 
		replace food_group = "leafveg" if food_group_code ==5
		replace food_group = "meat" if food_group_code ==6	
		replace food_group = "fruit" if food_group_code ==7
		replace food_group = "bigfish" if food_group_code ==8
		replace food_group = "smallfish" if food_group_code ==9	
		replace food_group = "salt" if food_group_code ==10
		replace food_group = "spice" if food_group_code ==11
		replace food_group = "spice" if food_group == "spices"
		replace food_group = "spice" if food_group == "iodinesalt"	
		replace food_group = "other" if food_group_code == 12
		replace food_group = "drinks" if food_group_code ==13
		replace food_group = "FAFH" if food_group_code ==14
		drop if food_group_code == .
		drop dup
		
	* Reshape Wide
		sort a01 WAVE food_group_code
		quietly by a01 WAVE food_group_code:  gen dup = cond(_N==1,0,_n)
			drop if dup > 1	
		drop o1_01 o1_03 o1_04 o1_06 o1_05 o1_07 o1_08 o1_09 o1_10 o1_11 o1_12 o1_13 sample_type dup o1_13oth o1_14 o1_01_code o1_03a o1_04a o1_06a o1_10a food_group hhid2
		reshape wide tot_consump_g tot_produce_g tot_purchas_g tot_purchas_p, i(a01 WAVE) j(food_group_code)		

	* Total Consumption Past 7 Days in grams
		gen tot_consump_g_cereal = tot_consump_g1
		gen tot_consump_g_pulses = tot_consump_g2 +tot_consump_g3
		gen tot_consump_g_vegetables = tot_consump_g4 + tot_consump_g5
		gen tot_consump_g_fruit = tot_consump_g7
		gen tot_consump_g_meat = tot_consump_g6
		gen tot_consump_g_fish = tot_consump_g8 +tot_consump_g9
		gen tot_consump_g_spice = tot_consump_g10 + tot_consump_g11
		gen tot_consump_g_drinks = tot_consump_g12 + tot_consump_g13
		gen tot_consump_g_FAFH = tot_consump_g14
		
	* Total Purchased Past 7 Days in grams	
		gen tot_purchas_g_cereal = tot_purchas_g1		
		gen tot_purchas_g_pulses = tot_purchas_g2 + tot_purchas_g3
		gen tot_purchas_g_vegetables = tot_purchas_g4+tot_purchas_g5
		gen tot_purchas_g_fruit	= tot_purchas_g7
		gen tot_purchas_g_meat = tot_purchas_g6
		gen tot_purchas_g_fish = tot_purchas_g8 + tot_purchas_g9	
		gen tot_purchas_g_spice = tot_purchas_g10 + tot_purchas_g11
		gen tot_purchas_g_drinks = tot_purchas_g12 + tot_purchas_g13
		gen tot_purchas_g_FAFH = tot_purchas_g14

	* Total Purchased Past 7 Days in taka (price)	
		gen tot_purchas_p_cereal = tot_purchas_p1
		gen tot_purchas_p_pulses = tot_purchas_p2 + tot_purchas_p3
		gen tot_purchas_p_vegetables = tot_purchas_p4 + tot_purchas_p5
		gen tot_purchas_p_fruit = tot_purchas_p7
		gen tot_purchas_p_meat	= tot_purchas_p6
		gen tot_purchas_p_fish  = tot_purchas_p8 + tot_purchas_p9
		gen tot_purchas_p_spice	= tot_purchas_p10 + tot_purchas_p11
		gen tot_purchas_p_drinks = tot_purchas_g12 + tot_purchas_p13
		gen tot_purchas_p_FAFH = tot_purchas_p14

	* Total Produced Past 7 Days in grams
		gen tot_produce_g_cereal = tot_produce_g1
		gen tot_produce_g_pulses = tot_produce_g2 + tot_produce_g3
		gen tot_produce_g_vegetables = tot_produce_g4 + tot_produce_g5	
		gen tot_produce_g_fruit = tot_produce_g7 
		gen tot_produce_g_meat = tot_produce_g6
		gen tot_produce_g_fish = tot_produce_g8 + tot_produce_g9
		gen tot_produce_g_spice = tot_produce_g10 + tot_produce_g11
		gen tot_produce_g_drinks = tot_produce_g12 + tot_produce_g13
		gen tot_produce_g_FAFH	 = tot_produce_g14
		
	* Cleaning Variables
		drop if a01 == . & WAVE == .
		keep a01 WAVE o1_02 hh_type res_id_o1 round tot_consump_g_* tot_purchas_g_* tot_purchas_p_* tot_produce_g_*

	* Redo Labels
			label variable tot_consump_g_cereal "total consumption (g)"
			label variable tot_consump_g_pulses "total consumption (g)"	
			label variable tot_consump_g_vegetables "total consumption (g)"	
			label variable tot_consump_g_fruit "total consumption (g)"	
			label variable tot_consump_g_meat "total consumption (g)"	
			label variable tot_consump_g_fish "total consumption (g)"	
			label variable tot_consump_g_spice "total consumption (g)"	
			label variable tot_consump_g_drinks "total consumption (g)"	
			label variable tot_consump_g_FAFH "total consumption (g)"	
				
			label variable tot_purchas_g_cereal "total purchases (g)"
			label variable tot_purchas_g_pulses "total purchases (g)"
			label variable tot_purchas_g_vegetables "total purchases (g)"
			label variable tot_purchas_g_fruit "total purchases (g)"
			label variable tot_purchas_g_meat "total purchases (g)"
			label variable tot_purchas_g_fish "total purchases (g)"
			label variable tot_purchas_g_spice "total purchases (g)"
			label variable tot_purchas_g_drinks "total purchases (g)"
			
			label variable tot_purchas_p_cereal "total purchases (p)"
			label variable tot_purchas_p_pulses "total purchases (p)"
			label variable tot_purchas_p_vegetables "total purchases (p)"
			label variable tot_purchas_p_fruit "total purchases (p)"		
			label variable tot_purchas_p_meat "total purchases (p)"
			label variable tot_purchas_p_fish "total purchases (p)"		
			label variable tot_purchas_p_spice "total purchases (p)"
			label variable tot_purchas_p_drinks "total purchases (p)"		
			label variable tot_purchas_p_FAFH "total purchases (p)"

			label variable tot_produce_g_cereal "total purchases (g)"	
			label variable tot_produce_g_pulses "total purchases (g)"	
			label variable tot_produce_g_vegetables "total purchases (g)"	
			label variable tot_produce_g_fruit "total purchases (g)"	
			label variable tot_produce_g_meat "total purchases (g)"	
			label variable tot_produce_g_fish "total purchases (g)"	
			label variable tot_produce_g_spice "total purchases (g)"	
			label variable tot_produce_g_drinks "total purchases (g)"	
			label variable tot_produce_g_FAFH "total purchases (g)"	

		save "$S3_DTA\OutcomeVars_O1.dta", replace
	
			
			
		
* Dropped Sections
	/* Create a Food_Group text variable	
		gen food_group = .
			replace food_group = "cereal" if food_group_code ==1
			replace food_group = "pulses" if food_group_code ==2
			replace food_group = "oilseed" if food_group_code ==3
			replace food_group = "vegetable" if food_group_code ==4 
			replace food_group = "leafveg" if food_group_code ==5
			replace food_group = "meat" if food_group_code ==6	
			replace food_group = "fruit" if food_group_code ==7
			replace food_group = "bigfish" if food_group_code ==8
			replace food_group = "smallfish" if food_group_code ==9	
			replace food_group = "salt" if food_group_code ==10
			replace food_group = "spice" if food_group_code ==11
			replace food_group = "other" if food_group_code == 12
			replace food_group = "drinks" if food_group_code ==13
			replace food_group = "FAFH" if food_group_code ==14
	*/































