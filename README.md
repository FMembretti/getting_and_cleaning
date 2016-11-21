1. Files in my repo: 
My work contains those files: "run_analysis" (R script), "ReadMe" markdown document (it contains information reported on the assignment), "Codebook" document, "averageDataset.txt" (tidy data set .txt file, this is the output of my R script)

2. Explain why your dataset is tidy: 
Each variable is in one columns (for example: subject id and activity name are in separated, unique columns) and each observation is in one row : (for example: observation in row 1 is about subject 1 who is making activity "LAYING", and his/her " frequencyBodyAcc-meanFreq()-Y" is 0.13183575, etc.)

3. Explain what columns are measurements on mean and standard deviation and methodology used
I decided to use grep() function to search for keyword like mean or std in features and omit those which didn't indicate them. 












