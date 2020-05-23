# getting_and_cleaning_data
Getting and Cleaning Data Course Project

## Content:

This repository contains the following files:
* [CodeBook](./CodeBook.md): Contains a description of the data and its variables.
* [run_analysis.R](./run_analysis.R): A script to perform the analysis on the data collected from the Samsung Galaxy S smartphone accelerometers. More details on the script in the following section.
* [data/tidy_data.txt](./data/tidy_data.txt): A tidy dataset according to the instruction from the course assignment. 

## Getting Started:
You can produce the tidy data set in `./data/tidy_data.txt` by running the script `./run_analysis.R`:

The script will download the [raw](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip") dataset, and unzip it to the `./data` folder, then it will proceed to read the various raw files, combine them into one single data unit then perform the necessary actions to to produce the tidy_data set in `./data/tidy_data.txt`.

You can then read the data using R by running the following command: 

```R
tidy_data <- read.table("./data/tidy_data.txt")
```

I consider the produced data tidy, since it can be described as follow:

* Each measured variable is contained in one column.
* Each row represent a measurement.
* The data table represent one single unit (captors measurement for the experiment subjects for a set of activities).

