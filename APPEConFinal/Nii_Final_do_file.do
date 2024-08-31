* Change directory to where the data is stored
 cd "/Users/nii/Desktop/APPEConFinal"

* Load the dataset
use File1updated.dta, clear


* Basic summary statistics for CO2 emissions
* Create a dummy variable to identify the group exposed to the treatment
gen treated = (country == 23)
gen non_treated = (country != 23)

* Create a dummy variable to indicate the time when the treatment started
gen time_var = year - 2019
replace time_var = . if non_treated == 1



* Summary of outcome variable
bysort treated: sum co2_emission 



* Testing the parallel trend assumption graphically

* using eventdd
eventdd co2_emission i.country i.year, timevar(time_var ) vce(cluster country) graph_op(ytitle("CO2 Emission Over Time"))


* Preserve the current state of the dataset for later restoration
preserve

* Collapse the data to mean CO2 emissions by year and treatment status
collapse (mean) co2_emission, by(year treated)


* Generate line plots for treated and non-treated groups over time
twoway (line co2_emission year if treated == 1, sort) (line co2_emission year if treated == 0, sort), ytitle(CO2 Emissions) xtitle(Year) title(Carbon Emission over Time) legend(on order(1 "South Africa" 2 "Other SSA"))

* Restore the dataset to the state before collapse
restore

* Estimating the DID estimator
* Generate post-treatment indicator
gen post_treatment_indicator = (year >= 2019)

* Generate interaction term for DiD estimation
gen DiD = post_treatment_indicator*treated

* Run the regression model with clustered standard errors and focus on the outcome variable
reg co2_emission i.country i.year DiD, vce(cluster country)

* Run the regression model with clustered standard errors including control variables
reg co2_emission i.country i.year DiD gdp_growth pop_growth , vce(cluster country)

