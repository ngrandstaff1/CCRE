**************************
**************************
** BIHS Clean Data 2019 ** ** (Key: n, level, id1, id2)
**     N.Grandstaff     **
**************************
**************************
clear all

*--------------------*
* Directory for 2019 *
*--------------------*
	global BIHS_19m "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Male"
	global BIHS_19f "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Female"
	global BIHS_19comm "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Community"
	

*--------------------*
*  BIHS 2019 HH Data *
*--------------------*
** 009_bihs_r3_male_mod_a (6011, ind, a01, res_id_a)
    use "$BIHS_19m\009_bihs_r3_male_mod_a.dta", replace	

** 092_bihs_r3_female_mod_a (6011, ind, a01, res_id_a)
    use "$BIHS_19f\092_bihs_r3_female_mod_a.dta", replace

** 010_bihs_r3_male_mod_b1 (32332, ind, a01, mid)
    use "$BIHS_19m\010_bihs_r3_male_mod_b1.dta", replace

** 011_bihs_r3_male_mod_b2 (10216, ind, a01, mid_b2)
    use "$BIHS_19m\011_bihs_r3_male_mod_b2.dta", replace
	ren mid_b2 mid
	save "$BIHS_19m\011_bihs_r3_male_mod_b2_EDIT.dta", replace

** 012_bihs_r3_male_mod_c (27752, ind, a01, mid_c)
    use "$BIHS_19m\012_bihs_r3_male_mod_c.dta", replace
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
	drop c02 c03 c04 c06 c07 c08 c13 c14 
	drop if dup > 1 
	drop dup
	ren mid_c mid
	save "$BIHS_19m\012_bihs_r3_male_mod_c_EDIT.dta", replace

** 013_bihs_r3_male_mod_c1 (134520, ind, res_id_c1)
	//use "$BIHS_19m\013_bihs_r3_male_mod_c1.dta", replace
	** not a module from BIHS_11

** 014_bihs_r3_male_mod_c3 (18590, ind, a01, mid_c3)
	//use "$BIHS_19m\014_bihs_r3_male_mod_c3.dta", replace
	** not a module from BIHS_11

** 015_bihs_r3_male_mod_d1 (102180, ind, a01, res_id_d)
	//use "$BIHS_19m\015_bihs_r3_male_mod_d1.dta"

** 016_bihs_r3_male_mod_d2 (15560, HH, a01, - ) - AGGREGATE on (a01)
    use "$BIHS_19m\016_bihs_r3_male_mod_d2.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen d2_10_a = total(d2_10)
	label variable d2_10_a "current total value if asset(s) sold today how much will you receive?"
	drop if dup > 1
	keep a01 d2_10_a 
	save "$BIHS_19m\016_bihs_r3_male_mod_d2_EDIT.dta", replace

** 017_bihs_r3_male_mod_e (7543, ind, a01, mid_e)
    use "$BIHS_19m\017_bihs_r3_male_mod_e.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen e02_a = min(e02)
	label variable e02_a "does any adult in the household currently have any savings"
	bysort a01: egen e06_a = total(e06)
	label variable e06_a "household total amount currently saved"	
	drop if dup > 1
	keep a01 e02_a e06_a
	save "$BIHS_19m\017_bihs_r3_male_mod_e_EDIT.dta", replace

** 018_bihs_r3_male_mod_f (8301, ind, a01, mid_f)
    use "$BIHS_19m\018_bihs_r3_male_mod_f.dta", replace
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
	save "$BIHS_19m\018_bihs_r3_male_mod_f_EDIT.dta", replace
	
** 019_bihs_r3_male_mod_xxc (5605, ind, a01, res_id_xxc)
	//use "$BIHS_19m\019_bihs_r3_male_mod_xxc.dta", replace
	** not a module from BIHS_11

** 020_bihs_r3_male_mod_g (31920, HH-plots, a01, plotid) - AGGREGATE on (a01)
    use "$BIHS_19m\020_bihs_r3_male_mod_g.dta", replace
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
	save "$BIHS_19m\020_bihs_r3_male_mod_g_EDIT.dta", replace

** 021_bihs_r3_male_mod_h1 (17537, HH-plots, a01, plotid_h1) - AGGREGATE on (a01)
    use "$BIHS_19m\021_bihs_r3_male_mod_h1.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	bysort a01: egen h1_03_a = total(h1_03)
	label variable h1_03_a "total area planted"
	// bysort a01: egen h1_06_a = total(h1_06) // missing in BIHS15
	bysort a01: egen h1_07_a = total(h1_07)
	bysort a01: egen h1_08_a = total(h1_08)
	label variable h1_07_a "Cost of Seed: If source of seeds is 1 or 2 then record the approximate value of"
	label variable h1_08_a "total, Seedling cost"
	//label variable h1_06_a "total cost of seed"
	drop if dup > 1
	keep a01 h1_03_a h1_07 h1_08
	save "$BIHS_19m\021_bihs_r3_male_mod_h1_EDIT.dta", replace

** 022_bihs_r3_male_mod_h2 (17537, HH-plots, a01, plotid_h2) - AGGREGATE on (a01)
    use "$BIHS_19m\022_bihs_r3_male_mod_h2.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	bysort a01: egen h2_05_a = total(h2_05)
	label variable h2_05_a "total cash cost of irrigation"
	drop if dup > 1
	keep a01 h2_05_a
	save "$BIHS_19m\022_bihs_r3_male_mod_h2_EDIT.dta", replace
	
** 023_bihs_r3_male_mod_h3 (17537, HH-plots, a01, plotid_h3) - AGGREGATE on (a01)
    use "$BIHS_19m\023_bihs_r3_male_mod_h3.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)		
	bysort a01: egen h3_10_a = total(h3_10)
	label variable h3_10_a "total value of manure/compost in use (taka)"
	gen h3_11 = h3_11a + h3_11b + h3_11c
	drop h3_11a h3_11b h3_11c
	bysort a01: egen h3_11_a = total(h3_11)
	label variable h3_11_a "total value of pesticide/insecticides/herbicides in use (taka)"
	drop if dup > 1
	keep a01 h3_10_a h3_11_a 
	save "$BIHS_19m\023_bihs_r3_male_mod_h3_EDIT.dta", replace

** 024_bihs_r3_male_mod_h4 (17537, HH-plots, a01, plotid_h4) - AGGREGATE on (a01)
    use "$BIHS_19m\024_bihs_r3_male_mod_h4.dta", replace
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	gen h4_04 = h4_04_1+h4_04_2+h4_04_3 // needed to be added between 25->19
	gen h4_05 = h4_05_1+h4_05_2 // needed to be added between 25->19
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
	save "$BIHS_19m\024_bihs_r3_male_mod_h4_EDIT.dta", replace

** 025_bihs_r3_male_mod_h5 (17537, HH-plots, a01, plotid_h5) - AGGREGATE on (a01)
    use "$BIHS_19m\025_bihs_r3_male_mod_h5.dta", replace	
	sort a01 
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	gen mlabor_house_crop =	h5_01+h5_07+h5_19+h5_25+h5_31+h5_37+h5_43
	gen mlabor_hired_crop =	h5_03+h5_09+h5_21+h5_27+h5_33+h5_39+h5_45
	gen flabor_house_crop = h5_02+h5_08+h5_20+h5_26+h5_32+h5_38+h5_44
	gen flabor_hired_crop = h5_05+h5_11+h5_23+h5_29+h5_35+h5_41+h5_47
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
	save "$BIHS_19m\025_bihs_r3_male_mod_h5_EDIT.dta", replace

** 026_bihs_r3_male_mod_h6 (9734, HH-crops, a01, crop_h6) - AGGREGATE on (a01)
    use "$BIHS_19m\026_bihs_r3_male_mod_h6.dta", replace
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
	save "$BIHS_19m\026_bihs_r3_male_mod_h6_EDIT.dta", replace

** 027_bihs_r3_male_mod_h7 (40849, HH, a01, - ) - AGGREGATE on (a01)
    use "$BIHS_19m\027_bihs_r3_male_mod_h7.dta", replace
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
	save "$BIHS_19m\027_bihs_r3_male_mod_h7_EDIT.dta", replace

** 028_bihs_r3_male_mod_h7a (29101, HH, a01, - ) - AGGREGATE on (a01)
    use "$BIHS_19m\028_bihs_r3_male_mod_h7a.dta", replace
	** NOTE THIS EXISTS HERE BUT NOT IN BIHS11
	** NOTE THIS EXISTS HERE BUT NOT IN BIHS11 -- Wage rates by season
	** NOTE THIS EXISTS HERE BUT NOT IN BIHS11

** 029_bihs_r3_male_mod_h8 (5605, HH, a01, - ) - AGGREGATE on (a01)
    use "$BIHS_19m\029_bihs_r3_male_mod_h8.dta", replace

** 030_bihs_r3_male_mod_i1 (13073, ind, a01, res_id_i) - AGGREGATE on (a01)
    use "$BIHS_19m\030_bihs_r3_male_mod_i1.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)	
	* Number of crops produced by HH
	bysort a01: egen Crop_count = count(a01)
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
		keep a01 Crop_count-pulses_sale_price	
		ren Crop_count crop_count
	save "$BIHS_19m\030_bihs_r3_male_mod_i1_EDIT.dta", replace

** 031_bihs_r3_male_mod_i2 (5605, HH, a01, - ) 
    use "$BIHS_19m\031_bihs_r3_male_mod_i2.dta", replace
		
** 032_bihs_r3_male_mod_i2_1 (5605, HH, a01, - ) 
	//use "$BIHS_19m\032_bihs_r3_male_mod_i2_1.dta", replace
	** not a module from BIHS_11

** 033_bihs_r3_male_mod_i2a (16815, HH, a01, - ) - AGGREGATE on (a01)
	//use "$BIHS_19m\033_bihs_r3_male_mod_i2a.dta", replace
	** not a module from BIHS_11

** 034_bihs_r3_male_mod_i3 (21150, HH, a01, - ) - AGGREGATE on (a01)
	//use "$BIHS_19m\034_bihs_r3_male_mod_i3.dta", replace
	** not a module from BIHS_11

** 035_bihs_r3_male_mod_i4 (7281, HH-plots, a01, plotid_i4) - AGGREGATE on (a01)
	//use "$BIHS_19m\035_bihs_r3_male_mod_i4.dta", replace		
	** not a module from BIHS_11

** 036_bihs_r3_male_mod_ha (5605, ind, a01, res_id_ha) 
	//use "$BIHS_19m\036_bihs_r3_male_mod_ha.dta", replace		
	** not a module from BIHS_11

** 037_bihs_r3_male_mod_i5 (263435, ind, a01, res_id_i5) - AGGREGATE on (res_id_i5)
	//use "$BIHS_19m\037_bihs_r3_male_mod_i5.dta", replace
	** not a module from BIHS_11
	
** 038_bihs_r3_male_mod_j1 (5605, ind, a01, res_id_j)
    use "$BIHS_19m\038_bihs_r3_male_mod_j1.dta", replace

** 039_bihs_r3_male_mod_j1a (5605, HH, a01, - ) 
    use "$BIHS_19m\039_bihs_r3_male_mod_j1a.dta", replace

** 040_bihs_r3_male_mod_j2a (5605, HH, a01, - ) 
    use "$BIHS_19m\040_bihs_r3_male_mod_j2a.dta", replace

** 041_bihs_r3_male_mod_j2a7 (7271, HH, a01, - )
	//use "$BIHS_19m\041_bihs_r3_male_mod_j2a7.dta", replace
	** not a module from BIHS_11

** 042_bihs_r3_male_mod_j2a8 (6575, HH, a01, - )
	//use "$BIHS_19m\042_bihs_r3_male_mod_j2a8.dta", replace
	** not a module from BIHS_11

** 043_bihs_r3_male_mod_k1 (67248, ind, a01, res_id_k1) - AGGREGATE on (res_id_k1)
    use "$BIHS_19m\043_bihs_r3_male_mod_k1.dta", replace
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
	save "$BIHS_19m\043_bihs_r3_male_mod_k1_EDIT.dta", replace

** 044_bihs_r3_male_mod_itmp1a (5605, ind, a01, res_id_itmp1) - AGGREGATE on (res_id_itmp1)
	//use "$BIHS_19m\044_bihs_r3_male_mod_itmp1a.dta", replace
	** not a module from BIHS_11

** 045_bihs_r3_male_mod_itmp1b (5605, HH, a01, - )
	//use "$BIHS_19m\045_bihs_r3_male_mod_itmp1b.dta", replace
	** not a module from BIHS_11

** 046_bihs_r3_male_mod_itmp1c (5605, HH, a01, - )
	//use "$BIHS_19m\046_bihs_r3_male_mod_itmp1c.dta", replace
	** not a module from BIHS_11

** 047_bihs_r3_male_mod_itmp1d (5605, HH, a01, - )
	//use "$BIHS_19m\047_bihs_r3_male_mod_itmp1d.dta", replace
	** not a module from BIHS_11

** 048_bihs_r3_male_mod_k1a (5605, HH, a01, - )
	//use "$BIHS_19m\048_bihs_r3_male_mod_k1a.dta", replace
	** not a module from BIHS_11

** 049_bihs_r3_male_mod_k2 (22416, ind, a01, res_id_k23)
    use "$BIHS_19m\049_bihs_r3_male_mod_k2.dta", replace
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
	save "$BIHS_19m\049_bihs_r3_male_mod_k2_EDIT.dta", replace

** 050_bihs_r3_male_mod_k3 (22420, HH, a01, - ) - AGGREGATE on (a01)
	//use "$BIHS_19m\050_bihs_r3_male_mod_k3.dta", replace
	* LIVESTOCK ownership costs--not super relevant	

** 051_bihs_r3_male_mod_l1 (5797, ind, a01, res_ind_l)
    use "$BIHS_19m\051_bihs_r3_male_mod_l1.dta", replace	
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
	save "$BIHS_19m\051_bihs_r3_male_mod_l1_EDIT.dta", replace	

** 052_bihs_r3_male_mod_l2 (13625, HH, a01, - ) - AGGREGATE on (a01)
    use "$BIHS_19m\052_bihs_r3_male_mod_l2.dta", replace
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
	save "$BIHS_19m\052_bihs_r3_male_mod_l2_EDIT.dta", replace

** 053_bihs_r3_male_mod_itmp2a (5605, ind, a01, res_id_itmp2a)
	//use "$BIHS_19m\053_bihs_r3_male_mod_itmp2a.dta", replace
	** not a module from BIHS_11

** 054_bihs_r3_male_mod_itmp2b (5605, ind, a01, res_id_itmp2b)
	//use "$BIHS_19m\054_bihs_r3_male_mod_itmp2b.dta", replace
	** not a module from BIHS_11

** 055_bihs_r3_male_mod_itmp2c (5605, ind, a01, res_id_itmp2c)
//    use "$BIHS_19m\055_bihs_r3_male_mod_itmp2c.dta", replace
	** not a module from BIHS_11

** 056_bihs_r3_male_mod_l2a (5605, ind, a01, res_id_l2a) 
//    use "$BIHS_19m\056_bihs_r3_male_mod_l2a.dta", replace
	** not a module from BIHS_11

** 057_bihs_r3_male_mod_l2c (5731, ind, a01, res_id_l2c) 
//    use "$BIHS_19m\057_bihs_r3_male_mod_l2c.dta", replace
	** not a module from BIHS_11

** 058_bihs_r3_male_mod_m1 (7014, ind, a01, res_id_m)
    use "$BIHS_19m\058_bihs_r3_male_mod_m1.dta", replace
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
	save "$BIHS_19m\058_bihs_r3_male_mod_m1_EDIT.dta", replace

** 059_bihs_r3_male_mod_m2 (8486, HH, a01, - ) - AGGREGATE on (a01)
//    use "$BIHS_19m\059_bihs_r3_male_mod_m2.dta", replace	
	* animal product sales, not much of anything

** 060_bihs_r3_male_mod_n (5755, ind, a01, res_id_n)
    use "$BIHS_19m\060_bihs_r3_male_mod_n.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	drop if n01 == 2
	gen n = 1
	bysort a01: egen nonfarm_business = total(n)
	label variable nonfarm_business "has anyone in your HH owned or operated any non-farm economic gen.., total # firms"
	drop if dup > 1
	keep a01 nonfarm_business
	save "$BIHS_19m\060_bihs_r3_male_mod_n_EDIT.dta", replace

** 096_bihs_r3_female_mod_o1 (210837, ind, a01, res_id_o1)
    use "$BIHS_19f\096_bihs_r3_female_mod_o1.dta", replace
	** Need to split the foods into HDDS, FCS groups
	* I have a separate file to do this now.
	* Merge the files
	* convert all units to the same unit--here, grams (?)
	* since using FCS, might need only count incidence of foods within the week

** 097_bihs_r3_female_mod_o2 (28020, ind, a01, res_id_o2)
    use "$BIHS_19f\097_bihs_r3_female_mod_o2.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	tab o2_01, generate(o2_02) // updated from BIHS 15 format
	forvalues i = 1/5 {
		replace o2_02`i' = o2_03*o2_02`i' if o2_01 == `i' // updated from BIHS 15 format
	} // an edit here from 6->5 beca    use "nostock" is dropped
	bysort a01: egen paddy_cons = total(o2_021)  // be wary of units
	bysort a01: egen rice_cons = total(o2_022)   // be wary of units
	bysort a01: egen atta_cons = total(o2_023)   // be wary of units
	bysort a01: egen cookoil_cons = total(o2_024) // be wary of units
	bysort a01: egen pulse_cons = total(o2_025)  // be wary of units
	//bysort a01: egen nostock_cons = total(o2_026) // be wary of units
	gen nostock_cons = .
	drop if dup > 1
	keep a01 paddy_cons-nostock_cons
	save "$BIHS_19f\097_bihs_r3_female_mod_o2_EDIT.dta", replace

** 098_bihs_r3_female_mod_o3 (22416, ind, a01, res_id_o3)
//    use "$BIHS_19f\098_bihs_r3_female_mod_o3.dta", replace
	** not a module from BIHS_11	

** 061_bihs_r3_male_mod_p1 (78050, ind, a01, res_id_p) - AGGREGATE on (res_id_p)
//    use "$BIHS_19m\061_bihs_r3_male_mod_p1.dta", replace
	** not a module from BIHS_11	

** 062_bihs_r3_male_mod_p2 (177657, HH, a01, - ) - AGGREGATE on (a01) 
//    use "$BIHS_19m\062_bihs_r3_male_mod_p2.dta", replace
	** not a module from BIHS_11	

** 063_bihs_r3_male_mod_q (5605, ind, a01, res_id_q)
    use "$BIHS_19m\063_bihs_r3_male_mod_q.dta", replace

** 064_bihs_r3_male_mod_r (5605, ind, a01, res_id_r1)
    use "$BIHS_19m\064_bihs_r3_male_mod_r.dta", replace	
	
** 065_bihs_r3_male_mod_r2 (5605, ind, a01, res_id_r2)
//    use "$BIHS_19m\065_bihs_r3_male_mod_r2.dta", replace
	** not a module from BIHS_11	

** 066_bihs_r3_male_mod_s (168150, ind, a01, res_id_s)
    use "$BIHS_19m\066_bihs_r3_male_mod_s.dta", replace
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
	save "$BIHS_19m\066_bihs_r3_male_mod_s_EDIT.dta", replace

** 067_bihs_r3_male_mod_t1b (6728, ind, a01, res_id_t)
    use "$BIHS_19m\067_bihs_r3_male_mod_t1b.dta", replace	
		* Generals
			sort a01
			quietly by a01 : gen dup = cond(_N==1, 0, _n)		
			ren (t1b_01 t1b_02 t1b_03 t1b_04 t1b_05 t1b_06a t1b_06b t1b_06c) ///
				(t1_01 t1_02 t1_03 t1_04 t1_05 t1_06a t1_06b t1_06c)
		* Total number of shocks experienced since midline
			bysort a01: egen shock_count_ML = total(t1_02)		
			tab t1_01, generate(t1_01)			
			* Total ML number of shocks: health/death, weather, ag losses		
				gen health_shocks_ML = t1_011+t1_012+t1_013+t1_014+t1_0141
				gen weather_shocks_ML= t1_016+t1_0113+t1_0114+t1_0131+ ///
					t1_0132+t1_0133+t1_0134				
				gen ag_shocks_ML = t1_019+t1_0110+t1_0111+t1_0112+ ///
					t1_0137+t1_0138+t1_0139+t1_0140+t1_0142+t1_0143+ ///
						t1_0144+t1_0145 // crop, livestock losses				
			* Total number of shocks experienced in 2019-ish range
				foreach x of varlist t1_011-t1_0149 {
					replace `x' = . if t1_03 == 1
				}			
				gen t1_03a = t1_03
				replace t1_03a = . if t1_03 ==1				
				bysort a01: egen shock_count_1y = total(t1_03a)				
				gen health_shocks_1y = t1_011+t1_012+t1_013+t1_014+t1_0141
				gen weather_shocks_1y= t1_016+t1_0113+t1_0114+t1_0131+ ///
					t1_0132+t1_0133+t1_0134				
				gen ag_shocks_1y = t1_019+t1_0110+t1_0111+t1_0112+ ///
					t1_0137+t1_0138+t1_0139+t1_0140+t1_0142+t1_0143+ ///
						t1_0144+t1_0145 // crop, livestock losses				
			* Clean and drop variables associated with shocks
				drop t1_011-t1_0149 t1_03a
				foreach x in ML 1y {
					replace shock_count_`x' = 0 if shock_count_`x' == .
					replace health_shocks_`x' = 0 if health_shocks_`x' == .
					replace weather_shocks_`x' = 0 if weather_shocks_`x' == .
					replace ag_shocks_`x' = 0 if ag_shocks_`x' == .
				}				
		** Coping Strategies (beginning of CSI)
			ren (t1_06a t1_06b t1_06c) (t1_08a t1_08b t1_08c)
			gen csi0_a = .		
				replace csi0_a = 1 if t1_08a > 1 & t1_08a !=.
				replace csi0_a = 2 if t1_08b > 1 & t1_08b !=.
				replace csi0_a = 3 if t1_08c > 1 & t1_08c !=.
				bysort a01: egen coping_count_ML = total(csi0_a)
			* Total coping if in 1y range
				replace t1_08a = . if t1_02 == 1 & t1_03 == 2
				replace t1_08b = . if t1_02 == 1 & t1_03 == 2
				replace t1_08c = . if t1_02 == 1 & t1_03 == 2
					replace csi0_a = . 
					replace csi0_a = 1 if t1_08a > 1 & t1_08a != .
					replace csi0_a = 2 if t1_08a > 1 & t1_08b != .
					replace csi0_a = 3 if t1_08a > 1 & t1_08c != .
				bysort a01: egen coping_count_1y = total(csi0_a)
			* No ongoing coping indicator
			* Clean-up
				drop if dup > 1				
				keep a01 health_shocks* weather_shocks* ag_shocks* ///
					shock_count* coping*
		save "$BIHS_19m\067_bihs_r3_male_mod_t1b_EDIT.dta", replace	
	
** 068_bihs_r3_male_mod_t1c (5605, HH, a01, - )
//    use "$BIHS_19m\068_bihs_r3_male_mod_t1c.dta", replace
	** not a module from BIHS_11	 
	
** 069_bihs_r3_male_mod_t2 (72865, HH, a01, -) - AGGREGATE on (a01) 
    use "$BIHS_19m\069_bihs_r3_male_mod_t2.dta", replace
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
		replace new_job_s = 1 if t2_01 == 1		
		replace more_remit_s = 1 if t2_01 == 2
		replace educ_stipend_s = 1 if t2_01==7 | t2_01==10 | t2_01==9
		bysort a01: egen new_job_shock = total(new_job_s)
		bysort a01: egen more_remit_shock = total(more_remit_s)
		bysort a01: egen educ_stipend_shock  = total(educ_stipend_s)
		drop if dup > 1
		keep a01 new_job_shock-educ_stipend_shock pos_shocks_count
		save "$BIHS_19m\069_bihs_r3_male_mod_t2_EDIT.dta", replace

** 070_bihs_r3_male_mod_u (6600, ind, a01, res_id_u)
    use "$BIHS_19m\070_bihs_r3_male_mod_u.dta", replace	
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
	save "$BIHS_19m\070_bihs_r3_male_mod_u_EDIT.dta", replace	

** 071_bihs_r3_male_mod_ua (5605, ind, a01, res_id_ua)
//    use "$BIHS_19m\071_bihs_r3_male_mod_ua.dta", replace
	* not a module previously

** 072_bihs_r3_male_mod_v1 (5994, ind, a01, res_id_vx4)
    use "$BIHS_19m\072_bihs_r3_male_mod_v1.dta", replace
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
	save "$BIHS_19m\053_r2_mod_v1_male_EDIT.dta", replace

** 073_bihs_r3_male_mod_v2 (6061, ind, a01, mid_v2)
    use "$BIHS_19m\073_bihs_r3_male_mod_v2.dta", replace
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
	save "$BIHS_19m\073_bihs_r3_male_mod_v2_EDIT.dta", replace

** 073_bihs_r3_male_mod_v2_12 (5605, HH, a01, - )
//    use "$BIHS_19m\074_bihs_r3_male_mod_v2_12.dta", replace
	* not a module previously

** 074_bihs_r3_male_mod_v2_12 (5605, HH, a01, - )
//    use "$BIHS_19m\074_bihs_r3_male_mod_v2_12.dta", replace
	* not a module previously

** 075_bihs_r3_male_mod_v3 (5631, HH, a01, - )
    use "$BIHS_19m\075_bihs_r3_male_mod_v3.dta", replace
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
	save "$BIHS_19m\075_bihs_r3_male_mod_v3_EDIT.dta", replace

** 076_bihs_r3_male_mod_v4 (5605, HH, a01, - )
    use "$BIHS_19m\076_bihs_r3_male_mod_v4.dta", replace

** 077_bihs_r3_male_mod_x4 (5605, HH, a01, - )
    use "$BIHS_19m\077_bihs_r3_male_mod_x4.dta", replace

** 093_bihs_r3_female_mod_xxc (5604, ind, a01, res_id_xxc)
//    use "$BIHS_19f\093_bihs_r3_female_mod_xxc.dta", replace
	* not a module previously

** 094_bihs_r3_female_mod_xxa (5785, ind, a01, res_id_xxa)
//    use "$BIHS_19f\094_bihs_r3_female_mod_xxa.dta", replace
	* not a module previously

** 095_bihs_r3_female_mod_xxb (5782, ind, a01, xxb_mid)
//    use "$BIHS_19f\095_bihs_r3_female_mod_xxb.dta", replace
	* not a module previously

** 099_bihs_r3_female_mod_w1 (20772, ind, a01, mid_w1) - merge on (a01, mid_w1)
    use "$BIHS_19f\099_bihs_r3_female_mod_w1.dta", replace
	ren mid_w1 mid
	save "$BIHS_19f\099_bihs_r3_female_mod_w1_EDIT.dta", replace

** 100_bihs_r3_female_mod_w2 (5982, ind, a01, mid_w2) - merge on (a01, mid_w1)
    use "$BIHS_19f\100_bihs_r3_female_mod_w2.dta", replace
	ren mid_w2 mid
	save "$BIHS_19f\100_bihs_r3_female_mod_w2_EDIT.dta", replace

** 101_bihs_r3_female_mod_w3 (15457, ind, a01, mid_w3) - merge on (a01, mid_w1)
    use "$BIHS_19f\101_bihs_r3_female_mod_w3.dta", replace
	ren mid_w3 mid
	save "$BIHS_19f\101_bihs_r3_female_mod_w3_EDIT.dta", replace

** 102_bihs_r3_female_mod_w4 (23132, ind, a01, mid_w4) - merge on (a01, mid_w1)
    use "$BIHS_19f\102_bihs_r3_female_mod_w4.dta", replace
	ren mid_w4 mid 
	save "$BIHS_19f\102_bihs_r3_female_mod_w4_EDIT.dta", replace

** 103_bihs_r3_female_mod_w5 (28026, ind, a01, mid_w5)
//    use "$BIHS_19f\103_bihs_r3_female_mod_w5.dta", replace
	** not a module from BIHS_11	

** 104_bihs_r3_female_mod_w5a (23132, ind, a01, res_id_w5a OR mid_w5a)
//    use "$BIHS_19f\104_bihs_r3_female_mod_w5a.dta", replace
	** not a module from BIHS_11	

** 105_bihs_r3_female_mod_x1 (59910, HH, a01, - )
//    use "$BIHS_19f\105_bihs_r3_female_mod_x1.dta", replace
	** not a module from BIHS_11	

** 106_bihs_r3_female_mod_x2 (287249, ind, a01, res_id_x2)
//    use "$BIHS_19f\106_bihs_r3_female_mod_x2.dta", replace
	** not a module from BIHS_11	

** 107_bihs_r3_female_mod_x2a (18183, ind, a01, res_id_x2a)
//    use "$BIHS_19f\107_bihs_r3_female_mod_x2a.dta", replace
	** not a module from BIHS_11	

** 108_bihs_r3_female_mod_x31 (5604, ind, a01, res_id_x3)
    use "$BIHS_19f\108_bihs_r3_female_mod_x31.dta", replace

** 109_bihs_r3_female_mod_x32 (145704, HH, a01, - )
//    use "$BIHS_19f\109_bihs_r3_female_mod_x32.dta", replace
	** not a module from BIHS_11	

** 110_bihs_r3_female_mod_x4 (5604, HH, a01, - )
//    use "$BIHS_19f\110_bihs_r3_female_mod_x4.dta", replace
	** not a module from BIHS_11	

** 111_bihs_r3_female_mod_x51 (5604, ind, a01, res_id_x5)
//    use "$BIHS_19f\111_bihs_r3_female_mod_x51.dta", replace
	** not a module from BIHS_11	

** 112_bihs_r3_female_mod_x52 (89664, HH, a01, - )
//    use "$BIHS_19f\112_bihs_r3_female_mod_x52.dta", replace
	** not a module from BIHS_11	

** 113_bihs_r3_female_mod_y1 (5630, ind, a01, res_id_ym1)
//    use "$BIHS_19f\113_bihs_r3_female_mod_y1.dta", replace
	** not a module from BIHS_11	

** 114_bihs_r3_female_mod_y2 (5630, HH, a01, - )
//    use "$BIHS_19f\114_bihs_r3_female_mod_y2.dta", replace
	** not a module from BIHS_11	

** 115_bihs_r3_female_mod_y3 (5630, HH, a01, - )
//    use "$BIHS_19f\115_bihs_r3_female_mod_y3.dta", replace
	** not a module from BIHS_11	

** 116_bihs_r3_female_mod_y4 (5630, HH, a01, - )
//    use "$BIHS_19f\116_bihs_r3_female_mod_y4.dta", replace
	** not a module from BIHS_11	

** 117_bihs_r3_female_mod_y5 (5630, HH, a01, - )
//    use "$BIHS_19f\117_bihs_r3_female_mod_y5.dta", replace
	** not a module from BIHS_11	

** 118_bihs_r3_female_mod_y6a (5629, HH, a01, - )
//    use "$BIHS_19f\118_bihs_r3_female_mod_y6a.dta", replace
	** not a module from BIHS_11	

** 119_bihs_r3_female_mod_y7 (5630, HH, a01, - )
//    use "$BIHS_19f\119_bihs_r3_female_mod_y7.dta", replace
	** not a module from BIHS_11	

** 120_bihs_r3_female_mod_y8 (5630, HH, a01, - )
//    use "$BIHS_19f\120_bihs_r3_female_mod_y8.dta", replace
	** not a module from BIHS_11	

** 121_bihs_r3_female_mod_z1 (5604, HH, a01, - )
    use "$BIHS_19f\121_bihs_r3_female_mod_z1.dta", replace

** 122_bihs_r3_female_mod_z2 (5604, HH, a01, - )
    use "$BIHS_19f\122_bihs_r3_female_mod_z2.dta", replace

** 123_bihs_r3_female_mod_z3 (5604, HH, a01, - )
    use "$BIHS_19f\123_bihs_r3_female_mod_z3.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	drop if dup > 1
	save "$BIHS_19f\123_bihs_r3_female_mod_z3_EDIT.dta", replace

** 124_bihs_r3_female_mod_z4 (7663, ind, a01, z4_mid)
    use "$BIHS_19f\124_bihs_r3_female_mod_z4.dta", replace
	sort a01
	quietly by a01 : gen dup = cond(_N==1, 0, _n)
	drop if dup > 1
	save "$BIHS_19f\124_bihs_r3_female_mod_z4_EDIT.dta", replace

** 125_bihs_r3_female_mod_z5 (20312, ind, a01, res_id_z5)
//    use "$BIHS_19f\125_bihs_r3_female_mod_z5.dta", replace

///////////////////////////////////////////////////////////////////////////////

***************************
** COMMUNITY LEVEL FILES ** 
***************************

** 140_r3_com_mod_ca_1 (447, village, community_id)
    use "$BIHS_19comm\140_r3_com_mod_ca_1.dta", replace

** 141_r3_com_mod_ca_2 (447, village, community_id)
    use "$BIHS_19comm\141_r3_com_mod_ca_2.dta", replace

** 142_r3_com_mod_cb_1 (447, village, community_id)
    use "$BIHS_19comm\142_r3_com_mod_cb_1.dta", replace

** 143_r3_com_mod_cb_2 (447, village, community_id)
    use "$BIHS_19comm\143_r3_com_mod_cb_2.dta", replace

** 144_r3_com_mod_cc (447, village, community_id)
    use "$BIHS_19comm\144_r3_com_mod_cc.dta", replace

** 145_r3_com_mod_cd (1341, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\145_r3_com_mod_cd.dta", replace

** 146_r3_com_mod_ce (447, village, community_id)
    use "$BIHS_19comm\146_r3_com_mod_ce.dta", replace

** 147_r3_com_mod_cf (12963, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\147_r3_com_mod_cf.dta", replace

** 148_r3_com_mod_cg (3106, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\148_r3_com_mod_cg.dta", replace

** 149_r3_com_mod_ci (22797, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\149_r3_com_mod_ci.dta", replace

** 150_r3_com_mod_ck (6705, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\150_r3_com_mod_ck.dta", replace

** 151_r3_com_mod_k1 (20562, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\151_r3_com_mod_k1.dta", replace

** 152_r3_com_mod_k2 (16539, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\152_r3_com_mod_k2.dta", replace

** 153_r3_com_mod_l1 (447, village, community_id)
    use "$BIHS_19comm\153_r3_com_mod_l1.dta", replace

** 154_r3_com_mod_l1_20 (2337, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\154_r3_com_mod_l1_20.dta", replace

** 155_r3_com_mod_l2 (447, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\155_r3_com_mod_l2.dta", replace

** 156_r3_com_mod_l2_16 (2675, village, community_id) - AGGREGATE on (community_id)
    use "$BIHS_19comm\156_r3_com_mod_l2_16.dta", replace


///////////////////////////////////////////////////////////////////////////////

** Base Data CENSUS ( , ind, a01, mid)
	** might not be a thing here, see also BIHS 010 here

///////////////////////////////////////////////////////////////////////////////

** SAMPLING WEIGHTS (5605, HH, a01, - )
    use "$BIHS_19comm\158_BIHS sampling weights_r3.dta", replace
	
///////////////////////////////////////////////////////////////////////////////








