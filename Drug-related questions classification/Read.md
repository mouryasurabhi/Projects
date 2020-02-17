# Data description
Data set is composed of three csv files: inputtrain:csv, outputtrain:csv and inputtest:csv, respectively
the input and output data of the training set, and the input data of the testing set.The csv files are in
UTF-8 encoding.

## Input of the training set
The input data of the training set is a list of 8028 drug-related questions written in French. Each line is
constituted with a unique ID, varying from 0 to 8027, followed by one question. These ID relate to the
ID in the output file. The questions are 1 to 180 words-long sentences whose intent has to be predicted.
In the input file, the first line is the header and columns are separated by "," characters.
Here below is an example of the input file content:
6,atrax n’est-il pas dangereux au long terme ?
Which means in English: "6,isn’t atrax dangerous in the long term?"
## Output of the training set
The output data of the training set contains the intent of each question in the input file. In this way,
each line is composed of the same ID as in the input file and an intent encrypted by a number between
1 and 50. The first line is the header and columns are separated by "," characters.
Here is an example of the input file content: 6,48
In this example, the intent of the question "isn’t atrax dangerous in the long term?" corresponds to the
intent encrypted by 48.
## Input of the testing set
The input file of the testing set has the same structure as the input file of the training set, that is to say
ID,question. It gathered 2035 questions in total.
## Data issues
There are many issues with this data set. First difficulty is an unequal distribution of questions and
intentions in the training and testing sets. Furthermore, questions are full of spelling mistakes and
abbreviations. Finally, not every drug name appears in the training set whereas it is an important data
to consider.
