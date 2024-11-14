# Introduction
This project focuses on examining a dataset containing Spotify’s most-streamed songs, with 
attributes including: 
1. Streams: Total number of streams each song has received. 
2. Danceability and Energy: Measures of musical qualities that influence how "danceable" and 
"energetic" a song feels. 
3. Mode and BPM (Beats Per Minute): Musical characteristics, where mode indicates the 
song’s key as major or minor, and BPM reflects the tempo. 
4. Playlists Counts: Inclusion in playlists across various streaming services, which often impacts 
visibility and engagement.
# Goals
The goals of this project include: 
1. Understanding Popular Music Trends: Identify key musical characteristics associated with 
high stream counts. 
2. Evaluating Relationships Among Features: Assess how song attributes (e.g., energy, 
danceability) correlate with one another. 
3. Building Predictive Models: Use regression analysis to predict stream counts based on 
musical features. 
4. Conducting Statistical Tests: Analyze differences between song categories and associations 
among variables.
# Methodology 
The analysis methodology is structured into several stages as follows: 
Data Import and Cleaning 
1. Data Import: We loaded the dataset using R’s read.csv() function, which reads the CSV file 
into a data frame. 
2. Handling Missing Values: We removed rows with missing values using the na.omit() function 
to ensure complete data, especially in critical fields such as streams, energy, and 
danceability. 
3. Data Transformation: To perform numeric operations, we converted columns like streams 
and in_spotify_playlists to numeric types by removing commas and applying as.numeric(). 
This step helped avoid errors in mathematical computations. 
Exploratory Data Analysis (EDA) 
EDA was crucial in uncovering initial insights about data distributions and feature relationships. Key 
steps included: 
4. Summary Statistics: Using summary(), we calculated basic statistics (mean, median, min, 
max) for numerical columns, helping us understand the central tendencies and spread of 
variables. 
5. Visualizations: 
o Histogram of Streams: A histogram displayed the distribution of stream counts, 
indicating whether streams are evenly distributed or concentrated in certain ranges. 
o Bar Plot of Artists: A bar plot showed the number of songs per artist, identifying 
those with the most frequent high-streamed songs. 
o Scatter Plot (Energy vs. Danceability): A scatter plot of energy vs. danceability 
revealed if higher-energy songs are more danceable, which could be a factor in 
stream counts. 
# Analysis 
1. Correlation Matrix: We computed correlations among key numerical features (e.g., 
danceability, energy, and streams) using cor(). This matrix quantified the strength and 
direction of associations between variables, helping us identify potential predictors of 
streams. 
2. Covariance Matrix: The covariance matrix, calculated with cov(), provided insights into the 
joint variability of features, further helping to understand feature relationships. 
Regression Modeling 
3. Simple Linear Regression: We initially modeled streams as a function of danceability to 
explore the direct influence of danceability on stream counts. 
4. Multiple Linear Regression: To improve prediction, we expanded to a multiple regression 
model that included danceability, energy, and bpm as predictors. We visualized actual vs. 
predicted streams with a scatter plot to assess the model fit, with an ideal model showing 
points along a 45-degree reference line (y = x). 
Probability Distributions 
5. Binomial Distribution: A random binomial dataset was generated to illustrate binary event 
modeling, often used for yes/no occurrences. 
6. Normal Distribution: We fitted a normal distribution to streams based on its mean and 
standard deviation. This helped examine how well a normal curve approximates the 
distribution of streams. 
7. Poisson Distribution: Given the count data for in_spotify_playlists, a Poisson distribution was 
fit, using its mean as the λ (lambda) parameter, to model the distribution of playlist counts. 
Hypothesis Testing 
8. One-Sample T-Test: We tested whether the mean streams differed significantly from a 
hypothesized benchmark (e.g., 500 million). 
9. Two-Sample T-Test: We conducted a t-test to evaluate if there’s a difference in average 
streams between songs in major and minor keys (mode). 
10. Chi-Square Tests 
• Goodness of Fit Test: We performed a chi-square goodness-of-fit test to see if the 
distribution of songs in major vs. minor modes matched expectations. 
• Contingency Test: A chi-square test of independence assessed whether mode is associated 
with the year of release, indicating trends in musical preference over time. 
11. ANOVA Analysis 
• One-Way ANOVA: An ANOVA test was used to determine if mode significantly influences 
streams. 
• Two-Way ANOVA: A two-way ANOVA analyzed the effects of both mode and released_year 
on streams, allowing us to assess interaction effects. 
Result Saving 
12. Saving Cleaned Data and Plots: The cleaned dataset was saved as a new CSV, and selected 
plots were exported as PNG files to support visual presentation in the report. 
# Conclusion
This analysis provides insightful findings on Spotify's most-streamed songs, highlighting the features 
that may contribute to a song’s success. Key conclusions from the analysis are: 
1. Popularity and Song Features: 
o High correlations among streams, danceability, and energy suggest that listeners 
prefer energetic, danceable songs, indicating these features as potential predictors 
of popularity. 
o The bar plot of artist names revealed that certain artists have repeatedly produced 
high-streamed songs, hinting at a formula or fan base that supports consistent 
popularity. 
2. Effectiveness of Regression Models: 
o The multiple linear regression model, which considered danceability, energy, and 
bpm, provided better predictions than the simple model. The actual vs. predicted 
plot showed a fair alignment with the reference line, indicating a reasonable 
predictive capability. 
o This model can be further refined with additional variables or by using advanced 
machine learning models. 
3. Statistical Significance and Hypotheses: 
o T-tests and ANOVA results indicated statistically significant differences in streams 
based on mode, showing that songs in different modes tend to have different 
popularity levels. 
o The chi-square tests confirmed that the distribution of songs by mode and release 
year is not random, possibly reflecting evolving musical preferences. 
4. Distribution Modeling: 
o Fitting normal, binomial, and Poisson distributions demonstrated that the streams 
data has characteristics of a normal distribution, while playlist counts align with a 
Poisson model. 
In summary, the analysis underscores the importance of song attributes in determining a song's 
popularity on Spotify, providing practical insights for artists and producers. Future work could explore 
more granular musical features and employ machine learning techniques for enhanced prediction 
accuracy. Additionally, testing with data from multiple streaming platforms would offer a more 
holistic view of listener preferences across the music industry.
