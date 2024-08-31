* Stata Code for reshaping

// load the data from an Excel file
import excel "C:\Rbt\Macroeconomics\AdvancedMacroII\R_Stata\FormatChange.xlsx", sheet("data") firstrow clear

// rename the variables to remove spaces
rename Period1 Period_1
rename Period2 Period_2
rename Period3 Period_3

// convert from wide to long format
reshape long Period_, i(Unit) j(Period)

// export the data to a CSV file (write down the path in your PC)
export delimited using "C:\Rbt\Macroeconomics\AdvancedMacroII\R_Stata\R_Stata\newfile_stata.csv", replace

// print a message to confirm that the file was written successfully (write down the path in your PC)
di "Data written to file: C:\Rbt\Macroeconomics\AdvancedMacroII\R_Stata\newfile_stata.csv"

log close
