*------------------------------------------------------*
** Village Level Characteristics based on Identifiers **   * VILLAGE LEVEL *
*------------------------------------------------------*   * NO SPLITS *
clear all

* Priors
	global CCRE "C:\Users\ngran\Dropbox\JHODD - CCRE"
	global ModA "$CCRE\BIHS Data\module a data"
	global folder "$ModA\Clean_Identifiers"
		
* All Data - collapse to YEAR-VILLAGE level of data
	* Obtain all data
		use "$CCRE\Summary Stats\No_Splits_BIHS.dta", replace
	* Shared Geographic Spaces (e.g. villages per __(div)__, etc.)
		* Villages per division
			bysort div WAVE Village: gen n = _n
			replace n = 0 if n != 1
			bysort div WAVE: egen count_villages_per_div = total(n)	
		* Villages per District
			cap drop n
			bysort District_Name WAVE Village: gen n = _n
			replace n = 0 if n != 1
			bysort District_Name WAVE: egen count_villages_per_dis = total(n)	
		* Villages per Upazila
			cap drop n
			bysort Upazila WAVE Village: gen n = _n
			replace n = 0 if n != 1
			bysort Upazila WAVE: egen count_villages_per_upa = total(n)				
		* Villages per Union
			cap drop n
			bysort Union WAVE Village: gen n = _n
			replace n = 0 if n != 1
			bysort Union WAVE: egen count_villages_per_uni = total(n)			
			cap drop n
	* Demographics by village
		* Religion
			tab a13, gen(religion)
				drop a13
				ren (religion1 religion2 religion3 religion4) ///
					(muslim hindu christian buddist)
			* Count district and population samples 
				gen n = 1
				bysort District_Name WAVE: egen total_samp_dis = total(n)
				bysort Village WAVE: egen total_samp_vil = total(n)
			* District count
				bysort District_Name WAVE: egen dis_muslim = total(muslim)
				bysort District_Name WAVE: egen dis_hindu = total(hindu)			
				bysort District_Name WAVE: egen dis_christian = total(christian)	
				bysort District_Name WAVE: egen dis_buddist = total(buddist)
			* Shares district
				gen share_dis_muslim = dis_muslim/total_samp_dis
				gen share_dis_hindu = dis_hindu/total_samp_dis
				gen share_dis_christ = dis_christ/total_samp_dis
				gen share_dis_buddist = dis_buddist/total_samp_dis
			* Village count
				bysort Village WAVE: egen vil_muslim = total(muslim)
				bysort Village WAVE: egen vil_hindu = total(hindu)		
				bysort Village WAVE: egen vil_christian = total(christian)			
				bysort Village WAVE: egen vil_buddist = total(buddist)
			* Shares village	
				gen share_vil_muslim = vil_muslim/total_samp_vil
				gen share_vil_hindu = vil_hindu/total_samp_vil
				gen share_vil_christ = vil_christ/total_samp_vil
				gen share_vil_buddist = vil_buddist/total_samp_vil		
			* Drop 
				drop vil_muslim-vil_buddist dis_muslim- dis_buddist
		* Language
			tab a14, gen(lang)
				gen bengali = lang1
				gen other_lang = lang2+lang3+lang4+lang5
				drop a14
			* District count
				bysort District_Name WAVE: egen dis_bengali = total(bengali)
				bysort District_Name WAVE: egen dis_other_lang = total(other_l)	
			* Shares district
				gen share_dis_bengali = dis_bengali/total_samp_dis
				gen share_dis_other_lang = dis_other_lang/total_samp_dis
			* Village count
				bysort Village WAVE: egen vil_bengali = total(bengali)
				bysort Village WAVE: egen vil_other_lang = total(other_l)				
			* Shares village	
				gen share_vil_bengali = vil_bengali/total_samp_vil
				gen share_vil_other_lang = vil_other_lang/total_samp_vil
		* Ethnic group
			tab a15, gen(ethnic)
				gen other_eth = ethnic2+ethnic4+ethnic5+ethnic6
				drop a15 ethnic2 ethnic4-ethnic6
				ren (ethnic1 ethnic3) (bangali tribal_eth)
			* District count
				bysort District_Name WAVE: egen dis_bangali = total(bangali)
				bysort District_Name WAVE: egen dis_tribal_eth = total(tribal_eth)	
				bysort District_Name WAVE: egen dis_other_eth = total(other_eth)	
			* Shares district
				gen share_dis_bangali 	 = dis_bangali/total_samp_dis
				gen share_dis_tribal_eth = dis_tribal_eth/total_samp_dis
				gen share_dis_other_eth  = dis_other_eth/total_samp_dis
			* Village count
				bysort Village WAVE: egen vil_bangali    = total(bangali)
				bysort Village WAVE: egen vil_tribal_eth = total(tribal_eth)	
				bysort Village WAVE: egen vil_other_eth  = total(other_l)				
			* Shares village	
				gen share_vil_bangali    = vil_bangali/total_samp_vil
				gen share_vil_tribal_eth = vil_tribal_eth/total_samp_vil	
				gen share_vil_other_eth  = vil_other_eth/total_samp_vil			
	* Per capita, per month expenditure outcomes
		* District
			bysort District_Name WAVE: egen mean_pcmhhx_dis  = mean(pcmhhx)
			bysort District_Name WAVE: egen mean_pcmfoodx_dis= mean(pcmfoodx)
			bysort District_Name WAVE: egen mean_pcmnonfx_dis= mean(pcmnonfx)
		* Village
			bysort Village WAVE: egen mean_pcmhhx_vil = mean(pcmhhx)
			bysort Village WAVE: egen mean_pcmfoodx_vil = mean(pcmfoodx)
			bysort Village WAVE: egen mean_pcmnonfx_vil = mean(pcmnonfx)

** Keep Relevant Variables and Save Village-level dataset
		* Keep command
			keep a01 dvcode div dcode District District_Name uzcode ///
				Upazila Upazila_Name mouzacode Village WAVE district ///
				count_villages_per_div- count_villages_per_uni ///
				total_samp_dis-share_vil_buddist ///
				share_dis_bengali-share_vil_other_lang ///
				share_dis_bangali-share_dis_other_eth ///
				share_vil_bangali-mean_pcmnonfx_vil
			drop a01
			duplicates drop
			tab div WAVE
			tab Village WAVE
		* Save 
			save "$CCRE\Code\Step 8 - Aggregation\Identifiers_Villages_No_Splits.dta", replace


(cuts)


	
		