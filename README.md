# PredictingPRNGs
Predicting Pseudo Random Number Generators using machine learning techniques

To run single instances of a learner, use the exampleKNN.m script, for example, to run the KNN.
To rerun out experiments, run deployConfig.m.

We have implemented a total of five learners:

Random Sampling
	-Randomly samples propotionally to the ratio of labels in the training set
	
Random Forests
	-Traditional random forest algorithm, grows bootstrap trees with fixed depth
	-Predicts the mode of the labels predicted by the trees
	
KNN (k-nearest neighbours)
	-Predicts the mode of the k nearest neighbours labels from the training set
	
Naive Bayes
	-Assumes each feature given the label is conditionally independent of all 
	other features
	-Learns the probabilities by counting in the training set, and predicts the 
	label with the highest probability according to an unnormalized bayes rule
	
Logistic Regression
	-Traditional logistic regression classifier trained used gradient descent 
	with the Barzilai Borwein equations for the update
	-predicts the most likely label for each output
	
We have also implemented or hard coded several Pseudo Random Number Generators (PRNGs). 
For each one, we support values of k = 2, 3, and 5 labels, unless otherwise noted.

Mercenne Twister
	-we have wrapped a function around the default implementation of Matlab's 
	built inMercenne Twister algorithm.

Linear Congruential Generator
	-We have implemeneted a Linear Congruential Generator using the constants from Borland C/C++
	
Random.org
	-We have downloaded some data from Random.org, which promises "true randomness" from atmospheric noise
	
Yasha
	-Yasha entered roughly 16,000 "random" numbers 
	
Kim 
	-Kim enetered roughly 16,000 "random" numbers
