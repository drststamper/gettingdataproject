# gettingdataproject

## Getting and cleaning data course project: Introduction

This readme document is meant to describe thoughts, decisions and reasoning used to complete
the course project for Getting and Cleaning Data. A description of different parts of the R-script is provided, along with mentioning of resources used and other remarks that (hopefully) help to understand my submission for this assignment. Details about variables and dataset related aspects are (also) mentioned in the Codebook file.

## Thoughts, decisions and reasoning before describing the R script

Prior to starting to work on the R-script, I had downloaded the zip file containing the dataset to my working directory using the link provided in the Course Project section. After that I had unzipped it into my working directory. Therefore, lines of code performing these steps will not be present in my R script. Why? Since every student is using the same dataset, I considered it to be unnecessary: it would have been different if every student may have used a different dataset to perform the Course Project. 

Another important decision was to focus on providing guiding comments that, at first, help me navigate and read through the R script, and automatically, make it possible for others to 'follow' me. 

A final remark here is that I have chosen to put in steps that I personally understand: It will most likely be the case that things can be done in less lines of code, but that would be more difficult for me to understand (and explain through comments in the code). Please take this into account if you're a (very) seasoned R-programmer.

I have divided the R script into labelled sections (<A>, <B> etc.), so I can give a detailed background for each section. Note though, that this has resulted in a rather long R-script file (kind of violating what was said about the length of proper R script files in R Programming).

## The R-script

### The R-script, "A"- section

This first section of my script deals with getting the data into R. As can be read, I spell out the location of each file and store it, so I can use it in the read.table() function. Although advanced ways of reading in data using that function exist (making more use of the parameters), the way I put it in is understandable for me. 

### The R-script, "B"- section

Next, I focused on getting all individual parts (all the separate files) to contain 'understandable' items. This meant changing the variable values for the activities using the file provided (=activity_labels) and providing columnname(s) for the subject files data, x- and y- files data. 

### The R-script, "C"- section

With the prior section of the script done, I was able to combine data. First I combined the train and test data separately by their parts (subject, y- and x-). Finally, I combined these two (test and train) using the rbind function. This yielded the 'raw' dataset from which I could extract the necessary columns.

I made a decision to only change the names of the columns of my 'raw' dataset that I wanted to include in my final, tidy dataset.

### The R-script, "D"- section

To determine the nr of columns to include, I have used the features-info file. In this file, it is stated that means and deviations are labelled with mean() and std() at the end. Furthermore, the file states that additional mean values, based on the angle() measurements, are present in the data. Since these means are based on a value that isn't a mean itself (angle), I have decided to exclude this from my selection. Also, columns with frequencies of a mean have been excluded, since they deal with frequencies rather than a mean. These decisions yielded a 66 + 2 (=SubjectID, Activity) columned dataset which I called 'desired_dataset'. 

In the final part of this section of the script, I create a grouping by the SubjectID-Activity columns and then apply dcast() to create the required Subject-Activity-MeanPerMeasure dataset.

### The R-script, "E"- section

With the D section completed, I also complete the last required step, which is creating a .txt file containing the tidy_dataset. This has 180 rows (30 subjects times 6 activities) with 68 columns (SubjectID, Activity, mean for every variable). 

I had decided to include the column names, but exclude the row names (1-180, which are meaningless in my opinion) from the file. I had left the separating character to a space (" "). The file itself looks best when opened using an application like 'Notepad++'. 

## Final remarks, decisions and/or reasoning

Obviously, I encountered some challenges and used a number of resources for this project. In all, I have used the following resources for inspiration/ my problem solving:

* stackoverflow (for various issues that I had with, among other things, using regular expressions)
* the video lectures
* the assignment FAQ thread from a TA (David Hood)
* various threads in the discussion forum discussing problems I encountered too
* the book 'Art of R Programming'
* provided links by fellow students, mentioned in threads on the discussion forum (specifically on CodeBooks)