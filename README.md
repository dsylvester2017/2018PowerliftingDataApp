# 2018PowerliftingDataApp

# Intro
The purpose of this application is to anaylze powerlifting performance during the 2018 nationals held in Australia. I held this dataset in particular interest because I practice the squat, benchpress, and deadlift very often every week and was curious as to what the average national athlete numbers were. Additionally, these athletes are non-tested, so it's interesting to see what they can achieve with no restrictions or regulations. 

# Dataset Info
link: https://www.kaggle.com/open-powerlifting/powerlifting-database
The powerlifting dataset originally had many different events that took place in 2018, as well as different unrelated data columns. The csv file in this project only uses data from the nationals event. Also for simplicity, the attempted weight of each lifter was removed and only the maximum lift for each exercise(bench,squat,deadlift) was kept for each athlete.
The powerlifting.csv has 500 competitors, males and female categories. The columns include the participants age, gender, best bench, best squat, best deadlift, wilk score (which is calculated based on their total and body weight ratio), body weight, total (combination of bench,squat, and deadlift), and where they placed in the event.
# Output Expected
One of the most obvious correlations from the dataset is that as the bodyweight increases, the weight lifted in each of the three exercises increases, as well as the total. Another interesting thing found from the app is that as the bodyweight increases, the wilk score(strength to bodyweight) also increased which was unexpected. 
In the first tab, you will see descriptive statistic information based on the left panel variables you select. 
In the second tab, you will see a box plot. The left panel variables control the X-axis, and the right panel selection controls the y-axis variable of the boxplot. You can also filter by gender using the bottom left panel option selection
In the third tab, Linear regression model is performed. You can select the x-acis on the left panel, y-axis on the right panel similar to the second tab.
# Continous Variables
The continuous variables can be filtered for each tab and they include:
Age (Age of the participant)
Bodyweight (Bodyweight in Kg)
Squat (Maximum squat in Kg)
Bench Press (Maximum bench press in Kg)
Deadlift (Maximum deadlift in Kg)
Total (sum of bench,squat,deadlift in Kg)
Wilks (Bodyweight to total ratio)

# Categorical Variables
The only categorical variable used in this project was gender (Male or Female) and can be filtered for all calculations on the left panel at the bottom of the screen.
# How to Run 2018PowerliftingDataApp
## Requirements 
### Must have R language (R studio IDE) downloaded on your computer
### Download shiny by installing the package as shown in step 2

## Step 1: Open R Studio and create a project

## Step 2: Install shiny, load it, and run the github repo line
```
install.packages('shiny') 
library(shiny) 
shiny::runGitHub(repo = "2018PowerliftingDataApp",username = "dsylvester2017",ref="master")  
```
## Github link 


## live project using shinyapps.io link
https://dsylvester2017.shinyapps.io/dsylvester2017ShinyApp/































































































































