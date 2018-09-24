# tobeproject
Data Science: Second Project

Downloaded data from https://www.kaggle.com/kingburrito666/shakespeare-plays.
Used Stata 3.7 to create new features: 
* separated act from act.scene.line. to do feature extraction
* created number of players by play (Plot included in files)
* created number of lines by play (Plot included in files)
* created a dummy variable if a player had the most lines in a play (1 if most; 0 if not most)
  - This was the logistic regression variable

Ran logistic regression using dummy variable and the number of players, the number of lines, and the act. 
* Output from regression is included in a separate page.
* Logistic regression gave odds ratio
  - Outcome primarily had odds ratios close to 1, so not a good predictor. 

