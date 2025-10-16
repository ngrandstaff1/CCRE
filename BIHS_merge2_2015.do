*****************************
*****************************
** BIHS HH Merge Data 2015 ** ** (Key: n, level, id1, id2)
**       N.Grandstaff      **
*****************************
*****************************
clear all

*--------------------*
* Directory for 2015 *
*--------------------*
global BIHS_15 "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_15"
global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 2 - Merging by HH\Temp Files"

*--------------------*
*  BIHS 2015 HH Data *
*--------------------*
clear all
** 001_r2_mod_a_male (6715, HH, a01, - ) - merge on (a01)
use "$BIHS_15\001_r2_mod_a_male.dta", replace

** 002_r2_mod_a_female (6715, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_15\002_r2_mod_a_female.dta"
	cap drop _merge

** 003_r2_male_mod_b1 (34297, ind, a01, mid) - CENSUS
	merge 1:m a01 using "$BIHS_15\003_r2_male_mod_b1.dta"
	cap drop _merge
	
** 004_r2_mod_b2_male (12215, ind, a01, mid) - Feed the Future/BIHS combined	
	merge m:1 a01 mid using "$BIHS_15\004_r2_mod_b2_male.dta"
	cap drop _merge
	
** 008_r2_mod_c_male (31314, ind, a01, mid) - merge on (a01, mid)	
	merge m:1 a01 mid using "$BIHS_15\008_r2_mod_c_male_EDIT.dta"
	cap drop _merge	
	
** 011_r2_mod_d2_male (16843, HH-Assets, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\011_r2_mod_d2_male_EDIT.dta"
	cap drop _merge	
	
** 012_r2_mod_e_male (9032, HH-Savings, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\012_r2_mod_e_male_EDIT.dta"
	cap drop _merge
	
** 013_r2_mod_f_male (9554, ind-loans, a01, mid) - AGGREGATE on (mid)	
	merge m:1 a01 using "$BIHS_15\013_r2_mod_f_male_EDIT.dta"
	cap drop _merge
	
** 014_r2_mod_g_male (31347, HH, a01, plotid) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\014_r2_mod_g_male_EDIT.dta"
	cap drop _merge	
	
** 015_r2_mod_h1_male (23114, HH, a01, plotid) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\015_r2_mod_h1_male_EDIT.dta"
	cap drop _merge	
	
** 016_r2_mod_h2_male (23114, HH, a01, plotid) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\016_r2_mod_h2_male_EDIT.dta"
	cap drop _merge	
	
** 017_r2_mod_h3_male (23114, HH, a01, plotid) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\017_r2_mod_h3_male_EDIT.dta"
	cap drop _merge
	
** 018_r2_mod_h4_male (23114, HH, a01, plotid) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\018_r2_mod_h4_male_EDIT.dta"
	cap drop _merge	
	
** 019_r2_mod_h5_male (23114, HH, a01, plotid) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\019_r2_mod_h5_male_EDIT.dta"
	cap drop _merge	
	
** 020_r2_mod_h6_male (12062, HH, a01, crop) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\020_r2_mod_h6_male_EDIT.dta"
	cap drop _merge	
	
** 021_r2_mod_h7_male (20076, HH-inputs, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\021_r2_mod_h7_male_EDIT.dta"
	cap drop _merge	
	
** 023_r2_mod_h8_male (6436, HH, a01, - ) - merge on (a01)	
	merge m:1 a01 using "$BIHS_15\023_r2_mod_h8_male.dta"
	cap drop _merge
	
** 025_r2_mod_i1_male (15805, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\025_r2_mod_i1_male_EDIT.dta"
	cap drop _merge	
	
** 026_r2_mod_i2_male (6436, HH, a01, - ) - merge on (a01)	
	merge m:1 a01 using "$BIHS_15\026_r2_mod_i2_male.dta"
	cap drop _merge

** 031_r2_mod_j1_male (6436, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\031_r2_mod_j1_male.dta"	
	cap drop _merge	
	
** 033_r2_mod_j2_male (6436, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\033_r2_mod_j2_male.dta"
	cap drop _merge	
	
** 034_r2_mod_k1_male (77232, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\034_r2_mod_k1_male_EDIT.dta"
	cap drop _merge

** 035_r2_mod_k2_male (13305, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\035_r2_mod_k2_male_EDIT.dta"
	cap drop _merge	
	
** 037_r2_mod_l1_male (6670, HH-ponds, a01, pondid) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\037_r2_mod_l1_male_EDIT.dta"
	cap drop _merge
	
** 038_r2_mod_l2_male (11438, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\038_r2_mod_l2_male_EDIT.dta"
	cap drop _merge	
	
** 039_r2_mod_m1_male (8234, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\039_r2_mod_m1_male_EDIT.dta"
	cap drop _merge	
	
** 041_r2_mod_n_male (7096, ind, a01, rid) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\041_r2_mod_n_male_EDIT.dta"
	cap drop _merge	
	
	
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
** 042_r2_mod_o1_female (218249, HH-items, a01, ) - AGGREGATE on (a01)
*use "$BIHS_15\042_r2_mod_o1_female.dta"	
	** Need to split the foods into HDDS, FCS groups
	* I have a separate file to do this now.
	* Merge the files
	* convert all units to the same unit--here, grams (?)
	* since using FCS, might need only count incidence of foods within the week
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
		
	
** 043_r2_mod_o2_female (32176, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\043_r2_mod_o2_male_EDIT.dta"
	cap drop _merge

** 047_r2_mod_q_male (6436, HH, a01, - ) - merge on (a01)	
	merge m:1 a01 using "$BIHS_15\047_r2_mod_q_male.dta"
	cap drop _merge	
	
** 048_r2_mod_r_male (6436, HH, a01, - ) - merge on (a01)
	merge m:1 a01 using "$BIHS_15\048_r2_mod_r_male.dta"	
	cap drop _merge	
	
** 049_r2_mod_s_male (67613, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\049_r2_mod_s_male_EDIT.dta"
	cap drop _merge	
	
** 050_r2_mod_t1_male (7047, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\050_r2_mod_t1_male_EDIT.dta"
	cap drop _merge	
	
** 051_r2_mod_t2_male (6788, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\051_r2_mod_t2_male_EDIT.dta"
	cap drop _merge	

** 052_r2_mod_u_male (7227, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\052_r2_mod_u_male_EDIT.dta"
	cap drop _merge
	
** 053_r2_mod_v1_male (6536, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\053_r2_mod_v1_male_EDIT.dta"
	cap drop _merge	

** 054_r2_mod_v2_male (6833, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\054_r2_mod_v2_male_EDIT.dta"
	cap drop _merge	

** 055_r2_mod_v3_male (6467, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_15\055_r2_mod_v3_male_EDIT.dta"
	cap drop _merge

** 056_r2_mod_v4_male (6436, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\056_r2_mod_v4_male.dta"	
	cap drop _merge
	
** 059_r2_mod_w1_female (24591, ind, a01, mid) 	
	merge 1:m a01 mid using	"$BIHS_15\059_r2_mod_w1_female.dta"
	cap drop _merge	 
	
** 060_r2_mod_w2_female (6860, ind, a01, mid) 	
	merge 1:m a01 mid using "$BIHS_15\060_r2_mod_w2_female.dta"
	cap drop _merge

** 061_r2_mod_w3_female (18050, ind, a01, mid) 	
	merge 1:m a01 mid using "$BIHS_15\061_r2_mod_w3_female.dta"
	cap drop _merge
	
** 062_r2_mod_w4_female (27352, ind, a01, mid)	
	merge 1:m a01 mid using "$BIHS_15\062_r2_mod_w4_female.dta"	
	cap drop _merge
	
** 068_r2_mod_x3_female (6434, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\068_r2_mod_x3_female.dta"
	cap drop _merge
	
** 078_r2_mod_z1_female (6434, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\078_r2_mod_z1_female.dta",
	cap drop _merge	
	
** 079_r2_mod_z2_female (6434, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\079_r2_mod_z2_female.dta"
	cap drop _merge	
	
** 080_r2_mod_z3_female (6434, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\080_r2_mod_z3_female.dta"
	cap drop _merge
	
** 081_r2_mod_z4_female (6434, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_15\081_r2_mod_z4_female.dta"
	cap drop _merge	

** 109_module_identity_other_community (353, slno, ca01, - ) - merge on (a01)?
	merge m:1 Village using "$BIHS_15\109_module_identity_other_community.dta"
	cap _merge
	
/* Community Variables to be called up as needed
///////////////////////////////////////////////////////////////////////////////
** SAMPLING WEIGHTS (6715, HH, a01, - )
use "$BIHS_15\BIHS FTF 2015 survey sampling weights.dta", replace	
///////////////////////////////////////////////////////////////////////////////

** NEED TO DEFINE A FUNCTION TO CONVERT THESE HH (a01) VALUES TO a01 elsewhere!
		
///////////////////////////////////////////////////////////////////////////////
***************************
** COMMUNITY LEVEL FILES ** 
***************************

** 110_respondent_id_community (1135, slno, Member, - ) - merge on (a01)?
use "$BIHS_15\110_respondent_id_community.dta", replace
** 111_module_cb_community (323, sl, ca01, - ) - merge on (a01)?
use "$BIHS_15\111_module_cb_community.dta", replace
** 112_module_cc_community (353, slno, - , - ) - merge on (slno)?
use "$BIHS_15\112_module_cc_community.dta", replace
** 113_module_cd_community (1059, slno, - , - ) - merge on (slno)?
use "$BIHS_15\113_module_cd_community.dta", replace
** 114_module_ce_community (353, slno, - , - ) - merge on (slno)?
use "$BIHS_15\114_module_ce_community.dta", replace
** 115_module_cf_community (10209, slno, - , - ) - merge on (slno)?
use "$BIHS_15\115_module_cf_community.dta", replace
** 116_module_cg_community (2128, slno, - , - ) - merge on (slno)?
use "$BIHS_15\116_module_cg_community.dta", replace
** 117_module_ci_community (15532, slno, - , - ) - merge on (slno)?
use "$BIHS_15\117_module_ci_community.dta", replace
** 118_module_ck_community (5295, slno, - , - ) - merge on (slno)?
use "$BIHS_15\118_module_ck_community.dta", replace
** 119_module_k1_community (16193, slno, - , - ) - merge on (slno)?
use "$BIHS_15\119_module_k1_community.dta", replace
** 120_module_k2_community (13025, slno, - , - ) - merge on (slno)?
use "$BIHS_15\120_module_k2_community.dta", replace
*/

**	SAVE STUFF
	gen WAVE = 2015
	gen resp = 0
		replace resp = mid if mid == a10
	save "$temp\Big_Merge_15.dta", replace



















