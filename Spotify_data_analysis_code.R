# 1. Introduction: Importing Data
setwd("C:/Users/SAKSHI/Downloads")  # Update the path if needed
spotify_data <- read.csv("Spotify Most Streamed Songs.csv", header = TRUE)

# 2. Computing Summary Statistics
summary(spotify_data)

# Handle Missing Values
spotify_data <- na.omit(spotify_data)

# Convert 'streams' and other relevant columns to Numeric (if they are not already)
spotify_data$streams <- as.numeric(gsub(",", "", spotify_data$streams))
spotify_data$in_spotify_playlists <- as.numeric(spotify_data$in_spotify_playlists)
spotify_data$in_apple_playlists <- as.numeric(spotify_data$in_apple_playlists)
spotify_data$in_deezer_playlists <- as.numeric(spotify_data$in_deezer_playlists)

# Check for conversion issues
if (any(is.na(spotify_data$streams))) {
  cat("Warning: Some 'streams' values could not be converted to numeric.\n")
  spotify_data <- spotify_data[!is.na(spotify_data$streams), ]
}

# 3. Data Visualization
## a. Histogram of Streams
dev.new()  # Open a new plot window
hist(spotify_data$streams, main = "Distribution of Streams", xlab = "Streams", col = "lightblue", breaks = 30)

## b. Bar Plot of Artist Names
dev.new()  # Open a new plot window
barplot(table(spotify_data$artist.s._name), main = "Number of Songs by Artist", las = 2, cex.names = 0.7, col = "yellow")

## c. Scatter Plot of Energy vs Danceability
dev.new()  # Open a new plot window
plot(spotify_data$energy_, spotify_data$danceability_, main = "Energy vs Danceability", xlab = "Energy", ylab = "Danceability", col = "blue")

# 4. Correlation Analysis
correlation_matrix <- cor(spotify_data[, c("danceability_.", "energy_.", "streams")], use = "complete.obs")
print("Correlation Matrix:")
print(correlation_matrix)

## Visualize Correlation Matrix
dev.new()  # Open a new plot window
corrplot::corrplot(correlation_matrix, method = "circle", col = "blue", type = "upper", tl.cex = 0.7)

# 5. Covariance Matrix
covariance_matrix <- cov(spotify_data[, c("danceability_.", "energy_.", "streams")], use = "complete.obs")
print("Covariance Matrix:")
print(covariance_matrix)

# 6. Simple Linear Regression
simple_model <- lm(streams ~ danceability_., data = spotify_data)
summary(simple_model)

# Plot the Simple Linear Regression Model
dev.new()  # Open a new plot window
plot(spotify_data$danceability_, spotify_data$streams, main = "Simple Linear Regression: Streams vs Danceability", xlab = "Danceability", ylab = "Streams", col = "blue")
abline(simple_model, col = "red", lwd = 2)  # Added color and line width for better visibility

# 7. Multiple Linear Regression
multiple_model <- lm(streams ~ danceability_. + energy_. + bpm, data = spotify_data)
summary(multiple_model)

# Plot the Multiple Linear Regression Model (for 'Danceability' vs 'Streams')
dev.new()  # Open a new plot window
plot(spotify_data$danceability_, spotify_data$streams, main = "Multiple Linear Regression: Streams vs Danceability", xlab = "Danceability", ylab = "Streams", col = "green")
abline(multiple_model, col = "purple", lwd = 2)  # Added color and line width for better visibility
# 7.1 Predicted vs. Actual Streams Plot for Multiple Linear Regression
# Generate predictions from the multiple regression model
spotify_data$predicted_streams <- predict(multiple_model)

# Open a new plot window
dev.new()  # Open a new plot window

# Plot actual streams vs predicted streams
plot(spotify_data$streams, spotify_data$predicted_streams, 
     main = "Multiple Linear Regression: Actual vs Predicted Streams", 
     xlab = "Actual Streams", 
     ylab = "Predicted Streams", 
     col = "darkgreen", pch = 16)

# Add a reference line y = x for comparison
abline(a = 0, b = 1, col = "red", lwd = 2)  # Line with slope 1 for reference

# Save the plot if needed
dev.copy(png, "Actual_vs_Predicted_Streams.png")
dev.off()


# 8. Fitting Probability Distributions
## a. Binomial Distribution (Example with random data)
binom_data <- rbinom(1000, size = 10, prob = 0.5)
dev.new()  # Open a new plot window
hist(binom_data, main = "Binomial Distribution", xlab = "Value", col = "lightgreen", breaks = 20)

## b. Normal Distribution (Fitting and Plotting)
normal_data <- rnorm(1000, mean = mean(spotify_data$streams, na.rm = TRUE), sd = sd(spotify_data$streams, na.rm = TRUE))
dev.new()  # Open a new plot window
hist(normal_data, main = "Normal Distribution", xlab = "Value", col = "pink", breaks = 20)

## c. Poisson Distribution (Fix for missing values and non-numeric data)
# Remove missing values from the entire dataset first
spotify_data <- na.omit(spotify_data)

# Convert 'in_spotify_playlists' to numeric (if not already numeric)
spotify_data$in_spotify_playlists <- as.numeric(spotify_data$in_spotify_playlists)

# Check for conversion issues
if (any(is.na(spotify_data$in_spotify_playlists))) {
  cat("Warning: Some 'in_spotify_playlists' values could not be converted to numeric.\n")
  spotify_data <- spotify_data[!is.na(spotify_data$in_spotify_playlists), ]
}

# Generate Poisson data using the mean of 'in_spotify_playlists'
lambda_value <- mean(spotify_data$in_spotify_playlists, na.rm = TRUE)
poisson_data <- rpois(1000, lambda = lambda_value)

# Plot Poisson Distribution
dev.new()  # Open a new plot window
hist(poisson_data, main = "Poisson Distribution", xlab = "Value", col = "lavender", breaks = 20)

# 9. Hypothesis Testing
## a. One Sample T-Test for Streams
t_test_one_sample <- t.test(spotify_data$streams, mu = 500000000)
print("One Sample T-Test Results:")
print(t_test_one_sample)

## b. Two Sample T-Test for Major vs Minor Mode
spotify_data$mode <- as.factor(spotify_data$mode)
t_test_two_sample <- t.test(streams ~ mode, data = spotify_data)
print("Two Sample T-Test Results (Mode vs Streams):")
print(t_test_two_sample)

# 10. Chi-Square Test
## a. Goodness of Fit Test
observed <- table(spotify_data$mode)
expected <- rep(mean(observed), length(observed))
chi_square_test <- chisq.test(observed, p = expected / sum(expected))
print("Chi-Square Goodness of Fit Test Results:")
print(chi_square_test)

## b. Contingency Test
contingency_table <- table(spotify_data$mode, spotify_data$released_year)
chi_square_contingency <- chisq.test(contingency_table)
print("Chi-Square Contingency Test Results:")
print(chi_square_contingency)

# 11. ANOVA
## a. One-Way ANOVA (Completely Randomized Design)
anova_result <- aov(streams ~ mode, data = spotify_data)
summary(anova_result)

## b. Two-Way ANOVA (Randomized Block Design)
spotify_data$released_year <- as.factor(spotify_data$released_year)
anova_two_way <- aov(streams ~ mode + released_year, data = spotify_data)
summary(anova_two_way)

# 12. Save Results and Plots
## Save Histogram (For example, distribution of streams)
dev.new()  # Open a new plot window
hist(spotify_data$streams, main = "Distribution of Streams", xlab = "Streams", col = "orange", breaks = 30)

## Save Cleaned Data
write.csv(spotify_data, "cleaned_spotify_data.csv", row.names = FALSE)

# Reset Graphics Device
dev.off()
