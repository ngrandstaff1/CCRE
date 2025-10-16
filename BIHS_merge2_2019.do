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
	global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 2 - Merging by HH\Temp Files"

*--------------------*
*  BIHS 2019 HH Data *
*--------------------*
///////////////////////
//    WAVE 3: 2019   //
///////////////////////
clear all 
** 009_bihs_r3_male_mod_a (6011, ind, a01, res_id_a)
use "$BIHS_19m\009_bihs_r3_male_mod_a.dta", replace

** 092_bihs_r3_female_mod_a (6011, ind, a01, res_id_a)
	merge m:1 a01 using "$BIHS_19f\092_bihs_r3_female_mod_a.dta"
	cap drop _merge

** 010_bihs_r3_male_mod_b1 (32332, ind, a01, mid)
	merge 1:m a01 using "$BIHS_19m\010_bihs_r3_male_mod_b1.dta"
	cap drop _merge
	
** 011_bihs_r3_male_mod_b2 (10216, ind, a01, mid_b2)	
	merge m:1 a01 mid using "$BIHS_19m\011_bihs_r3_male_mod_b2_EDIT.dta"
	cap drop _merge			
	
** 012_bihs_r3_male_mod_c (27752, ind, a01, mid_c)
	merge m:1 a01 mid using "$BIHS_19m\012_bihs_r3_male_mod_c_EDIT.dta"
	cap drop _merge	
	
** 016_bihs_r3_male_mod_d2 (15560, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_19m\016_bihs_r3_male_mod_d2_EDIT.dta" 
	cap drop _merge

** 017_bihs_r3_male_mod_e (7543, ind, a01, mid_e)
	merge m:1 a01 using "$BIHS_19m\017_bihs_r3_male_mod_e_EDIT.dta"
	cap drop _merge

** 018_bihs_r3_male_mod_f (8301, ind, a01, mid_f)
	merge m:1 a01 using "$BIHS_19m\018_bihs_r3_male_mod_f_EDIT.dta"
	cap drop _merge
	
** 020_bihs_r3_male_mod_g (31920, HH-plots, a01, plotid) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_19m\020_bihs_r3_male_mod_g_EDIT.dta"
	cap drop _merge	
	
** 021_bihs_r3_male_mod_h1 (17537, HH-plots, a01, plotid_h1) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_19m\021_bihs_r3_male_mod_h1_EDIT.dta" 
	cap drop _merge

** 022_bihs_r3_male_mod_h2 (17537, HH-plots, a01, plotid_h2) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_19m\022_bihs_r3_male_mod_h2_EDIT.dta" 
	cap drop _merge
	
** 023_bihs_r3_male_mod_h3 (17537, HH-plots, a01, plotid_h3) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_19m\023_bihs_r3_male_mod_h3_EDIT.dta"
	cap drop _merge
	
** 024_bihs_r3_male_mod_h4 (17537, HH-plots, a01, plotid_h4) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_19m\024_bihs_r3_male_mod_h4_EDIT.dta"
	cap drop _merge
	
** 025_bihs_r3_male_mod_h5 (17537, HH-plots, a01, plotid_h5) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_19m\025_bihs_r3_male_mod_h5_EDIT.dta" 
	cap drop _merge
	
** 026_bihs_r3_male_mod_h6 (9734, HH-crops, a01, crop_h6) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_19m\026_bihs_r3_male_mod_h6_EDIT.dta" 
	cap drop _merge
	
** 027_bihs_r3_male_mod_h7 (40849, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_19m\027_bihs_r3_male_mod_h7_EDIT.dta" 
	cap drop _merge
	
** 029_bihs_r3_male_mod_h8 (5605, HH, a01, - ) - AGGREGATE on (a01)
	merge m:1 a01 using "$BIHS_19m\029_bihs_r3_male_mod_h8.dta" 
	cap drop _merge
	
** 030_bihs_r3_male_mod_i1 (13073, ind, a01, res_id_i) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_19m\030_bihs_r3_male_mod_i1_EDIT.dta" 
	cap drop _merge
	
** 031_bihs_r3_male_mod_i2 (5605, HH, a01, - ) 	
	merge m:1 a01 using "$BIHS_19m\031_bihs_r3_male_mod_i2.dta" 
	cap drop _merge
	
** 038_bihs_r3_male_mod_j1 (5605, ind, a01, res_id_j)
	merge m:1 a01 using "$BIHS_19m\038_bihs_r3_male_mod_j1.dta" 
	cap drop _merge
	
** 039_bihs_r3_male_mod_j1a (5605, HH, a01, - ) 	
	merge m:1 a01 using "$BIHS_19m\039_bihs_r3_male_mod_j1a.dta"
	cap drop _merge
	
** 040_bihs_r3_male_mod_j2a (5605, HH, a01, - ) 
	merge m:1 a01 using "$BIHS_19m\040_bihs_r3_male_mod_j2a.dta" 
	cap drop _merge
	
** 043_bihs_r3_male_mod_k1 (67248, ind, a01, res_id_k1) - AGGREGATE on (res_id_k1)	
	merge m:1 a01 using "$BIHS_19m\043_bihs_r3_male_mod_k1_EDIT.dta" 
	cap drop _merge
	
** 049_bihs_r3_male_mod_k2 (22416, ind, a01, res_id_k23)	
	merge m:1 a01 using "$BIHS_19m\049_bihs_r3_male_mod_k2_EDIT.dta"
	cap drop _merge
	
** 051_bihs_r3_male_mod_l1 (5797, ind, a01, res_ind_l)	
	merge m:1 a01 using "$BIHS_19m\051_bihs_r3_male_mod_l1_EDIT.dta"	
	cap drop _merge
	
** 052_bihs_r3_male_mod_l2 (13625, HH, a01, - ) - AGGREGATE on (a01)	
	merge m:1 a01 using "$BIHS_19m\052_bihs_r3_male_mod_l2_EDIT.dta" 
	cap drop _merge

** 058_bihs_r3_male_mod_m1 (7014, ind, a01, res_id_m)	
	merge m:1 a01 using "$BIHS_19m\058_bihs_r3_male_mod_m1_EDIT.dta" 
	cap drop _merge
	
** 060_bihs_r3_male_mod_n (5755, ind, a01, res_id_n)	
	merge m:1 a01 using "$BIHS_19m\060_bihs_r3_male_mod_n_EDIT.dta"
	cap drop _merge	
	
	
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////	
** 096_bihs_r3_female_mod_o1 (210837, ind, a01, res_id_o1)
*use "$BIHS_19f\096_bihs_r3_female_mod_o1.dta" 
	** Need to split the foods into HDDS, FCS groups
	* I have a separate file to do this now.
	* Merge the files
	* convert all units to the same unit--here, grams (?)
	* since using FCS, might need only count incidence of foods within the wee	
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////	
	
	

** 097_bihs_r3_female_mod_o2 (28020, ind, a01, res_id_o2)	
	merge m:1 a01 using "$BIHS_19f\097_bihs_r3_female_mod_o2_EDIT.dta"
	cap drop _merge
	
** 063_bihs_r3_male_mod_q (5605, ind, a01, res_id_q)	
	merge m:1 a01 using "$BIHS_19m\063_bihs_r3_male_mod_q.dta"
	cap drop _merge
	
** 064_bihs_r3_male_mod_r (5605, ind, a01, res_id_r1)	
	merge m:1 a01 using "$BIHS_19m\064_bihs_r3_male_mod_r.dta" 
	cap drop _merge
	
** 066_bihs_r3_male_mod_s (168150, ind, a01, res_id_s)
	merge m:1 a01 using "$BIHS_19m\066_bihs_r3_male_mod_s_EDIT.dta" 
	cap drop _merge
	
** 067_bihs_r3_male_mod_t1b (6728, ind, a01, res_id_t)	
	merge m:1 a01 using "$BIHS_19m\067_bihs_r3_male_mod_t1b_EDIT.dta"
	cap drop _merge
	
** 069_bihs_r3_male_mod_t2 (72865, HH, a01, -) - AGGREGATE on (a01) 	
	merge m:1 a01 using "$BIHS_19m\069_bihs_r3_male_mod_t2_EDIT.dta"
	cap drop _merge
	
** 070_bihs_r3_male_mod_u (6600, ind, a01, res_id_u)
	merge m:1 a01 using "$BIHS_19m\070_bihs_r3_male_mod_u_EDIT.dta"
	cap drop _merge
	
** 072_bihs_r3_male_mod_v1 (5994, ind, a01, res_id_vx4)	
	merge m:1 a01 using "$BIHS_19m\053_r2_mod_v1_male_EDIT.dta"
	cap drop _merge
	
** 073_bihs_r3_male_mod_v2 (6061, ind, a01, mid_v2)	
	merge m:1 a01 using "$BIHS_19m\073_bihs_r3_male_mod_v2_EDIT.dta" 
	cap drop _merge
	
** 075_bihs_r3_male_mod_v3 (5631, HH, a01, - )	
	merge m:1 a01 using "$BIHS_19m\075_bihs_r3_male_mod_v3_EDIT.dta" 
	cap drop _merge
	
** 076_bihs_r3_male_mod_v4 (5605, HH, a01, - )
	merge m:1 a01 using "$BIHS_19m\076_bihs_r3_male_mod_v4.dta" 
	cap drop _merge
	
** 077_bihs_r3_male_mod_x4 (5605, HH, a01, - )	
	merge m:1 a01 using "$BIHS_19m\077_bihs_r3_male_mod_x4.dta" 
	cap drop _merge
	
** 099_bihs_r3_female_mod_w1 (20772, ind, a01, mid_w1) - merge on (a01, mid_w1)	
	merge m:1 a01 mid using "$BIHS_19f\099_bihs_r3_female_mod_w1_EDIT.dta"
	cap drop _merge		
	
** 100_bihs_r3_female_mod_w2 (5982, ind, a01, mid_w2) - merge on (a01, mid_w1)	
	merge m:1 a01 mid using "$BIHS_19f\100_bihs_r3_female_mod_w2_EDIT.dta"
	cap drop _merge
	
** 101_bihs_r3_female_mod_w3 (15457, ind, a01, mid_w3) - merge on (a01, mid_w1)	
	merge m:1 a01 mid using "$BIHS_19f\101_bihs_r3_female_mod_w3_EDIT.dta"
	cap drop _merge	
	
** 102_bihs_r3_female_mod_w4 (23132, ind, a01, mid_w4) - merge on (a01, mid_w1)	
	merge m:1 a01 mid using "$BIHS_19f\102_bihs_r3_female_mod_w4_EDIT.dta"
	cap drop _merge
	
** 108_bihs_r3_female_mod_x31 (5604, ind, a01, res_id_x3)	
	merge m:1 a01 using "$BIHS_19f\108_bihs_r3_female_mod_x31.dta"
	cap drop _merge	
	
** 121_bihs_r3_female_mod_z1 (5604, HH, a01, - )
	merge m:1 a01 using "$BIHS_19f\121_bihs_r3_female_mod_z1.dta"
	cap drop _merge
	
** 122_bihs_r3_female_mod_z2 (5604, HH, a01, - )	
	merge m:1 a01 using "$BIHS_19f\122_bihs_r3_female_mod_z2.dta"
	cap drop _merge	
		
** 123_bihs_r3_female_mod_z3 (5604, HH, a01, - )		
	merge m:1 a01 using "$BIHS_19f\123_bihs_r3_female_mod_z3_EDIT.dta"
	cap drop _merge
	
** 124_bihs_r3_female_mod_z4 (7663, ind, a01, z4_mid)	
	merge m:1 a01 using "$BIHS_19f\124_bihs_r3_female_mod_z4_EDIT.dta" 
	cap drop _merge	
	
///////////////////////////////////////////////////////////////////////////////

** SAMPLING WEIGHTS (5605, HH, a01, - )	
	merge m:1 a01 using "$BIHS_19comm\158_BIHS sampling weights_r3.dta" 
	cap drop _merge
	
** NEED TO DEFINE A FUNCTION TO CONVERT THESE HH (a01) VALUES TO a01 elsewhere!
	
///////////////////////////////////////////////////////////////////////////////


***************************
** COMMUNITY LEVEL FILES ** 
***************************
/*
** 140_r3_com_mod_ca_1 (447, village, community_id)
use "$BIHS_19comm\140_r3_com_mod_ca_1.dta" 
** 141_r3_com_mod_ca_2 (447, village, community_id)
use "$BIHS_19comm\141_r3_com_mod_ca_2.dta" 
** 142_r3_com_mod_cb_1 (447, village, community_id)
use "$BIHS_19comm\142_r3_com_mod_cb_1.dta" 
** 143_r3_com_mod_cb_2 (447, village, community_id)
use "$BIHS_19comm\143_r3_com_mod_cb_2.dta" 
** 144_r3_com_mod_cc (447, village, community_id)
use "$BIHS_19comm\144_r3_com_mod_cc.dta" 
** 145_r3_com_mod_cd (1341, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\145_r3_com_mod_cd.dta" 
** 146_r3_com_mod_ce (447, village, community_id)
use "$BIHS_19comm\146_r3_com_mod_ce.dta" 
** 147_r3_com_mod_cf (12963, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\147_r3_com_mod_cf.dta" 
** 148_r3_com_mod_cg (3106, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\148_r3_com_mod_cg.dta" 
** 149_r3_com_mod_ci (22797, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\149_r3_com_mod_ci.dta" 
** 150_r3_com_mod_ck (6705, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\150_r3_com_mod_ck.dta" 
** 151_r3_com_mod_k1 (20562, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\151_r3_com_mod_k1.dta" 
** 152_r3_com_mod_k2 (16539, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\152_r3_com_mod_k2.dta" 
** 153_r3_com_mod_l1 (447, village, community_id)
use "$BIHS_19comm\153_r3_com_mod_l1.dta" 
** 154_r3_com_mod_l1_20 (2337, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\154_r3_com_mod_l1_20.dta" 
** 155_r3_com_mod_l2 (447, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\155_r3_com_mod_l2.dta" 
** 156_r3_com_mod_l2_16 (2675, village, community_id) - AGGREGATE on (community_id)
use "$BIHS_19comm\156_r3_com_mod_l2_16.dta" 
*/


**	SAVE STUFF
	gen WAVE = 2019
	gen dcode1 = district
	gen ucode1 = union
	tostring ucode1, replace
	tostring upazila, replace
	gen UPZ = upazila
	gen resp = 0
		replace resp = mid if mid == a10
	save "$temp\Big_Merge_19.dta", replace















