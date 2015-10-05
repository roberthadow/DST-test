---
title: "Getdata Assignment 1"
author: "Robert Hadow"
date: "5 October 2015"
output: html_document
---

The reader is referred to UCIHAR Codebook.Rmd which contains all of the following text as well as code and explanatory notes.

# Study Design
The UCI HAR dataset described herein was generated in a series of observations of human physical activity using a smartphone's inbuilt accelerometer and gyroscope.  These observations of thirty volunteers in six activities were collected in Genoa in 2012.

Two detectors of this type can directly measure the following at a rate of fifty observations per second:

- linear acceleration in three dimensions
- orientation in three dimensions

Using time-series of these observations, an analyst may calculate other measures, including:

- axial acceleration in three dimensions
- jerk in three dimensions (time derivative of acceleration)
- angular jerk in three dimensions (time derivative of angular acceleration)
- decomposition of these measures in the frequency domain (Fourier Transform)  

The data is further analyzed for measures of central tendency and error.  In total, 561 measures are generated. 

This data was delivered to us after the first round of calculation and analysis. It includes 18 million data points in 26 data files.  There are two additional files of human-readable description.  The following data files were used and reorganized here:

- features    -   descriptions of summary observations data
- X_test      -   summary observation data 
- X_train     -   summary observation data 
- subject_test  - subject identification
- subject_train - subject identification
- y_test      -   exercise type
- y_train     -   exercise type

# Data Approach

We used the seven data files to develop, conceptually, a tidy cube of data along three dimensions:

- 6 exercises
- 30 subjects
- 77 summary measures

Principles of tidy data organization limited us to presentations in two dimensions: columns, describing attributes of the data, and rows, describing particular observations. A tidy format should allow use of the data with the minimum amount of manipulation,based on the purposes for which the data will be analyzed. We designed our data set to allow its use with the following operations, listed here in decreasing order of priority:

1. viewing as is (no manipulation)
2. summary measures, including sum, mean, median,etc
3. grouping and subsetting (logical rearrangement, row-wise)
4. reordering (physical rearrangement, row-wise)
5. numerical manipulation (modifying or adding columns)
6. disassembly and reassembly of the data block

## Ease of Viewing
To accommodate viewing (goal 1) we put exercise and subject leftmost in the tableau.  
Insofar as we anticipated the user would rearrange the row order to meet his or her needs, we left the order as it was delivered to us, first test data then training data (because that was alphabetical if for no other reason).

## Accomodate Summary Measures
All values of a particular type, i.e. "tBodyAcc-mean" are in the same column (a "wide" or "un-stacked" layout), accommodating summary measures.  We stripped parentheses from the column names.  Because the parentheses were common, they added no information, but they did add significantly to the file size.

## Accomodate Grouping
Each observation appears in a row, all of the attributes in columns.

## Reordering
Observations may be reordered row-wise without other manipulation.

## Numerical Manipulation
We chose to leave activity as a numerical attribute in the main data table.  This keeps the entire table numeric data. Having one character column in a 79 column table, we thought, is unnecessary complexity and adds no information. We provided the activity codes as a separate table.

## Wholesale Changes to Data Structure
A two-table structure is far easier to manipulate than the 26 we started with.

# Details of Data Conversion

We downloaded the raw data and reference materials according to the script described in the codebook.


## Reading Data Files into R

We read all of the data files into R.  We used this opportunity to check the parameters for this conversion and to see which files were relevant.  


## Inspection and House Cleaning

We inspected the files, made adjustments to the scripts, and dumped unnecessary files and objects.  


## Tidy Data

We created a tidy data set using the following steps:

* organize and apply column names to the test data set
* organize subject data, append it to the observations
* organize exercise data, append it to the observations
* redact the data,eliminating unwanted columns
* combine the test and train datasets
  

## Create Codebook

We were careful not to make any assumptions about the data that was not in the raw data package.  

# Codebook

The documentation that came with the raw data contains descriptive attribute names from which a reader may surmise the origin and use of the associated data elements.  For more detailed explanations, the user is referred to the Non Linear Complex Systems Laboratory, Genoa, activity recognition@smartlab.ws.

The data dictionary that follows was generated from the UCIHAR data tables.  Similarly named attributes may be used as primary keys.

Trailing digits refer to raw data not included in this set.

All data in the set is normalized -1.00 - 1.00.


## Summary Dataset - UCIHAR_summary

UCIHAR contains `r I(dataPoints)` measures.  It has `r I(nrow(ucihar))` rows of data.

UCIHAR_summary is a summary of UCIHAR.  It provides the means of the data in UCIHAR. 


