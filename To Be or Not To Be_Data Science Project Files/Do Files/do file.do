
***********To be, or not to be*************
***********Second Data Science Project**********
**********Author: William Duncan*************
***********First edited: 9/22/2018**************
***********Last edited: 9/22/2018**************
clear all
set more off

import delimited "C:\Users\WilliamDuncan\Desktop\Econ PhD\Introduction to Data Science\Second Project\Data\Shakespeare_data.csv"
drop if playerlinenumber==.
sort play playerlinenumber

***********Generate a feature from the string, act.scene.line to a numeric value for act only********
gen act = substr(actsceneline, 1, 1)
destring act, replace
replace act=0 if act==.
label variable act "Act number in play"

**Number of plays in dataset

fre play

****Number of players per play

by player, sort: gen nvals = _n == 1
egen noplayers=sum(nvals), by(play)
graph bar (mean) noplayers, over(play, label(angle(80))) blabel(bar) ytitle(Number of Players)
graph save Graph "C:\Users\WilliamDuncan\Desktop\Econ PhD\Introduction to Data Science\Second Project\Graphs\Number of Players per Play.gph", replace

***Number of lines per play

egen nolines=count(nvals), by(play)
graph bar (mean) nolines, over(play, label(angle(80))) ytitle(Number of Lines per Play)
graph save Graph "C:\Users\WilliamDuncan\Desktop\Econ PhD\Introduction to Data Science\Second Project\Graphs\Number of Lines per Play.gph", replace

save "C:\Users\WilliamDuncan\Desktop\Econ PhD\Introduction to Data Science\Second Project\Data\shakespeare.dta", replace

****Generate player number******

collapse (mean) act, by(player)
gen player_number = _n
drop act
save "C:\Users\WilliamDuncan\Desktop\Econ PhD\Introduction to Data Science\Second Project\Data\player_number.dta", replace


*****Combine datasets*****
clear all
use "C:\Users\WilliamDuncan\Desktop\Econ PhD\Introduction to Data Science\Second Project\Data\shakespeare.dta"
merge m:1 player using "C:\Users\WilliamDuncan\Desktop\Econ PhD\Introduction to Data Science\Second Project\Data\player_number.dta"
drop _merge

****Generate Logistic Regression Variable*****
bysort play player: egen player_lines = count(player)
egen max_player_lines=max(player_lines), by(play)
replace max_dummy =1 if player_lines==max_player_lines
drop player_lines max_player_lines

****Logistic Regression*******
logistic max_dummy nolines noplayers nvals act


