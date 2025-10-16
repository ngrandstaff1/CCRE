*****************************
*****************************
** BIHS HH Merge Data 2011 ** ** (Key: n, level, id1, id2)
**       N.Grandstaff      **
*****************************
*****************************
clear all

*--------------------*
* Directory for 2011 *
*--------------------*
global BIHS_11 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_11"
global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 2 - Merging by HH\Temp Files"

*--------------------*
*  BIHS 2011 HH Data *
*--------------------*
** 001_mod_a_male (6503, HH, a01, - ) - merge on (a01)
	use "$BIHS_11\001_mod_a_male.dta", replace

** 002_mod_a_female (6503, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_11\002_mod_a_female.dta", force
	cap drop _merge

** 003_mod_b1_male (27285, ind, a01, mid) - merge on (a01, mid)
	merge 1:m a01 using "$BIHS_11\003_mod_b1_male.dta", force
	cap drop _merge

** 004_mod_b2_male (7677, ind, a01, mid) - merge on (a01, mid)
	merge 1:1 a01 mid using "$BIHS_11\004_mod_b2_male_EDIT.dta", force
	cap drop _merge

** 005_mod_c_male (29889, ind, a01, mid) - merge on (a01, mid)
	merge 1:1 a01 mid using "$BIHS_11\005_mod_c_male_EDIT.dta"
	cap drop _merge

** 006_mod_d1_male (29889, ind, a01, mid) - merge on (a01, mid)
	merge 1:1 a01 mid using "$BIHS_11\006_mod_d1_male_EDIT.dta", force
	cap drop _merge

** 007_mod_d2_male (214599, assets, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\007_mod_d2_male_EDIT.dta"
	cap drop _merge

** 008_mod_e_male (8429, HH-bank, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\008_mod_e_male_EDIT.dta"
	cap drop _merge

** 009_mod_f_male (9411, ind, a01, mid) - merge on (a01, mid)
	merge m:1 a01 using "$BIHS_11\009_mod_f_male_EDIT.dta" 
	cap drop _merge

** 010_mod_g_male (25396, HH-plots, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\010_mod_g_male_EDIT.dta"
	cap drop _merge

** 011_mod_h1_male (22627, HH-plots, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\011_mod_h1_male_EDIT.dta"
	cap drop _merge	

** 012_mod_h2_male (22627, HH-plots, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\012_mod_h2_male_EDIT.dta"
	cap drop _merge

** 013_mod_h3_male (7977, HH-plots, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\013_mod_h3_male_EDIT.dta"
	cap drop _merge	

** 014_mod_h4_male (7977, HH-plots, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\014_mod_h4_male_EDIT.dta"
	cap drop _merge	

** 015_mod_h5_male (7977, HH-plots, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\015_mod_h5_male_EDIT.dta"
	cap drop _merge

** 016_mod_h6_male (9919, HH-crops, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\016_mod_h6_male_EDIT.dta"
	cap drop _merge
	
** 017_mod_h7_male (58527, HH-inputs, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\017_mod_h7_male_EDIT.dta"
	cap drop _merge

** 018_mod_h8_male (6503, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_11\018_mod_h8_male.dta"	
	cap drop _merge

** 019_mod_i1_male (33029, HH-crops, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\019_mod_i1_male_EDIT.dta"
	cap drop _merge
	
** 020_mod_i2_male (6503, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_11\020_mod_i2_male.dta"
	cap drop _merge	
	
** 021_mod_j1_male (6503, HH, a01, - ) - merge on (a01)	
	merge m:1 a01 using "$BIHS_11\021_mod_j1_male.dta"
	cap drop _merge	

** 022_mod_j2_male (6503, HH, a01, - ) - merge on (a01)	
	merge m:1 a01 using "$BIHS_11\022_mod_j2_male.dta"
	cap drop _merge

** 023_mod_k1_male (9919, HH-livestock, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\023_mod_k1_male_EDIT.dta"
	cap drop _merge

** 024_mod_k2_male (8153, HH-AnimProd, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\024_mod_k2_male_EDIT.dta"
	cap drop _merge	
	
** 026_mod_l1_male (2611, HH-pond, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\026_mod_l1_male_EDIT.dta"
	cap drop _merge	 

** 027_mod_l2_male (9465, HH-fish, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\027_mod_l2_male_EDIT.dta"
	cap drop _merge	
	
** 028_mod_m1_male (3730, HH-sales, a01, m1_01) - AGGREGATE on (m1_01)
	merge m:1 a01 using "$BIHS_11\028_mod_m1_male_EDIT.dta"
	cap drop _merge	

** 030_mod_n_male (6982, HH-SME, a01, rid) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\030_mod_n_male_EDIT.dta"
	cap drop _merge

	
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
** 031_mod_o1_female (185875, HH-FoodCons, a01, o1_01) - AGGREGATE on (a01)
*use "$BIHS_11\031_mod_o1_female.dta", replace	
	** Need to split the foods into HDDS, FCS groups
	* I have a separate file to do this now.
	* Merge the files
	* convert all units to the same unit--here, grams (?)
	* since using FCS, might need only count incidence of foods within the week
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


** 032_mod_o2_female (17724, HH-FoodCons, a01, o2_02) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_11\032_mod_o2_male_EDIT.dta"
	cap drop _merge

** 035_mod_q_male (6503, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_11\035_mod_q_male.dta"
	cap drop _merge

** 036_mod_r_male (6503, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_11\036_mod_r_male.dta"
	cap drop _merge
	
** 037_mod_s_male (91042, HH-HCFaci, a01, s_01) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_11\037_mod_s_male_EDIT.dta"
	cap drop _merge
	
** 038_mod_t1_male (4897, HH-NegShocks, a01, t1_02) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_11\038_mod_t1_male_EDIT.dta"
	cap drop _merge	
	
** 039_mod_t2_male (78377, HH-PosShocks, a01, t2_02) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_11\039_mod_t2_male_EDIT.dta"
	cap drop _merge	
	
** 040_mod_u_male (279629, ind, a01, mid_1/mid_2)
	merge m:1 a01 using "$BIHS_11\040_mod_u_male_EDIT.dta"
	cap drop _merge

** 041_mod_v1_male (6828, ind, a01, pid) - merge on (a01, pid...migration)
	merge m:1 a01 using "$BIHS_11\041_mod_v1_male_EDIT.dta"
	cap drop _merge
	
** 042_mod_v2_male (6847, ind, a01, pid) - merge on (a01, pid...remittances)
	merge m:1 a01 using "$BIHS_11\042_mod_v2_male_EDIT.dta"	
	cap drop _merge
	
** 043_mod_v3_male (6525, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_11\043_mod_v3_male_EDIT.dta"	
	cap drop _merge 
	
** 044_mod_v4_male (6503, HH, a01, - ) - merge on (a01)	
	merge m:1 a01 using "$BIHS_11\044_mod_v4_male.dta"
	cap drop _merge
	
** 045_mod_w1_female (24374, ind, a01, mid) - merge on (a01, mid)	
	merge 1:m a01 mid using "$BIHS_11\045_mod_w1_female.dta"
	cap drop _merge
	
** 046_mod_w2_female (2911, ind, a01, mid) - merge on (a01, mid)	
	merge 1:m a01 mid using "$BIHS_11\046_mod_w2_female.dta"
	cap drop _merge	
	
** 047_mod_w3_female (17393, ind, a01, mid) - merge on (a01, mid)	
	merge 1:m a01 mid using "$BIHS_11\047_mod_w3_female.dta"
	cap drop _merge
	
** 048_mod_w4_female (27277, ind, a01, mid) - merge on (a01, mid)
	merge 1:m a01 mid using "$BIHS_11\048_mod_w4_female.dta"
	cap drop _merge 

** 051_mod_x3_female (6503, HH, a01, rid) - merge on (a01)
	merge m:1 a01 using "$BIHS_11\051_mod_x3_female.dta"
	cap drop _merge
	
** 053_mod_y2_female (5503, HH, a01, - ) - merge on (a01)	
	merge m:1 a01 using "$BIHS_11\053_mod_y2_female.dta"
	cap drop _merge

** 060_mod_z1_female (6503, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_11\060_mod_z1_female.dta"
	cap drop _merge
	
** 061_mod_z2_female (5503, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_11\061_mod_z2_female.dta"
	cap drop _merge
	
** 062_mod_z3_female (6503, HH, a01, - ) - merge on (a01) 	
	merge m:1 a01 using "$BIHS_11\062_mod_z3_female.dta"
	cap drop _merge
	
** 063_mod_z4_female (6503, HH, a01, - ) - merge on (a01) 	
	merge m:1 a01 using "$BIHS_11\063_mod_z4_female.dta"
	cap drop _merge
	
** 109_mod_identity_other_community
	
	
	
/* Community variables - 2011
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
use "$BIHS_11\007_mod_ci_community.dta", replace
	* list of social safety net programs available and if HH mem participated
** 008_mod_ck_community (700, sl, - , - ) - merge on (sl)?
use "$BIHS_11\008_mod_ck_community.dta", replace
	* questions about ag labor in the area
** Base Data CENSUS (47027, ind, a01, mid)
use "$BIHS_11\001_census_ftf.dta", replace
*/

**	SAVE STUFF
	*gen WAVE = 2011
	gen resp = 0
		replace resp = mid if mid == a10
	save "$temp\Big_Merge_11.dta", replace
	

























































