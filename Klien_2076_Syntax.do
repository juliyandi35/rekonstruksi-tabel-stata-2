*Load the existing dataset
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\Klien_2076_Data.dta", clear
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

rename R_and_D1 RandD
rename net_acq NetAcquisitions
rename vol Volatility
rename id_vol IdVol
rename id_vol_lag1 IdVolt1
rename at Assets
rename ME_BE_lag1 Mt1Bt1
rename ME_BE MB
rename cash_flow CF
rename book_leverage Leverage
rename firm_age FirmAge
rename AGE Age
rename tenure Tenure
rename TDC1 Wealth
rename log_AT_lag1 logAt1
rename vol_lag1 Volt1
rename age_Single AgexSingle
rename tenure_Single TenurexSingle
rename CEO_prominence CEOProminence
rename Firm_prominence FirmProminence
rename investment_lag1 Investmentt1
rename payroll_growth Payroll
rename CEAI_growth CEAI
rename net_acq_lag1 NetAcquisitionst1
save "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\Klien_2076_Data_renamed", replace
*Format ulang string state
encode STATE, gen(state)
*Atasi waktu yang berulang
egen stateid =group( state)
drop if fyear==fyear[_n-1]
drop if fyear==fyear[_n-1]
xtset state fyear
*Table 1
*Risk-taking measures
by Married Single, sort : tabstat investment CapEx RandD advertising NetAcquisitions Volatility IdVol, statistics( mean median p1 p99 count )
*Control variables
by Married Single, sort : tabstat Assets MB CF Leverage FirmAge Age Tenure Wealth, statistics( mean median p1 p99 count )

*Table 2
* Run a fixed effects regression for volatility:
xtreg Volatility Single  CF  Mt1Bt1 logAt1 Leverage Volt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression for volatility:
xtreg Volatility Single  CF  Mt1Bt1 logAt1 Leverage Volt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results2
estimates table fe_results2

estimates store re_results2
estimates table re_results2
estimates table fe_results2 re_results2, star stats(N)

*Table 3.1
* Run a fixed effects regression investment:
xtreg investment Single  CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression investment:
xtreg investment Single  CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results31
estimates table fe_results31

estimates store re_results31
estimates table re_results31

*Table 3.2
* Run a fixed effects regression NetAcquisitions:
xtreg NetAcquisitions Single CF  Mt1Bt1 logAt1 Leverage NetAcquisitionst1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression NetAcquisitions:
xtreg NetAcquisitions Single CF  Mt1Bt1 logAt1 Leverage NetAcquisitionst1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results32
estimates table fe_results32

estimates store re_results32
estimates table re_results32

*Table 3.3
* Run a fixed effects regression RandD + advertising:
xtreg (RandD advertising) Single CF Mt1Bt1 logAt1 Leverage L.(RandD advertising) FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression RandD + advertising:
xtreg (RandD advertising) Single CF Mt1Bt1 logAt1 Leverage L.(RandD advertising) FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results33
estimates table fe_results33

estimates store re_results33
estimates table re_results33

estimates table fe_results31 re_results31 fe_results32 re_results32 fe_results33 re_results33, star stats(N)

*Table 4
* Run a fixed effects regression investment:
gen IdVolxSingle=IdVol*Single

xtreg investment IdVolt1 Single  IdVolxSingle CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression investment:
xtreg investment IdVolt1 Single  IdVolxSingle CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results4
estimates table fe_results4

estimates store re_results4
estimates table re_results4

*Table 5
* Run a fixed effects regression investment coloumn 1:
xtreg Single Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_1
*Run a fixed effects regression investment coloumn 2:
xtreg IdVol Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_2
*Run a fixed effects regression investment coloumn 3:
xtreg investment Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_3
* Display the regression results:
estimates table fe_results_col_1 fe_results_col_2 fe_results_col_3, star stats(N)

*Uji validitas instrumen
alpha Single IdVol investment Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, item
*Poin 4
*Load the existing dataset
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\Klien_2076_Data_renamed.dta", clear

*Filter the dataset to include only the years 2000-2020
keep if sic_code >= 2000 & sic_code <= 3999

*Save the filtered dataset as a new file
save "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\dataset sic_code.dta", replace

*Gunakan untuk replikasi detail project poin 4
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\dataset sic_code.dta", clear
*Format ulang string state
encode STATE, gen(state)
*Atasi waktu yang berulang
egen stateid =group( state)
drop if fyear==fyear[_n-1]
drop if fyear==fyear[_n-1]
xtset state fyear
*Ulangi pembuatan semua tabel yang ada
*Table 1
*Risk-taking measures
by Married Single, sort : tabstat investment CapEx RandD advertising NetAcquisitions Volatility IdVol, statistics( mean median p1 p99 count )
*Control variables
by Married Single, sort : tabstat Assets MB CF Leverage FirmAge Age Tenure Wealth, statistics( mean median p1 p99 count )

*Table 2
* Run a fixed effects regression for volatility:
xtreg Volatility Single  CF  Mt1Bt1 logAt1 Leverage Volt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression for volatility:
xtreg Volatility Single  CF  Mt1Bt1 logAt1 Leverage Volt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results2
estimates table fe_results2

estimates store re_results2
estimates table re_results2
estimates table fe_results2 re_results2, star stats(N)

*Table 3.1
* Run a fixed effects regression investment:
xtreg investment Single  CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression investment:
xtreg investment Single  CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results31
estimates table fe_results31

estimates store re_results31
estimates table re_results31

*Table 3.2
* Run a fixed effects regression NetAcquisitions:
xtreg NetAcquisitions Single CF  Mt1Bt1 logAt1 Leverage NetAcquisitionst1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression NetAcquisitions:
xtreg NetAcquisitions Single CF  Mt1Bt1 logAt1 Leverage NetAcquisitionst1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results32
estimates table fe_results32

estimates store re_results32
estimates table re_results32

*Table 3.3
* Run a fixed effects regression RandD + advertising:
xtreg (RandD advertising) Single CF Mt1Bt1 logAt1 Leverage L.(RandD advertising) FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression RandD + advertising:
xtreg (RandD advertising) Single CF Mt1Bt1 logAt1 Leverage L.(RandD advertising) FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results33
estimates table fe_results33

estimates store re_results33
estimates table re_results33

estimates table fe_results31 re_results31 fe_results32 re_results32 fe_results33 re_results33, star stats(N)

*Table 4
* Run a fixed effects regression investment:
gen IdVolxSingle=IdVol*Single

xtreg investment IdVolt1 Single  IdVolxSingle CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression investment:
xtreg investment IdVolt1 Single  IdVolxSingle CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results4
estimates table fe_results4

estimates store re_results4
estimates table re_results4

*Table 5
* Run a fixed effects regression investment coloumn 1:
xtreg Single Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_1
*Run a fixed effects regression investment coloumn 2:
xtreg IdVol Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_2
*Run a fixed effects regression investment coloumn 3:
xtreg investment Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_3
* Display the regression results:
estimates table fe_results_col_1 fe_results_col_2 fe_results_col_3, star stats(N)
*Uji validitas instrumen
alpha Single IdVol investment Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, item

*Poin 5
*Load the existing dataset
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\Klien_2076_Data_renamed.dta", clear

*Filter the dataset to include only the years 2000-2020
keep if fyear <= 2000

*Save the filtered dataset as a new file
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
by Married Single, sort : tabstat investment CapEx RandD advertising NetAcquisitions Volatility IdVol, statistics( mean median p1 p99 count )
*Control variables
by Married Single, sort : tabstat Assets MB CF Leverage FirmAge Age Tenure Wealth, statistics( mean median p1 p99 count )

*Table 2
* Run a fixed effects regression for volatility:
xtreg Volatility Single  CF  Mt1Bt1 logAt1 Leverage Volt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression for volatility:
xtreg Volatility Single  CF  Mt1Bt1 logAt1 Leverage Volt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results2
estimates table fe_results2

estimates store re_results2
estimates table re_results2
estimates table fe_results2 re_results2, star stats(N)

*Table 3.1
* Run a fixed effects regression investment:
xtreg investment Single  CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression investment:
xtreg investment Single  CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results31
estimates table fe_results31

estimates store re_results31
estimates table re_results31

*Table 3.2
* Run a fixed effects regression NetAcquisitions:
xtreg NetAcquisitions Single CF  Mt1Bt1 logAt1 Leverage NetAcquisitionst1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression NetAcquisitions:
xtreg NetAcquisitions Single CF  Mt1Bt1 logAt1 Leverage NetAcquisitionst1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results32
estimates table fe_results32

estimates store re_results32
estimates table re_results32

*Table 3.3
* Run a fixed effects regression RandD + advertising:
xtreg (RandD advertising) Single CF Mt1Bt1 logAt1 Leverage L.(RandD advertising) FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression RandD + advertising:
xtreg (RandD advertising) Single CF Mt1Bt1 logAt1 Leverage L.(RandD advertising) FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results33
estimates table fe_results33

estimates store re_results33
estimates table re_results33

estimates table fe_results31 re_results31 fe_results32 re_results32 fe_results33 re_results33, star stats(N)

*Table 4
* Run a fixed effects regression investment:
gen IdVolxSingle=IdVol*Single

xtreg investment IdVolt1 Single  IdVolxSingle CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression investment:
xtreg investment IdVolt1 Single  IdVolxSingle CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results4
estimates table fe_results4

estimates store re_results4
estimates table re_results4

*Table 5
* Run a fixed effects regression investment coloumn 1:
xtreg Single Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_1
*Run a fixed effects regression investment coloumn 2:
xtreg IdVol Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_2
*Run a fixed effects regression investment coloumn 3:
xtreg investment Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_3
* Display the regression results:
estimates table fe_results_col_1 fe_results_col_2 fe_results_col_3, star stats(N)
*Uji validitas instrumen
alpha Single IdVol investment Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, item

*Poin 6
*Load the existing dataset
use "C:\Users\JULI YANDI RAHMAN\Downloads\Kerjaan\Project 2076 DL Minggu 24.00\Klien_2076_Data_renamed.dta", clear

*Filter the dataset to include only the years 2000-2020
keep if fyear >= 2000

*Save the filtered dataset as a new file
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
by Married Single, sort : tabstat investment CapEx RandD advertising NetAcquisitions Volatility IdVol, statistics( mean median p1 p99 count )
*Control variables
by Married Single, sort : tabstat Assets MB CF Leverage FirmAge Age Tenure Wealth, statistics( mean median p1 p99 count )

*Table 2
* Run a fixed effects regression for volatility:
xtreg Volatility Single  CF  Mt1Bt1 logAt1 Leverage Volt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression for volatility:
xtreg Volatility Single  CF  Mt1Bt1 logAt1 Leverage Volt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results2
estimates table fe_results2

estimates store re_results2
estimates table re_results2
estimates table fe_results2 re_results2, star stats(N)

*Table 3.1
* Run a fixed effects regression investment:
xtreg investment Single  CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression investment:
xtreg investment Single  CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results31
estimates table fe_results31

estimates store re_results31
estimates table re_results31

*Table 3.2
* Run a fixed effects regression NetAcquisitions:
xtreg NetAcquisitions Single CF  Mt1Bt1 logAt1 Leverage NetAcquisitionst1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression NetAcquisitions:
xtreg NetAcquisitions Single CF  Mt1Bt1 logAt1 Leverage NetAcquisitionst1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results32
estimates table fe_results32

estimates store re_results32
estimates table re_results32

*Table 3.3
* Run a fixed effects regression RandD + advertising:
xtreg (RandD advertising) Single CF Mt1Bt1 logAt1 Leverage L.(RandD advertising) FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression RandD + advertising:
xtreg (RandD advertising) Single CF Mt1Bt1 logAt1 Leverage L.(RandD advertising) FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results33
estimates table fe_results33

estimates store re_results33
estimates table re_results33

estimates table fe_results31 re_results31 fe_results32 re_results32 fe_results33 re_results33, star stats(N)

*Table 4
* Run a fixed effects regression investment:
gen IdVolxSingle=IdVol*Single

xtreg investment IdVolt1 Single  IdVolxSingle CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, fe

* Run a random effects regression investment:
xtreg investment IdVolt1 Single  IdVolxSingle CF  Mt1Bt1 logAt1 Leverage Investmentt1 FirmAge Age AgexSingle Tenure TenurexSingle CEOProminence FirmProminence, re

* Display the regression results:
estimates store fe_results4
estimates table fe_results4

estimates store re_results4
estimates table re_results4

*Table 5
* Run a fixed effects regression investment coloumn 1:
xtreg Single Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_1
*Run a fixed effects regression investment coloumn 2:
xtreg IdVol Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_2
*Run a fixed effects regression investment coloumn 3:
xtreg investment Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, fe
estimates store fe_results_col_3
* Display the regression results:
estimates table fe_results_col_1 fe_results_col_2 fe_results_col_3, star stats(N)
*Uji validitas instrumen
alpha Single IdVol investment Community CF  Mt1Bt1 logAt1 Leverage IdVolt1 Investmentt1 FirmAge Age Tenure Wealth CEOProminence FirmProminence Payroll CEAI, item
