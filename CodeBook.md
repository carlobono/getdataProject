## Code book

* Variables recovered from train and test set are binded with activity and subject with column binding, given that:
1. the order of loading for separate chunks of data is the same
2. dplyr join preserves the ordering of the original data

* In this way, the same order of loading guarantees the correct binding to observation vectors.
Moreover, both activity and subject string are converted to factor variables.

Column labels are made unique using the make.unique()

* Numerical values are cast to numerical type, and consequently are the mean and standard deviation calculations, achieved through the apply function.
* Means for the grouping of the final output is achieved through summarise_each function