summarize
label variable investment "investasi"
label variable CapEx "Belanja Modal"
label variable net_acq "Akuisisi Bersih"
label variable R_and_D1 "Belanja R&D"
label variable advertising1 "Belanja Iklan"
label variable vol "Keriangan"
label variable id_vol "ID Keriangan"
label variable at "Total Aset"
label variable ME_BE "Rasio Pasar ke Buku"
label variable cash_flow "Alur Kas"
label variable book_leverage "Manfaat"
label variable firm_age "Usia Perusahaan"
label variable AGE "Usia Pelaksana"
label variable tenure "Masa Jabatan"
label variable TDC1 "Kekayaan"

*Format ulang string state
encode STATE, gen(state)
*Atasi waktu yang berulang
egen stateid =group( state)
drop if fyear==fyear[_n-1]
xtset state fyear
*Table 1
*Risk-taking measures
by Married Single, sort : tabstat investment CapEx R_and_D1 advertising acquisitions vol id_vol, statistics( mean median p1 p99 count )
*Control variables
by Married Single, sort : tabstat at ME_BE cash_flow book_leverage firm_age AGE tenure TDC1, statistics( mean median p1 p99 count )

*Table 2
* Run a fixed effects regression for volatility:
xtreg vol Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage vol_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression for volatility:
xtreg vol Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage vol_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results2
estimates table fe_results2

estimates store re_results2
estimates table re_results2
estimates table fe_results2 re_results2, star stats(N)

*Table 3.1
* Run a fixed effects regression investment:
xtreg investment Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression investment:
xtreg investment Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results31
estimates table fe_results31

estimates store re_results31
estimates table re_results31

*Table 3.2
* Run a fixed effects regression net_acq:
xtreg net_acq Single cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage net_acq_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression net_acq:
xtreg net_acq Single cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage net_acq_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results32
estimates table fe_results32

estimates store re_results32
estimates table re_results32

*Table 3.3
* Run a fixed effects regression R&D + advertising:
xtreg (R_and_D1 advertising) Single cash_flow ME_BE_lag1 log_AT_lag1 book_leverage L.(R_and_D1 advertising) firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression R&D + advertising:
xtreg (R_and_D1 advertising) Single cash_flow ME_BE_lag1 log_AT_lag1 book_leverage L.(R_and_D1 advertising) firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results33
estimates table fe_results33

estimates store re_results33
estimates table re_results33

estimates table fe_results31 re_results31 fe_results32 re_results32 fe_results33 re_results33, star stats(N)

*Table 4
* Run a fixed effects regression investment:
gen idvolxsingle=id_vol*Single

xtreg investment id_vol_lag1 Single  idvolxsingle cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression investment:
xtreg investment id_vol_lag1 Single  idvolxsingle cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results4
estimates table fe_results4

estimates store re_results4
estimates table re_results4

*Table 5
* Run a fixed effects regression investment coloumn 1:
xtreg Single Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_1
*Run a fixed effects regression investment coloumn 2:
xtreg id_vol Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_2
*Run a fixed effects regression investment coloumn 3:
xtreg investment Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_3
* Display the regression results:
estimates table fe_results_col_1 fe_results_col_2 fe_results_col_3, star stats(N)

*Uji validitas instrumen
alpha Single id_vol investment Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, item
*Poin 4
// Load the existing dataset
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\Replikasi tabel.dta", clear

// Filter the dataset to include only the years 2000-2020
keep if sic_code >= 2000 & sic_code <= 3999

// Save the filtered dataset as a new file
save "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\dataset sic_code.dta", replace

*Gunakan untuk replikasi detail project poin 4
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\dataset sic_code.dta", clear
*Format ulang string state
encode STATE, gen(state)
*Atasi waktu yang berulang
egen stateid =group( state)
drop if fyear==fyear[_n-1]
xtset state fyear
*Ulangi pembuatan semua tabel yang ada
*Table 1
*Risk-taking measures
by Married Single, sort : tabstat investment CapEx R_and_D1 advertising acquisitions vol id_vol, statistics( mean median p1 p99 count )
*Control variables
by Married Single, sort : tabstat at ME_BE cash_flow book_leverage firm_age AGE tenure TDC1, statistics( mean median p1 p99 count )

*Table 2
* Run a fixed effects regression for volatility:
xtreg vol Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage vol_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression for volatility:
xtreg vol Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage vol_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results2
estimates table fe_results2

estimates store re_results2
estimates table re_results2
estimates table fe_results2 re_results2, star stats(N)

*Table 3.1
* Run a fixed effects regression investment:
xtreg investment Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression investment:
xtreg investment Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results31
estimates table fe_results31

estimates store re_results31
estimates table re_results31

*Table 3.2
* Run a fixed effects regression net_acq:
xtreg net_acq Single cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage net_acq_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression net_acq:
xtreg net_acq Single cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage net_acq_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results32
estimates table fe_results32

estimates store re_results32
estimates table re_results32

*Table 3.3
* Run a fixed effects regression R&D + advertising:
xtreg (R_and_D1 advertising) Single cash_flow ME_BE_lag1 log_AT_lag1 book_leverage L.(R_and_D1 advertising) firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression R&D + advertising:
xtreg (R_and_D1 advertising) Single cash_flow ME_BE_lag1 log_AT_lag1 book_leverage L.(R_and_D1 advertising) firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results33
estimates table fe_results33

estimates store re_results33
estimates table re_results33

estimates table fe_results31 re_results31 fe_results32 re_results32 fe_results33 re_results33, star stats(N)

*Table 4
* Run a fixed effects regression investment:
gen idvolxsingle=id_vol*Single

xtreg investment id_vol_lag1 Single  idvolxsingle cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression investment:
xtreg investment id_vol_lag1 Single  idvolxsingle cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results4
estimates table fe_results4

estimates store re_results4
estimates table re_results4

*Table 5
* Run a fixed effects regression investment coloumn 1:
xtreg Single Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_1
*Run a fixed effects regression investment coloumn 2:
xtreg id_vol Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_2
*Run a fixed effects regression investment coloumn 3:
xtreg investment Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_3
* Display the regression results:
estimates table fe_results_col_1 fe_results_col_2 fe_results_col_3, star stats(N)
*Uji validitas instrumen
alpha Single id_vol investment Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, item

*Poin 5
// Load the existing dataset
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\Replikasi tabel.dta", clear

// Filter the dataset to include only the years 2000-2020
keep if fyear <= 2000

// Save the filtered dataset as a new file
save "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\dataset below 2000.dta", replace

*Gunakan untuk replikasi detail project poin 5
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\dataset below 2000.dta", clear
*Format ulang string state
encode STATE, gen(state)
*Atasi waktu yang berulang
egen stateid =group( state)
drop if fyear==fyear[_n-1]
xtset state fyear
*Ulangi pembuatan semua tabel yang ada
*Table 1
*Risk-taking measures
by Married Single, sort : tabstat investment CapEx R_and_D1 advertising acquisitions vol id_vol, statistics( mean median p1 p99 count )
*Control variables
by Married Single, sort : tabstat at ME_BE cash_flow book_leverage firm_age AGE tenure TDC1, statistics( mean median p1 p99 count )

*Table 2
* Run a fixed effects regression for volatility:
xtreg vol Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage vol_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression for volatility:
xtreg vol Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage vol_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results2
estimates table fe_results2

estimates store re_results2
estimates table re_results2
estimates table fe_results2 re_results2, star stats(N)

*Table 3.1
* Run a fixed effects regression investment:
xtreg investment Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression investment:
xtreg investment Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results31
estimates table fe_results31

estimates store re_results31
estimates table re_results31

*Table 3.2
* Run a fixed effects regression net_acq:
xtreg net_acq Single cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage net_acq_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression net_acq:
xtreg net_acq Single cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage net_acq_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results32
estimates table fe_results32

estimates store re_results32
estimates table re_results32

*Table 3.3
* Run a fixed effects regression R&D + advertising:
xtreg (R_and_D1 advertising) Single cash_flow ME_BE_lag1 log_AT_lag1 book_leverage L.(R_and_D1 advertising) firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression R&D + advertising:
xtreg (R_and_D1 advertising) Single cash_flow ME_BE_lag1 log_AT_lag1 book_leverage L.(R_and_D1 advertising) firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results33
estimates table fe_results33

estimates store re_results33
estimates table re_results33

estimates table fe_results31 re_results31 fe_results32 re_results32 fe_results33 re_results33, star stats(N)

*Table 4
* Run a fixed effects regression investment:
gen idvolxsingle=id_vol*Single

xtreg investment id_vol_lag1 Single  idvolxsingle cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression investment:
xtreg investment id_vol_lag1 Single  idvolxsingle cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results4
estimates table fe_results4

estimates store re_results4
estimates table re_results4

*Table 5
* Run a fixed effects regression investment coloumn 1:
xtreg Single Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_1
*Run a fixed effects regression investment coloumn 2:
xtreg id_vol Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_2
*Run a fixed effects regression investment coloumn 3:
xtreg investment Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_3
* Display the regression results:
estimates table fe_results_col_1 fe_results_col_2 fe_results_col_3, star stats(N)
*Uji validitas instrumen
alpha Single id_vol investment Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, item

*Poin 6
// Load the existing dataset
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\Replikasi tabel.dta", clear

// Filter the dataset to include only the years 2000-2020
keep if fyear >= 2000

// Save the filtered dataset as a new file
save "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\dataset above 2000.dta", replace

*Gunakan untuk replikasi detail project poin 6
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\dataset above 2000.dta", clear
*Format ulang string state
encode STATE, gen(state)
*Atasi waktu yang berulang
egen stateid =group( state)
drop if fyear==fyear[_n-1]
xtset state fyear
*Ulangi pembuatan semua tabel yang ada
*Table 1
*Risk-taking measures
by Married Single, sort : tabstat investment CapEx R_and_D1 advertising acquisitions vol id_vol, statistics( mean median p1 p99 count )
*Control variables
by Married Single, sort : tabstat at ME_BE cash_flow book_leverage firm_age AGE tenure TDC1, statistics( mean median p1 p99 count )

*Table 2
* Run a fixed effects regression for volatility:
xtreg vol Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage vol_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression for volatility:
xtreg vol Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage vol_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results2
estimates table fe_results2

estimates store re_results2
estimates table re_results2
estimates table fe_results2 re_results2, star stats(N)

*Table 3.1
* Run a fixed effects regression investment:
xtreg investment Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression investment:
xtreg investment Single  cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results31
estimates table fe_results31

estimates store re_results31
estimates table re_results31

*Table 3.2
* Run a fixed effects regression net_acq:
xtreg net_acq Single cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage net_acq_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression net_acq:
xtreg net_acq Single cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage net_acq_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results32
estimates table fe_results32

estimates store re_results32
estimates table re_results32

*Table 3.3
* Run a fixed effects regression R&D + advertising:
xtreg (R_and_D1 advertising) Single cash_flow ME_BE_lag1 log_AT_lag1 book_leverage L.(R_and_D1 advertising) firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression R&D + advertising:
xtreg (R_and_D1 advertising) Single cash_flow ME_BE_lag1 log_AT_lag1 book_leverage L.(R_and_D1 advertising) firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results33
estimates table fe_results33

estimates store re_results33
estimates table re_results33

estimates table fe_results31 re_results31 fe_results32 re_results32 fe_results33 re_results33, star stats(N)

*Table 4
* Run a fixed effects regression investment:
gen idvolxsingle=id_vol*Single

xtreg investment id_vol_lag1 Single  idvolxsingle cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, fe

* Run a random effects regression investment:
xtreg investment id_vol_lag1 Single  idvolxsingle cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage investment_lag1 firm_age AGE age_Single tenure tenure_Single CEO_prominence Firm_prominence, re

* Display the regression results:
estimates store fe_results4
estimates table fe_results4

estimates store re_results4
estimates table re_results4

*Table 5
* Run a fixed effects regression investment coloumn 1:
xtreg Single Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_1
*Run a fixed effects regression investment coloumn 2:
xtreg id_vol Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_2
*Run a fixed effects regression investment coloumn 3:
xtreg investment Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, fe
estimates store fe_results_col_3
* Display the regression results:
estimates table fe_results_col_1 fe_results_col_2 fe_results_col_3, star stats(N)
*Uji validitas instrumen
alpha Single id_vol investment Community cash_flow  ME_BE_lag1 log_AT_lag1 book_leverage id_vol_lag1 investment_lag1 firm_age AGE tenure TDC1 CEO_prominence Firm_prominence payroll_growth CEAI_growth, item
