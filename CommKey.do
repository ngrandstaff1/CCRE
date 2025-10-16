********************
** Community Data ** Creating a key
********************
clear all

* Set globals for data
	global BIHS_11c "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_11"
	global BIHS_15c "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_15"
	global BIHS_19c "C:\Users\ngran\Dropbox\JHODD - CCRE\BIHS Data\BIHS_19\BIHSRound3\Community"
* Set global for temp files
	global temp "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars\Community Temp Files"
	global folderc "C:\Users\ngran\Dropbox\JHODD - CCRE\Code\Step 4 - Prep Community Vars"
	
*------------------*
*  Community Keys  *
*------------------*
clear all
	** Community Key Merge
		* BIHS 2011
			use "$BIHS_11c\001_mod_ca_cb_cc_ce_community.dta", replace
				keep sl ca04 ca05 ca06 ca07
				gen WAVE = 2011
				gen ca04_h = ""
				gen ca05_h = ""
					replace ca05_h = "0" if ca05 <100 & ca05 > 9
					replace ca05_h = "00" if ca05 < 10
				gen ca06_h = ""
					replace ca06_h = "0" if ca06 < 10
				order ca04 ca04_h ca05 ca05_h ca06 ca06_h ca07 WAVE
			save "$temp\CommW1.dta", replace
		
		* BIHS 2015				
			use "$BIHS_15c\111_module_cb_community.dta", replace
				keep sl ca04 ca05 ca06 ca07				
				gen WAVE = 2015
				gen ca04_h = ""
				gen ca05_h = ""
					replace ca05_h = "0" if ca05 <100 & ca05 > 9
					replace ca05_h = "00" if ca05 < 10				
				gen ca06_h = ""
					replace ca06_h = "0" if ca06 < 10				
				order sl ca04 ca04_h ca05 ca05_h ca06 ca06_h ca07 WAVE				
			save "$temp\CommW2.dta", replace
		
		* BIHS 2019
			use "$BIHS_19c\140_r3_com_mod_ca_1.dta", replace	
				keep community div district upazila union
				destring div, replace
					ren div ca07
					ren district ca06
					ren upazila ca05
					ren union ca04
					order ca04 ca05 ca06 ca07
					gen WAVE = 2019
				gen ca04_h = ""
					replace ca04_h = "0" if ca04 <100 & ca04 > 9
					replace ca04_h = "00" if ca04 < 10	
				gen ca05_h = ""
					replace ca05_h = "0" if ca05 <100 & ca05 > 9
					replace ca05_h = "00" if ca05 < 10	
				gen ca06_h = ""
					replace ca06_h = "0" if ca06 < 10
					ren community sl // controversial move
				order sl ca04 ca04_h ca05 ca05_h ca06 ca06_h ca07 WAVE		
			save "$temp\CommW3.dta", replace		
			
		* Merge the Three Files
			use "$temp\CommW1.dta", replace
				append using "$temp\CommW2.dta"
				append using "$temp\CommW3.dta"
				tostring ca04 ca05, replace
				tostring ca06 ca07, replace force
			egen ID = concat(ca04_h ca04 ca05_h ca05 ca06_h ca06)
			destring ca04 ca05 ca06 ca07, replace
		* Save file
			save "$folderc\CommCode.dta", replace



























