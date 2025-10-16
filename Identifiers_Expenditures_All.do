*------------------------------------------------------*
** Identifier File in 3 Parts for Expenditure Data    **  * Individual level *
*------------------------------------------------------*
clear all

** Priors
	global CCRE "C:\Users\ngran\Dropbox\JHODD - CCRE"
	global ModA "$CCRE\BIHS Data\module a data"
	global folder "$ModA\Clean_Identifiers"
		
** Expenditure Data Tables
	* COLUMN 1 - All data
	* WAVE 1: 2011-2012
		use "$folder\W1_identifiers.dta", replace
			tabstat pcmhhx , by(div) stat(mean SD min med max N)
			tabstat pcmfoodx , by(div) stat(mean SD min med max N)
			tabstat pcmnonfx , by(div) stat(mean SD min med max N)
	* WAVE 2: 2015
		use "$folder\W2_identifiers.dta", replace
			tabstat pcmhhx , by(div) stat(mean SD min med max N)
			tabstat pcmfoodx , by(div) stat(mean SD min med max N)
			tabstat pcmnonfx , by(div) stat(mean SD min med max N)		
	* WAVE 3: 2018-2019
		use "$folder\W3_identifiers.dta", replace
			tabstat pcmhhx , by(div) stat(mean SD min med max N)
			tabstat pcmfoodx , by(div) stat(mean SD min med max N)
			tabstat pcmnonfx , by(div) stat(mean SD min med max N)		

	* COLUMN 2 - No Splits
	* FIRST WITH 
		use "$CCRE\Summary Stats\No_Splits_BIHS.dta", replace			
	* ALL EXPENDITURE, monthly
		tabstat pcmhhx if WAVE == 2011, by(div) stat(mean SD min med max N)
		tabstat pcmhhx if WAVE == 2015 , by(div) stat(mean SD min med max N)
		tabstat pcmhhx if WAVE == 2019 , by(div) stat(mean SD min med max N)
	* FOOD EXPENDITURE, monthly
		tabstat pcmfoodx if WAVE == 2011, by(div) ///
			stat(mean SD min med max N)			
		tabstat pcmfoodx if WAVE == 2015, by(div) ///
			stat(mean SD min med max N)					
		tabstat pcmfoodx if WAVE == 2019, by(div) ///
			stat(mean SD min med max N)	
	* NONFOOD EXPENDITURE, monthly
		tabstat pcmnonfx if WAVE == 2011, by(div) stat(mean SD min med max N)
		tabstat pcmnonfx if WAVE == 2015, by(div) stat(mean SD min med max N)
		tabstat pcmnonfx if WAVE == 2019, by(div) stat(mean SD min med max N)		
	
	* COLUMN 3 - Stable and Stationary	
	* THEN WITH 
		use "$CCRE\Summary Stats\stable_stationary_DATA.dta", replace
	* ALL EXPENDITURE, monthly
		tabstat pcmhhx if WAVE == 2011, by(div) stat(mean SD min med max N)
		tabstat pcmhhx if WAVE == 2015 , by(div) stat(mean SD min med max N)
		tabstat pcmhhx if WAVE == 2019 , by(div) stat(mean SD min med max N)
	* FOOD EXPENDITURE, monthly
		tabstat pcmfoodx if WAVE == 2011, by(div) ///
			stat(mean SD min med max N)			
		tabstat pcmfoodx if WAVE == 2015, by(div) ///
			stat(mean SD min med max N)					
		tabstat pcmfoodx if WAVE == 2019, by(div) ///
			stat(mean SD min med max N)	
	* NONFOOD EXPENDITURE, monthly
		tabstat pcmnonfx if WAVE == 2011, by(div) stat(mean SD min med max N)
		tabstat pcmnonfx if WAVE == 2015, by(div) stat(mean SD min med max N)
		tabstat pcmnonfx if WAVE == 2019, by(div) stat(mean SD min med max N)		
	