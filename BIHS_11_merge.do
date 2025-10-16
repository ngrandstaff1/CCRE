**************************
**************************
** BIHS Clean Data 2011 ** ** (Key: n, level, id1, id2)
**     N.Grandstaff     **
**************************
**************************
clear all

*--------------------*
* Directory for 2011 *
*--------------------*
global BIHS_11 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_11"


*--------------------*
*  BIHS 2011 HH Data *
*--------------------*
** 001_mod_a_male (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\001_mod_a_male.dta", replace

** 002_mod_a_female (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\002_mod_a_female.dta", replace

** 003_mod_b1_male (27285, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\003_mod_b1_male.dta", replace
		
** 004_mod_b2_male (7677, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\004_mod_b2_male.dta", replace
	ren b2_06 b2_06a
	save "$BIHS_11\004_mod_b2_male_EDIT.dta", replace

** 005_mod_c_male (29889, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\005_mod_c_male.dta", replace
	sort a01 mid
	quietly by a01 mid : gen dup = cond(_N==1, 0, _n)
	bysort a01 mid : egen c07_a = max(c07)
	label variable c07_a "for how many days last week did you work?"
	bysort a01 mid : egen c08_a = mean(c08)	
	label variable c08_a "for an average of how many hours a day did you work?"
	bysort a01 mid : egen c13_a = total(c13)
	label variable c13_a "how much money was obtained by selling the kind received wages and salaries?"
	bysort a01 mid : egen c14_a = total(c14)
	label variable c14_a "monthly salary or average monthly income for self employment?"	
	drop if dup > 1 	
	drop c02 c03 c04 c06 c07 c08 c13 c14 dup
	save "$BIHS_11\005_mod_c_male_EDIT.dta", replace

** 006_mod_d1_male (29889, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\006_mod_d1_male.dta", replace
	cap drop dup
	sort a01 mid
	quietly by a01 mid : gen dup = cond(_N==1, 0, _n)
	bysort a01 mid : egen c07_a = max(c07)
	label variable c07_a "for how many days last week did you work?"
	bysort a01 mid : egen c08_a = total(c08)	
	label variable c08_a "for an average of how many hours a day did you work?"	
	bysort a01 mid : egen c13_a = total(c13)
	label variable c13_a "how much money was obtained by selling the kind received wages and salaries?"
	bysort a01 mid : egen c14_a = total(c14)
	label variable c14_a "monthly salary or average monthly income for self employment?"	
	drop if dup > 1 	
	drop c02 c03 c04 c06 c07 c08 c13 c14 dup
	save "$BIHS_11\006_mod_d1_male_EDIT.dta", replace

** 007_mod_d2_male (214599, assets, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\007_mod_d2_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen d2_10_a = total(d2_10)
	label variable d2_10_a "current total value if asset(s) sold today how much will you receive?"
	drop if dup > 1
	keep a01 d2_10_a 
	save "$BIHS_11\007_mod_d2_male_EDIT.dta", replace

** 008_mod_e_male (8429, HH-bank, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\008_mod_e_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen e02_a = min(e02)
	label variable e02_a "does any adult in the household currently have any savings"
	bysort a01: egen e06_a = total(e06)
	label variable e06_a "household total amount currently saved"	
	drop if dup > 1
	keep a01 e02_a e06_a
	save "$BIHS_11\008_mod_e_male_EDIT.dta", replace
	
** 009_mod_f_male (9411, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\009_mod_f_male.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen f01_a = min(f01) 
	label variable f01_a "have any adult in the household ever had any loans"
	bysort a01: egen f02_min = min(f02) 
	label variable f02_min "does any adult in the household currently have a loan with any individual or institution"
	bysort a01: egen f07_a = min(f07) 
	label variable f07_a "total loan amount"
	bysort a01: egen f09_a = min(f09) 
	label variable f09_a "what is the total outstanding amount with or without interest"
	drop if dup > 1	
	keep a01 f01_a f02_min f06_a f06_b f06_c f07_a f09_a 
	save "$BIHS_11\009_mod_f_male_EDIT.dta", replace

** 010_mod_g_male (25396, HH-plots, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\010_mod_g_male.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen g02_a = total(g02)
	label variable g02_a "total plot size/area in decimal"
	bysort a01: egen g03_a = mean(g03)
	label variable g03_a "average distance from home (meters)"
	bysort a01: egen g04_a = mean(g04)
	label variable g04_a "average usual flood depth (during monsoon/flood season) (feet)"
	gen temp_cico = (g07)/g02
	bysort a01: egen g07_a = mean(g07)
	label variable g07_a "average cash in/cash out per area"
	drop if dup > 1
	keep a01 g02_a g03_a g04_a g07_a	
	save "$BIHS_11\010_mod_g_male_EDIT.dta", replace

** 011_mod_h1_male (22627, HH-plots, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\011_mod_h1_male.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen h1_03_a = total(h1_03)
	label variable h1_03_a "total area planted"
	bysort a01: egen h1_06_a = total(h1_06)
	label variable h1_06_a "total cost of seed"
	drop if dup > 1
	keep a01 h1_03_a h1_06_a
	save "$BIHS_11\011_mod_h1_male_EDIT.dta", replace

** 012_mod_h2_male (22627, HH-plots, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\012_mod_h2_male.dta", replace	
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	bysort a01: egen h2_05_a = total(h2_05)
	label variable h2_05_a "total cash cost of irrigation"
	drop if dup > 1 	
	keep a01 h2_05_a
	save "$BIHS_11\012_mod_h2_male_EDIT.dta", replace

** 013_mod_h3_male (7977, HH-plots, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\013_mod_h3_male.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)		
	bysort a01: egen h3_10_a = total(h3_10)
	label variable h3_10_a "total value of manure/compost in use (taka)"
	bysort a01: egen h3_11_a = total(h3_11)
	label variable h3_11_a "total value of pesticide/insecticides/herbicides in use (taka)"
	drop if dup > 1
	keep a01 h3_10_a h3_11_a 
	save "$BIHS_11\013_mod_h3_male_EDIT.dta", replace

** 014_mod_h4_male (7977, HH-plots, a01, - ) - AGGREGATE on (a01)
use "$BIHS_11\014_mod_h4_male.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	bysort a01: egen h4_04_a = total(h4_04)
	label variable h4_04_a "tools/machinery used for land preparation (rental cost in taka)"
	bysort a01: egen h4_05_a = total(h4_05)
	label variable h4_05_a "tools/machinery used for land preparation (fuel cost in taka)"
	bysort a01: egen h4_06_a = total(h4_06)
	label variable h4_06_a "tools/machinery used for land preparation (planting cost in taka)"
	bysort a01: egen h4_07_a = total(h4_07)
	label variable h4_07_a "tools/machinery used for land preparation (fertilizer cost in taka)"
	bysort a01: egen h4_08_a = total(h4_08)
	label variable h4_08_a "tools/machinery used for land preparation (pesticide cost in taka)"
	bysort a01: egen h4_09_a = total(h4_09)
	label variable h4_09_a "tools/machinery used for land preparation (weeding cost in taka)"
	bysort a01: egen h4_10_a = total(h4_10)
	label variable h4_10_a "tools/machinery used for land preparation (harvesting cost in taka)"
	drop if dup > 1
	keep a01 h4_04_a-h4_10_a
	save "$BIHS_11\014_mod_h4_male_EDIT.dta", replace
	
** 015_mod_h5_male (7977, HH-plots, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\015_mod_h5_male.dta", replace	
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	gen mlabor_house_crop = h5_01+h5_07+h5_13+h5_19+h5_25+h5_31+h5_37
	gen mlabor_hired_crop = h5_03+h5_09+h5_15+h5_21+h5_27+h5_33+h5_39
	gen flabor_house_crop = h5_02+h5_08+h5_14+h5_20+h5_26+h5_32+h5_38
	gen flabor_hired_crop = h5_05+h5_11+h5_17+h5_23+h5_29+h5_35+h5_41
	bysort a01: egen mlabor_house_total_pre = total(mlabor_house_crop)
	bysort a01: egen flabor_house_total_pre = total(flabor_house_crop)
	bysort a01: egen mlabor_hired_total_pre = total(mlabor_hired_crop)
	bysort a01: egen flabor_hired_total_pre = total(flabor_hired_crop)
	label variable mlabor_house_total "total hours pre-harvest, family supplied" 
	label variable flabor_house_total "total hours pre-harvest, family supplied" 
	label variable mlabor_hired_total "total hours pre-harvest, hired supplied" 
	label variable flabor_hired_total "total hours pre-harvest, hired supplied" 
	drop if dup > 1
	keep a01 mlabor_house_total flabor_house_total mlabor_hired_total flabor_hired_total
	save "$BIHS_11\015_mod_h5_male_EDIT.dta", replace
	
** 016_mod_h6_male (9919, HH-crops, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\016_mod_h6_male.dta", replace	
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	gen mlabor_house_crop = h6_01+h6_10+h6_16+h6_22+h6_28
	gen mlabor_hired_crop = h6_03+h6_12+h6_18+h6_24+h6_30
	gen flabor_house_crop = h6_02+h6_11+h6_17+h6_23+h6_29
	gen flabor_hired_crop = h6_05+h6_14+h6_20+h6_26+h6_32
	bysort a01: egen mlabor_house_total_post = total(mlabor_house_crop)
	bysort a01: egen flabor_house_total_post = total(flabor_house_crop)
	bysort a01: egen mlabor_hired_total_post = total(mlabor_hired_crop)
	bysort a01: egen flabor_hired_total_post = total(flabor_hired_crop)
	label variable mlabor_house_total "total hours post-harvest, family supplied" 
	label variable flabor_house_total "total hours post-harvest, family supplied" 
	label variable mlabor_hired_total "total hours post-harvest, hired supplied" 
	label variable flabor_hired_total "total hours post-harvest, hired supplied" 
	drop if dup > 1
	keep a01 mlabor_house_total flabor_house_total mlabor_hired_total flabor_hired_total
	save "$BIHS_11\016_mod_h6_male_EDIT.dta", replace

** 017_mod_h7_male (58527, HH-inputs, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\017_mod_h7_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	drop if h7_01 == 4 | h7_01 == 5 | h7_01 == 7
	foreach x in "urea" "TSP" "DAP" "amonia" "npks" {
		gen h7_`x'_br = .
		gen h7_`x'_b1 = .
		gen h7_`x'_b2 = .
		gen h7_`x'_pr = .
		gen h7_`x'_p1 = .
		gen h7_`x'_p2 = .
		label variable h7_`x'_br "did you use X in rabi (season)"
		label variable h7_`x'_b1 "did you use X in kharif (season)"
		label variable h7_`x'_b2 "did you use X in rabi (season)"
		label variable h7_`x'_pr "avg taka per kg X in rabi (season)"
		label variable h7_`x'_p1 "avg taka per kg X in kharif (season)"
		label variable h7_`x'_p2 "avg taka per kg X in rabi (season)"
	}
	ren (h7_02 h7_03 h7_04 h7_05 h7_06 h7_07) (h7_br h7_pr h7_b1 h7_p1 h7_b2 h7_p2)
	label define tab12 1 "yes" 2 "no"
	foreach x in "br" "b1" "b2" "pr" "p1" "p2" {
		replace h7_urea_`x'   = h7_`x' if h7_01 == 1
		replace h7_TSP_`x'    = h7_`x' if h7_01 == 2
		replace h7_DAP_`x'    = h7_`x' if h7_01 == 3
		replace h7_amonia_`x' = h7_`x' if h7_01 == 6
		replace h7_npks_`x'   = h7_`x' if h7_01 == 8
	}
	foreach i in "br" "b1" "b2" "pr" "p1" "p2" {
		foreach x in "urea" "TSP" "DAP" "amonia" "npks" {
			bysort a01: egen `i'_`x' = sum(h7_`x'_`i')
			drop h7_`x'_`i'
			ren `i'_`x' h7_`x'_`i'
			replace h7_`x'_`i' = . if h7_`x'_`i' == 0
		}
	}
	foreach i in "br" "b1" "b2" {
		foreach x in "urea" "TSP" "DAP" "amonia" "npks" {
			label values h7_`x'_`i' tab12
		}
	}
	drop if dup > 1
	keep a01 h7_urea_br-h7_npks_p2
	save "$BIHS_11\017_mod_h7_male_EDIT.dta", replace

** 018_mod_h8_male (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\018_mod_h8_male.dta", replace		

** 019_mod_i1_male (33029, HH-crops, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\019_mod_i1_male.dta", replace	
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	* Number of crops produced by HH
	bysort a01: egen crop_count = count(a01)
	* Aggregating crop types : "rice" "wheat" "maize" "millet" "pulses"
		gen i1_01_rice = 0
			replace i1_01_rice = i1_01 if crop == 11 // aush local
			replace i1_01_rice = i1_01 if crop == 12 // aush local developed
			replace i1_01_rice = i1_01 if crop == 13 // aush hyv
			replace i1_01_rice = i1_01 if crop == 18 // aush ropa (hyv)
			replace i1_01_rice = i1_01 if crop == 14 // aman local
			replace i1_01_rice = i1_01 if crop == 15 // aman b.l
			replace i1_01_rice = i1_01 if crop == 16 // aman hyv
			replace i1_01_rice = i1_01 if crop == 17 // aman hybrid
			replace i1_01_rice = i1_01 if crop == 19 // boro hyv
			replace i1_01_rice = i1_01 if crop == 20 // boro hybrid
		gen i1_01_wheat = 0
			replace i1_01_wheat = i1_01 if crop == 21 // wheat l
			replace i1_01_wheat = i1_01 if crop == 22 // wheat hyv
		gen i1_01_maize = 0
			replace i1_01_maize = i1_01 if crop == 23 // maize
		gen i1_01_millet = 0
			replace i1_01_millet = i1_01 if crop == 27 // kaun (italian millet)
			replace i1_01_millet = i1_01 if crop == 28 // joar (great millet)
			replace i1_01_millet = i1_01 if crop == 26 // cheena	
		gen i1_01_pulses = 0
			replace i1_01_pulses = i1_01 if crop == 51 // lintel
			replace i1_01_pulses = i1_01 if crop == 52 // mung
			replace i1_01_pulses = i1_01 if crop == 53 // black gram (mashkalai)
			replace i1_01_pulses = i1_01 if crop == 54 // vetch (khesari)
			replace i1_01_pulses = i1_01 if crop == 55 // chick pea
			replace i1_01_pulses = i1_01 if crop == 57 // field pea (motor)
			replace i1_01_pulses = i1_01 if crop == 58 // motor kalai
			replace i1_01_pulses = i1_01 if crop == 111 // cow pea
			replace i1_01_pulses = i1_01 if crop == 126 // bean
		foreach x in "rice" "wheat" "maize" "millet" "pulses" {
			bysort a01: egen `x'_harv = sum(i1_01_`x')
			label variable `x'_harv "quantity harvested (kg)"
			drop i1_01_`x'
		}	
	* Creating data storage columns
		foreach x in "rice" "wheat" "maize" "millet" "pulses" {
			gen i1_06_`x' = .
			gen i1_10_`x' = .
			gen i1_12a_`x' = .
			gen i1_12b_`x' = .
			gen i1_13_`x' = .
		}
	* Aggregating on consumption (i1_06) and sold (i1_10) 			
			forvalues i = 11/20 {
				replace i1_06_rice = i1_06 if crop == `i'
				replace i1_10_rice = i1_10 if crop == `i'
			}
			forvalues i = 21/22 {
				replace i1_06_wheat = i1_06 if crop == `i'
				replace i1_10_wheat = i1_10 if crop == `i'
			}	
			replace i1_06_maize = i1_06 if crop == 23
			replace i1_10_maize = i1_10 if crop == 23
			forvalues i = 26/28 {
				replace i1_06_millet = i1_06 if crop == `i'
				replace i1_10_millet = i1_10 if crop == `i'
			}	
			forvalues i = 51/55 {
				replace i1_06_pulses = i1_06 if crop == `i'
				replace i1_10_pulses = i1_10 if crop == `i'
			}	
			forvalues i = 57/58 {
				replace i1_06_pulses = i1_06 if crop == `i'
				replace i1_10_pulses = i1_10 if crop == `i'
			}	
			replace i1_06_pulses = i1_06 if crop == 111
			replace i1_06_pulses = i1_06 if crop == 126
			replace i1_10_pulses = i1_10 if crop == 111
			replace i1_10_pulses = i1_10 if crop == 126
		foreach x in "rice" "wheat" "maize" "millet" "pulses" {
			bysort a01: egen `x'_sold = sum(i1_10_`x')
			bysort a01: egen `x'_cons = sum(i1_06_`x')
			label variable `x'_cons "quantity consumed (kg)"
			label variable `x'_sold "quantity sold (kg)"
			drop i1_06_`x'
			drop i1_10_`x'
		}	
	* Distance and time to sale point (km)(i1_12a; i1_12b) and sale price (i1_13)
			forvalues i = 11/20 {
				replace i1_12a_rice = i1_12a if crop == `i'
				replace i1_12b_rice = i1_12b if crop == `i'
				replace i1_13_rice = i1_13 if crop == `i'
			}
			forvalues i = 21/22 {
				replace i1_12a_wheat = i1_12a if crop == `i'
				replace i1_12b_wheat = i1_12b if crop == `i'
				replace i1_13_wheat = i1_13 if crop == `i'
			}	
			replace i1_12a_maize = i1_12a if crop == 23
			replace i1_12b_maize = i1_12b if crop == 23
			replace i1_13_maize  = i1_13  if crop == 23
			forvalues i = 26/28 {
				replace i1_12a_millet = i1_12a if crop == `i'
				replace i1_12b_millet = i1_12b if crop == `i'
				replace i1_13_millet = i1_13 if crop == `i'
			}	
			forvalues i = 51/55 {
				replace i1_12a_pulses = i1_12a if crop == `i'
				replace i1_12b_pulses = i1_12b if crop == `i'
				replace i1_13_pulses = i1_13 if crop == `i'
			}	
			forvalues i = 57/58 {
				replace i1_12a_pulses = i1_12a if crop == `i'
				replace i1_12b_pulses = i1_12b if crop == `i'
				replace i1_13_pulses = i1_13 if crop == `i'
			}	
			replace i1_12a_pulses = i1_12a if crop == 111
			replace i1_12b_pulses = i1_12b if crop == 111
			replace i1_13_pulses  = i1_13  if crop == 111
			replace i1_12a_pulses = i1_12a if crop == 126
			replace i1_12b_pulses = i1_12b if crop == 126
			replace i1_13_pulses  = i1_13  if crop == 126
		foreach x in "rice" "wheat" "maize" "millet" "pulses" {
			bysort a01: egen `x'_travel_km  = mean(i1_12a_`x')
			bysort a01: egen `x'_travel_min = mean(i1_12b_`x')
			bysort a01: egen `x'_sale_price = mean(i1_13_`x')
			label variable `x'_travel_km "average, how far to sale point (km)"
			label variable `x'_travel_min "average, time taken to travel (minute)"
			label variable `x'_sale_price "average, sale price (taka)"
			drop i1_12a_`x' i1_12b_`x' i1_13_`x'
		}	
	* Cleaning and close
		drop if dup > 1
		keep a01 crop_count-pulses_sale_price
 	save "$BIHS_11\019_mod_i1_male_EDIT.dta", replace

** 020_mod_i2_male (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\020_mod_i2_male.dta", replace		
		
** 021_mod_j1_male (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\021_mod_j1_male.dta", replace

** 022_mod_j2_male (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\022_mod_j2_male.dta", replace	

** 023_mod_k1_male (9919, HH-livestock, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\023_mod_k1_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	foreach x in "bullock" "milkcow" "bufallo" "goat" "sheep" "chicken" "duck" "otherbirds" "others" {
		gen `x'_D2010 = 0
		gen `x'_N2011 = 0
	}
	replace bullock_D2010 = k1_02a if livestock    == 1
	replace milkcow_D2010 = k1_02a if livestock    == 2
	replace bufallo_D2010 = k1_02a if livestock    == 3
	replace goat_D2010 =    k1_02a if livestock    == 4
	replace sheep_D2010 =   k1_02a if livestock    == 5
	replace chicken_D2010 = k1_02a if livestock    == 6
	replace duck_D2010 =    k1_02a if livestock    == 7
	replace otherbirds_D2010 = k1_02a if livestock == 8
	replace others_D2010 =  k1_02a if livestock    == 9	
	replace bullock_N2011 = k1_03a if livestock    == 1
	replace milkcow_N2011 = k1_03a if livestock    == 2
	replace bufallo_N2011 = k1_03a if livestock    == 3
	replace goat_N2011 =    k1_03a if livestock    == 4
	replace sheep_N2011 =   k1_03a if livestock    == 5
	replace chicken_N2011 = k1_03a if livestock    == 6
	replace duck_N2011 =    k1_03a if livestock    == 7
	replace otherbirds_N2011 = k1_03a if livestock == 8
	replace others_N2011 =  k1_03a if livestock    == 9
	keep a01 dup bullock_D2010-others_N2011
	foreach x in "bullock" "milkcow" "bufallo" "goat" "sheep" "chicken" "duck" "otherbirds" "others" {
		bysort a01: egen `x'_D10 = total(`x'_D2010)
		bysort a01: egen `x'_N11 = total(`x'_N2011)
		drop `x'_D2010 `x'_N2011
		label variable `x'_D10 "how many of the asset were there on december 1, 2010"
		label variable `x'_N11 "how many of the asset were there on november 30, 2011"
	}
	drop if dup > 1
 	save "$BIHS_11\023_mod_k1_male_EDIT.dta", replace
	
** 024_mod_k2_male (8153, HH-AnimProd, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\024_mod_k2_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	* where milk (1); egg (2); manure (3)
	foreach x in "milk" "egg" "manure" {
		gen `x'_m = 0
	}
	replace milk = k2_02 if bprod == 1 
	label variable milk "how much did you produce in the last 12 months? (litre)"
	replace egg = k2_02 if bprod == 2
	label variable egg "how much did you produce in the last 12 months? (no.)"	
	replace manure = k2_02 if bprod == 3
	label variable manure "how much did you produce in the last 12 months? (kg)"	
	foreach x in "milk" "egg" "manure" {
		bysort a01: egen `x' = total(`x'_m)
		drop `x'_m
	}
	label variable milk "how much did you produce in the last 12 months? (litre)"
	label variable egg "how much did you produce in the last 12 months? (no.)"	
	label variable manure "how much did you produce in the last 12 months? (kg)"
	drop if dup > 1
	keep a01 milk egg manure	
	save "$BIHS_11\024_mod_k2_male_EDIT.dta", replace

** 025_mod_k3_male (9999, HH-livestock, a01, - ) - AGGREGATE on (a01)
	//use "$BIHS_11\025_mod_k3_male.dta", replace	
	* tabstat k3_02-k3_05, by(k3_01) stat(mean sd)
	* LIVESTOCK ownership costs--not super relevant	
	
** 026_mod_l1_male (2611, HH-pond, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\026_mod_l1_male.dta", replace	
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	gen open_water_m = 0
	replace open_water = 1 if pondid == 999	
	bysort a01: egen total_pond_cost = total(l1_09)
	bysort a01: egen total_pond_harv  = total(l1_11)
	bysort a01: egen total_pond_area = total(l1_01)
	bysort a01: egen open_water = total(open_water_m)
	replace open_water = 1 if open_water > 0
	label variable total_pond_cost "total cost (taka) summed across ponds"
	label variable total_pond_harv "total quantity of collection/harvest (kg)"
	label variable total_pond_area "total area of pond in decimal, open water a different variable"
	label variable open_water "uses open water for on-farm fish production == 1"
	drop if dup > 1
	keep a01 total_pond_cost total_pond_harv total_pond_area open_water
	save "$BIHS_11\026_mod_l1_male_EDIT.dta", replace
	
** 027_mod_l2_male (9465, HH-fish, a01, - ) - AGGREGATE on (a01)
use "$BIHS_11\027_mod_l2_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen total_fish_cons = total(l2_06)
	bysort a01: egen total_fish_sold = total(l2_10)	
	bysort a01: egen total_fish_value = total(l2_12)	
	label variable total_fish_cons "total amount of fish consumed by the HH (kg)"
	label variable total_fish_sold "total quantity of fish sold"
	label variable total_fish_value "total value of selling fish (taka)"
	keep a01 dup total_fish_cons total_fish_sold total_fish_value
	drop if dup > 1
	save "$BIHS_11\027_mod_l2_male_EDIT.dta", replace
	
** 028_mod_m1_male (3730, HH-sales, a01, m1_01) - AGGREGATE on (m1_01)
	use "$BIHS_11\028_mod_m1_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	drop if m1_02 > 2
	replace m1_06 = m1_06*40 if m1_07 == 1
	ttest m1_17 , by(m1_02)
	bysort a01 m1_01: egen mean_sale_dist_km = mean(m1_17)
	bysort a01 m1_01: egen mean_sale_dist_min = mean(m1_18)
	bysort a01 m1_01: egen mean_rice_price = mean(m1_09)	
	bysort a01 m1_01: egen mean_paddy_price = mean(m1_09)	
	bysort a01 m1_01: egen total_rice_sold_q = total(m1_06)
	bysort a01 m1_01: egen total_paddy_sold_q = total(m1_06)
	label variable total_rice_sold_q  "Total rice sold by HH (kg), across months"
	label variable total_paddy_sold_q "Total paddy sold by HH (kg), across months"	
	label variable mean_sale_dist_km  "average dist to sale (km), by commodity"
	label variable mean_sale_dist_min "average dist to sale (min), by commodity"
	label variable mean_paddy_price "Average price rec'd per unit (taka)"
	label variable mean_rice_price "Average price rec'd per unit (taka)"
	drop if dup > 1
	keep a01 mean_sale_dist_km mean_sale_dist_min mean_rice_price mean_paddy_price total_rice_sold total_paddy_sold_q 
	save "$BIHS_11\028_mod_m1_male_EDIT.dta", replace
	
** 029_mod_m2_male (6879, HH-sales, a01, m2_01) - AGGREGATE on (a01)
//use "$BIHS_11\029_mod_m2_male.dta"
	* animal product sales, not much of anything
	* tab m2_02 // largest share is 11.4% and "other" is massive (53%)	
	
** 030_mod_n_male (6982, HH-SME, a01, rid) - AGGREGATE on (a01)
	use "$BIHS_11\030_mod_n_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	drop if n01 == 2
	gen n = 1
	bysort a01: egen nonfarm_business = total(n)
	label variable nonfarm_business "has anyone in your HH owned or operated any non-farm economic gen.., total # firms"
	drop if dup > 1
	keep a01 nonfarm_business
	save "$BIHS_11\030_mod_n_male_EDIT.dta", replace	
	
** 031_mod_o1_female (185875, HH-FoodCons, a01, o1_01) - AGGREGATE on (a01)
	use "$BIHS_11\031_mod_o1_female.dta", replace	
	** Need to split the foods into HDDS, FCS groups
	* I have a separate file to do this now.
	* Merge the files
	* convert all units to the same unit--here, grams (?)
	* since using FCS, might need only count incidence of foods within the week	

** 032_mod_o2_female (17724, HH-FoodCons, a01, o2_02) - AGGREGATE on (a01)
	use "$BIHS_11\032_mod_o2_female.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	tab o2_02, generate(o2_02)
	forvalues i = 1/6 {
		replace o2_02`i' = o2_03*o2_02`i' if o2_02 == `i'
	}
	bysort a01: egen paddy_cons = total(o2_021)  // be wary of units
	bysort a01: egen rice_cons = total(o2_022)   // be wary of units
	bysort a01: egen atta_cons = total(o2_023)   // be wary of units
	bysort a01: egen cookoil_cons = total(o2_024) // be wary of units
	bysort a01: egen pulse_cons = total(o2_025)  // be wary of units
	bysort a01: egen nostock_cons = total(o2_026) // be wary of units
	drop if dup > 1
	keep a01 paddy_cons-nostock_cons
	save "$BIHS_11\032_mod_o2_male_EDIT.dta", replace	

** 033_mod_p1_male (78481, HH-NonFoodExp, a01, p1_01) - AGGREGATE on (a01)
	//use "$BIHS_11\033_mod_p1_male.dta"
	** Non-food expenditures, like {firewood, manure, kerosene, etc.}

** 034_mod_p2_male (157493, HH-NonFoodExp, a01, p2_01) - AGGREGATE on (a01)
	//use "$BIHS_11\034_mod_p2_male.dta"
	** Non-food expenditures, like {dowry, clothing, etc.}

** 035_mod_q_male (6503, HH, a01, - ) - AGGREGATE on (a01)
	use "$BIHS_11\035_mod_q_male.dta", replace

** 036_mod_r_male (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\036_mod_r_male.dta", replace
	
** 037_mod_s_male (91042, HH-HCFaci, a01, s_01) - AGGREGATE on (a01)
	use "$BIHS_11\037_mod_s_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	foreach x in "hospital" "busstop" "mainroad" "nexttown" "agextension" {
		gen `x'_d_km  = 0
		gen `x'_d_min = 0	
	}	
	replace hospital_d_km = s_04 if s_01 == 1
	replace hospital_d_min = (s_05*60)+s_06 if s_01 == 1
	replace busstop_d_km = s_04 if s_01 == 2
	replace busstop_d_min = (s_05*60)+s_06 if s_01 == 2
	replace mainroad_d_km = s_04 if s_01 == 3
	replace mainroad_d_min = (s_05*60)+s_06 if s_01 == 3
	replace nexttown_d_km = s_04 if s_01 == 7
	replace nexttown_d_min = (s_05*60)+s_06 if s_01 == 7
	replace agextension_d_km = s_04 if s_01 == 9
	replace agextension_d_min = (s_05*60)+s_06 if s_01 == 9
	foreach x in "hospital" "busstop" "mainroad" "nexttown" "agextension" {
		bysort a01: egen `x'_dist_km = total(`x'_d_km)
		label variable `x'_dist_km "how long (km) does it normally take to travel from your house to the nearest"
		bysort a01: egen `x'_dist_min = total(`x'_d_min)
		label variable `x'_dist_min "how long (min) does it normally take to travel from your house to the nearest"
	}
	drop if dup > 1
	keep a01 hospital_dist_km- agextension_dist_min
	save "$BIHS_11\037_mod_s_male_EDIT.dta", replace	

**# HERE FOR SHOCK EDITS

** 038_mod_t1_male (4897, HH-NegShocks, a01, t1_02) - AGGREGATE on (a01)
	use "$BIHS_11\038_mod_t1_male.dta", replace
		* Generals
			sort a01
			quietly by a01 : gen dup = cond(_N==1, 0, _n)
		* Total number of shocks experienced in past 5 years
			bysort a01: egen shock_count_5y = total(t1_03)
			tab t1_02, generate(t1_02)		
			* Total 5Y number of shocks: health/death, weather, ag losses
				gen health_shocks_5y = t1_021+t1_022+t1_023+t1_024
				gen weather_shocks_5y = t1_026+t1_029+t1_0210+t1_0211+t1_0214
				gen ag_shocks_5y = t1_029+t1_021+t1_0211+t1_0212+t1_0213+ ///
					t1_0214 + t1_0215 // crop & livestock losses
			* Total number of shocks experienced in 2010-2012 range
				foreach x of varlist t1_021-t1_0235 {
					quietly replace `x' = . if t1_05 < 2010
				}
				replace t1_03 = . if t1_05 < 2010
				bysort a01: egen shock_count_2y = total(t1_03)
				gen health_shocks_2y = t1_021+t1_022+t1_023+t1_024
				gen weather_shocks_2y = t1_026+t1_029+t1_0210+t1_0211+t1_0214
				gen ag_shocks_2y = t1_029+t1_021+t1_0211+t1_0212+t1_0213+ ///
					t1_0214 + t1_0215 // crop & livestock losses
			* Total number of shocks ongoing
				foreach x of varlist t1_021-t1_0235 {
					quietly replace `x' = . if t1_09 != 999
				}				
				replace t1_03 = . if t1_09 != 999
				bysort a01: egen shock_count_ONG = total(t1_03)
				gen health_shocks_ONG = t1_021+t1_022+t1_023+t1_024
				gen weather_shocks_ONG = t1_026+t1_029+t1_0210+t1_0211+t1_0214
				gen ag_shocks_ONG = t1_029+t1_021+t1_0211+t1_0212+t1_0213+ ///
					t1_0214 + t1_0215 // crop & livestock losses
			* Clean and drop variables associated with shocks
				drop t1_021-t1_0235
				foreach x in 5y 2y ONG {
					replace shock_count_`x' = 0 if shock_count_`x' == .
					replace health_shocks_`x' = 0 if health_shocks_`x' == .
					replace weather_shocks_`x' = 0 if weather_shocks_`x' == .
					replace ag_shocks_`x' = 0 if ag_shocks_`x' == .
				}
		** Coping Strategies (beginning of CSI)	
			gen csi0_a = .
				replace csi0_a = 1 if t1_08a != .
				replace csi0_a = 2 if t1_08b != .
				replace csi0_a = 3 if t1_08c != .
				bysort a01: egen coping_count_5y = total(csi0_a)
			* Total coping if in 2010-2012 range
				replace t1_08a = . if t1_05 < 2010
				replace t1_08b = . if t1_05 < 2010 
				replace t1_08c = . if t1_05 < 2010 
					replace csi0_a = . 
					replace csi0_a = 1 if t1_08a != .
					replace csi0_a = 2 if t1_08b != .
					replace csi0_a = 3 if t1_08c != .
				bysort a01: egen coping_count_2y = total(csi0_a) 
			* Total coping if in ongoing
				replace t1_08a = . if t1_09 != 999
				replace t1_08b = . if t1_09 != 999  
				replace t1_08c = . if t1_09 != 999  
					replace csi0_a = . 
					replace csi0_a = 1 if t1_08a != .
					replace csi0_a = 2 if t1_08b != .
					replace csi0_a = 3 if t1_08c != .
				bysort a01: egen coping_count_ONG = total(csi0_a) 				
			* Clean-up
				drop if dup > 1				
				keep a01 health_shocks* weather_shocks* ag_shocks* ///
					shock_count* coping*
		save "$BIHS_11\038_mod_t1_male_EDIT.dta", replace
	
** 039_mod_t2_male (78377, HH-PosShocks, a01, t2_02) - AGGREGATE on (a01)
	use "$BIHS_11\039_mod_t2_male.dta", replace 	
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	* Summing total number of positive shocks
	gen pshc = 0
	replace pshc = 1 if t2_03 == 1
	bysort a01: egen pos_shocks_count = total(pshc)
	drop if pos_shocks_count == 0
	* Top 4 most likely shocks
		gen new_job_s = 0 
		gen more_remit_s = 0 
		gen educ_stipend_s = 0 // both primary and secondary
		replace new_job_s = 1 if t2_02 == 1
		replace more_remit_s = 1 if t2_02 == 2
		replace educ_stipend_s = 1 if t2_02 == 9 | t2_02 == 10 
		bysort a01: egen new_job_shock = total(new_job_s)
		bysort a01: egen more_remit_shock = total(more_remit_s)
		bysort a01: egen educ_stipend_shock  = total(educ_stipend_s)
	drop if dup > 1
	keep a01 new_job_shock-educ_stipend_shock pos_shocks_count
	save "$BIHS_11\039_mod_t2_male_EDIT.dta", replace

** 040_mod_u_male (279629, ind, a01, mid_1/mid_2) - merge on (a01, mid_1/mid_2)
	use "$BIHS_11\040_mod_u_male.dta", replace
		sort a01
		quietly by a01 : gen dup = cond(_N==1, 0, _n)
		* Count if HH has received any type of assitance
			drop if u01 == 2
			bysort a01: egen SSP_count = count(u01)
		* Summing cash and food assistance
			gen cash_a = u02
				gen x = (u03*u04)
				replace x = 0 if x == .
				gen y = (u05*u06)
				replace y = 0 if y == .
				gen z = (u07) + (u08)
				replace z = 0 if z == .
			gen food_a = x+y+z
			bysort a01: egen cash_assist = total(cash_a)
			bysort a01: egen food_assist = total(food_a)
			drop if dup > 1
			keep a01 cash_assist food_assist SSP_count
		save "$BIHS_11\040_mod_u_male_EDIT.dta", replace	

** 041_mod_v1_male (6828, ind, a01, pid) - merge on (a01, pid...migration)
	use "$BIHS_11\041_mod_v1_male.dta", replace	
		sort a01
		quietly by a01 : gen dup = cond(_N==1, 0, _n)
		* Did anyone migrate (y/n)
		drop if v1_01 == 2
		bysort a01: egen total_mig = total(v1_01)
		* Migrated: domestic or foreign
		gen foreign_m = 0
		gen domesti_m = 0
		replace foreign_m = 1 if v1_11 != .
		replace domesti_m = 1 if v1_10 != .
		bysort a01: egen foreig_mig = total(v1_11)
		bysort a01: egen domest_mig = total(v1_10)
		gen any_r = 0
		replace any_r = 1 if v1_14 == 1
		bysort a01: egen any_remit1 = total(any_r)  // there are 2 remit questions
		drop if dup > 1
		keep a01 foreig_mig domest_mig any_remit1 total_mig
	save "$BIHS_11\041_mod_v1_male_EDIT.dta", replace

** 042_mod_v2_male (6847, ind, a01, pid) - merge on (a01, pid...remittances)
	use "$BIHS_11\042_mod_v2_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	* How many remittances streams being accepted?
	gen any_r2 = 0
	gen domest_r_b = 0
	gen foreig_r_b = 0 
	replace any_r2 = 1 if v2_01 == 1
	replace domest_r_b = 1 if v2_03 == 1
	replace foreig_r_b = 1 if v2_04 == 1	
	bysort a01: egen any_remit2 = total(any_r2)
	bysort a01: egen domest_remit_b = total(domest_r_b)
	bysort a01: egen foreig_remit_b = total(foreig_r_b)
	bysort a01: egen total_remit_q = total(v2_06)
	label variable total_remit_q "total, how much money in total did your HH receive in the last 12 months"
	drop if dup > 1	
	keep a01 any_remit2 domest_remit_b foreig_remit_b total_remit_q
	save "$BIHS_11\042_mod_v2_male_EDIT.dta", replace

** 043_mod_v3_male (6525, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\043_mod_v3_male.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	drop if v3_01 == 2
	* Total number HH members sending remittances
	gen remit_out_c = 1 if v3_01 == 1
	bysort a01: egen remit_out_count = total (remit_out_c)
		label variable remit_out_count "during the past 12 months, did the HH send any remittances"
	* Total remittance value sent (foreig, domest)
	gen remit_out_f = 0 
	gen remit_out_d = 0
	replace remit_out_f = v3_07 if v3_04 != .
	replace remit_out_d = v3_07 if v3_03 != .
	bysort a01: egen remit_out_foreig = total(remit_out_f)
		label variable remit_out_foreig "how much remittances sent to foreign place, past 12 months"
	bysort a01: egen remit_out_domest = total(remit_out_d)
		label variable remit_out_domest "how much remittances sent to domestic place, past 12 months"
	drop if dup > 1
	keep a01 remit_out_count remit_out_foreig remit_out_domest
	save "$BIHS_11\043_mod_v3_male_EDIT.dta", replace

** 044_mod_v4_male (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\044_mod_v4_male.dta", replace	
	
** 045_mod_w1_female (24374, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\045_mod_w1_female.dta", replace
	* can merge on (a01, mid)
	* can also merge on a01 if you drop on condition (mid > 1)
	
** 046_mod_w2_female (2911, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\046_mod_w2_female.dta", replace
	* can merge on (a01, mid); all mid values are >1
	* newborn data; not useful
	
** 047_mod_w3_female (17393, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\047_mod_w3_female.dta", replace
	* lots of questions about HH member's physical state e.g. walk 5km, etc.	
	* Not useful, but unique on (a01, mid)

** 048_mod_w4_female (27277, ind, a01, mid) - merge on (a01, mid)
	use "$BIHS_11\048_mod_w4_female.dta", replace
	* recent HH illnesses by HH member
	* Not useful, but unique on (a01, mid)
	
** 049_mod_x1_female (58192, HH, a01, - ) - AGGREGATE on (a01)
	//use "$BIHS_11\049_mod_x1_female.dta", replace
	* ingredients used in food for teh recall period of one day
	* raw weights and list of ingredients, also...menu?
	* Not useful	
	
** 050_mod_x2_female (293177, HH, a01, - ) - AGGREGATE on (a01)
	//use "$BIHS_11\050_mod_x2_female.dta", replace
	* information on guests eating at the house. 
	* not particularly useful
	
** 051_mod_x3_female (6503, HH, a01, rid) - merge on (a01)
	use "$BIHS_11\051_mod_x3_female.dta", replace
	* Food security module	
	
** 052_mod_y1_female (6503, HH, a01, father/mother/child_id) - merge on (a01)
	//use "$BIHS_11\052_mod_y1_female.dta", replace
	* not particularly useful; just lists what foods newborn eats
	
** 053_mod_y2_female (5503, HH, a01, - ) - merge on (a01)
	//use "$BIHS_11\053_mod_y2_female.dta", replace
	* maternal knowledge of WASH, breastfeeding, food for children, etc.
	
** 054_mod_y3_female (5503, HH, a01, - ) - merge on (a01)
	//use "$BIHS_11\054_mod_y3_female.dta", replace
	* maternal knowledge of WASH, breastfeeding, food for children, etc.	
	
** 055_mod_y4_female (6503, HH, a01, child_id_y4) - merge on (a01)
	//use "$BIHS_11\055_mod_y4_female.dta", replace	
	* child illnesses, immunization, vitamins, deworming, etc.
	
** 056_mod_y5_female (6503, HH, a01, child_id_y5) - merge on (a01)
	//use "$BIHS_11\056_mod_y5_female.dta", replace
	* info about children for new mothers, delivery detail, food/vitamins	

** 057_mod_y6_female (5503, HH, a01, - ) - merge on (a01)
	//use "$BIHS_11\057_mod_y6_female.dta", replace
	* questions about attendance to CNC (child development center)

** 058_mod_y7_female (6503, HH, a01, - ) - merge on (a01)
	//use "$BIHS_11\058_mod_y7_female.dta", replace
	* questions on pusti packet, supplementary feeding and growth monitoring
	
** 059_mod_y8_female (5503, HH, a01, - ) - merge on (a01)
	//use "$BIHS_11\059_mod_y8_female.dta", replace
	* questions on whether or not health workers visited the HH, children

** 060_mod_z1_female (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\060_mod_z1_female.dta", replace
	* questions about female empowerment in HH and region, labor focus	
	
** 061_mod_z2_female (5503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\061_mod_z2_female.dta", replace
	* questions about female empowerment in HH and region, travel focused	
	
** 062_mod_z3_female (6503, HH, a01, - ) - merge on (a01) 
	use "$BIHS_11\062_mod_z3_female.dta", replace
	* questions about birth control
	
** 063_mod_z4_female (6503, HH, a01, - ) - merge on (a01) 
	use "$BIHS_11\063_mod_z4_female.dta", replace
	* domestic conflict questions

** 064_mod_z5_female (16287, HH, a01, - ) - AGGREGATE on (a01)
	//use "$BIHS_11\064_mod_z5_female.dta", replace
	* questions about value of assets transfered F->HH during/after marraige	
	* not super useful

///////////////////////////////////////////////////////////////////////////////

** SAMPLING WEIGHTS (6503, HH, a01, - )
	use "$BIHS_11\BIHS_FTF baseline sampling weights.dta", replace

///////////////////////////////////////////////////////////////////////////////

** 001_mod_ca_cb_cc_ce_community (50, sl, ca01, - ) - merge on (ca01)?
	use "$BIHS_11\001_mod_ca_cb_cc_ce_community.dta", replace
	* unique on (village) (village code, generate)
	* contains the sl variable from below

** 002_mod_ca08-ca011_community (171, sl, member, - ) - merge on (sl)?
	use "$BIHS_11\002_mod_ca08-ca011_community.dta", replace
	* unique on (isid, member)

** 003_mod_cb02-cb07_community (850, sl, - , - ) - merge on (sl)?
	use "$BIHS_11\003_mod_cb02-cb07_community.dta", replace
	* needs to be wide on (cb02), maybe two datasets--one with market specific
	* public good/services locations with coordinates
	
** 004_mod_cd_community (150, sl, - , - ) - merge on (sl)?
	use "$BIHS_11\004_mod_cd_community.dta", replace
	* needs to be wide on cd01, can be one datasets
	* health services locations/presence and coordinates

** 005_mod_cf_community (1203, sl, - , - ) - merge on (sl)?
	use "$BIHS_11\005_mod_cf_community.dta", replace
	* way too many educ services to make it wide; if only "yes" then manageable
	* education services locations/presence and coordinates

** 006_mod_cg_community (317, sl, - , - ) - merge on (sl)?
	use "$BIHS_11\006_mod_cg_community.dta", replace
	* ngo presence and services provided

** 007_mod_ci_community (2150, sl, - , - ) - merge on (sl)?
	use "$BIHS_11\New Comm2011\module_ci.dta", replace
	* list of social safety net programs available and if HH mem participated
	
** 008_mod_ck_community (700, sl, - , - ) - merge on (sl)?
	use "$BIHS_11\008_mod_ck_community.dta", replace
	* questions about ag labor in the area

///////////////////////////////////////////////////////////////////////////////

** Base Data CENSUS (47027, ind, a01, mid)
use "$BIHS_11\001_census_ftf.dta", replace

///////////////////////////////////////////////////////////////////////////////
