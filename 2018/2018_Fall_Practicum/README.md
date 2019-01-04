To find out which components may result in or be related to the malfunction of ADAS systems,
we need to figure out which data records are related to ADAS and which data records are not related to or have influence on ADAS.
Since the data volume was large, it was difficult to examine all records and label whether the data is related to ADAS.
Hence, we needed to build a classifier to automate the process of identifying ADAS related reports.
The idea of building a classifier is to train the model on part of the data,
and then apply the model on the rest of the data set,
so that we can label all data records.

Our research map involved data extraction.
We filtered our data records to those vehicles (models) manufactured after 2012,
the year when ADAS starts to be popular.
The filtered records were then used to get a sample of 2500 data records to be used as a training set.
To train a supervised machine learning model,
we manually labeled the training set to get our target variables to indicate whether reports are related to ADAS. 
Next, we explored the data set and manipulated the data by introducing data cleaning and feature engineering processes
to get the data ready for model fitting.
The model training came next and we used the models to make prediction on the remaining unlabeled 2012-2018 data 
to get all reports labeled.
In the last part of our analysis, 
we performed qualitative analysis and
utilized text mining to understand what issues being reported as well as used visualization
to compare ADAS-related and non-ADAS-related reports to find out whether ADAS can help improve safety.


The following is the flow chart of our approach.
![](https://github.com/WeihaoZeng/Work_Sample/blob/master/2018/2018_Fall_Practicum/General_workflow.png)



In part one (to find ADAS related reports):

We cleaned the dataset, then we utilized sklearn to build predictive model.
Since we have a small training set (less than 2500 records), we want to make full
use of the data by using 5-fold cross-validation. To avoid data leakage (information
leaked from validation set to the training set and hence introducing bias) from in the
cross-validation process, pipeline along with RandomizedSearchCV in sklearn can make
sure in each cross-validation loop, all data preprocess steps are fitted on the training, and
the data transformation are performed on all records in the dataset. 

The following is the working flow of our model building process:


![](https://github.com/WeihaoZeng/Work_Sample/blob/master/2018/2018_Fall_Practicum/part1.png)

In sum, the model fitting mechanism works as follow:
1. Initialize RandomizedSearchCV;
2. Start an iteration and randomly select a set of predefined hyper parameters;
3. In each cv loop:

    (a, b and c are performed at the same time using feature union)

    a. extract numeric columns and delete columns which lead to data leakage (it
    is a specific problem due to our data manipulation method, please see
    notebook for more information);

    b. extract categorical columns and perform one - hot encoding, to convert
    categorical values to numeric values for model fitting purpose;

    c. extract text columns and run TfidfVectorizer, to create a document by
    term matrix and evaluate the importance of each word (or combination of
    words created by the n-gram technique in the TfidfVectorizer);

    d. combine outputs from previous three steps through feature union;

    e. build gradient boosting machine (an ensemble model for Decision Tree
    Boosting);

4. Return to step 2 until all iterations are done;
5. Select the best set of hyper parameters according to the mean AUC (an evaluation
metric for imbalanced classification problem, the higher the better), then refit on
the whole dataset to get the final model.




In part two (to understand ADAS related reports):


![](https://github.com/WeihaoZeng/Work_Sample/blob/master/2018/2018_Fall_Practicum/part2.png)


In the Text preprocessing I, the data of complaint were segmented into two groups.
One is related to ADAS and another is not related to ADAS. Then we format and clean
up the data by lower case the words and remove the tags, special characters and special
digits. These characters and digits, like “\n” and “\t”, are meaningless in our analysis and
we want to focus on the words related to car and vehicle. Also, we created a list of stop
words combining the words about brands and common ones such as ‘car’ and ‘vehicle’
and the stop words list in the sklearn, so that the algorithm would remove them in the part
of Extract keywords. The list of stop words is shown in the appendixes.
 
 When extracting keywords, we first used the CountVectorizer to count frequency
of words and then transform them in the value of term frequency–inverse document
frequency (Tf-Idf). After that, the extracted keywords would be sorted based on their TfIdf
score. Using data visualization, we made a comparison between the keywords related
to ADAS and the one not related to ADAS.
 
 For better result in topic modeling, we performed additional steps of processing in
Text preprocessing II. Because the algorithm of topic modeling cannot remove the stop
words and punctuations, we removed them in this part. At the same time, we formed the
bigram and trigram in the case that some words will show up together. Some inflected
forms of a word were lemmatized to their original forms which includes noun, adj, adv
and verb. The dictionaries and corpus are created for the need of algorithms.

We used Latent Semantic Analysis(LSA) and Latent Dirichlet Allocation(LDA)
in topic modeling. For comparison, we recorded the performance of models in topic
coherence in different numbers of topics. Once we found out the optimal model, we
exported the topics and related complaints for further analysis.
