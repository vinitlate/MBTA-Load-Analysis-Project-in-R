attach(mbta_data_clean)

# Create dummy variables for 'day_type_name' and 'time_period_name'
# This command will create a full set of dummies for each and drop the first level to avoid the dummy variable trap
dummies <- model.matrix(~ day_type_name + time_period_name - 1, data=mbta_data_clean)

# Combine the dummy variables with the original data frame
mbta_data_clean <- cbind(mbta_data_clean, dummies)

#Data Visualization for Load on Route 1

# Create histogram data without plotting it first
hist_data <- hist(mbta_data_clean$average_load,
                  plot = FALSE)  # Generate data but do not plot it yet

# Now plot the histogram using the data
plot(hist_data, 
     main = "Histogram of Average Load",
     xlab = "Average Load",
     col = "blue",
     border = "white",
     ylim = c(0, max(hist_data$counts) + 5), # Adjust the y-limit to make room for text annotation
     breaks = 30)  # You can adjust the number of breaks to improve granularity

boxplot(average_load ~ day_type_name, data = mbta_data_clean,
        main = "Average Load by Day Type",
        xlab = "Day Type",
        ylab = "Average Load",
        col = "green")

# Aggregating average ons by time period

barplot(average_ons ~ time_period_name data = mbta_data_clean,
        names.arg = average_ons_time$time_period_name,
        main = "Average Ons by Time Period",
        xlab = "Time Period",
        ylab = "Average Ons",
        col = "magenta",
        las = 1)  # Rotate x-axis labels to make them readable

# Scatter plot with different colors for different directions
plot(mbta_data_clean$stop_sequence, mbta_data_clean$average_load,
     main = "Stop Sequence vs Average Load by Direction",
     xlab = "Stop Sequence",
     ylab = "Average Load",
     col = ifelse(mbta_data_clean$direction_id == 0, "magenta", "green"),  # Adjust colors as necessary
     pch = 20)

# Adding different lowess lines for each direction
legend("topright", legend=c("Direction 0", "Direction 1"), col=c("magenta", "green"), pch=20)
points(mbta_data_clean$stop_sequence[mbta_data_clean$direction_id == 0], 
       mbta_data_clean$average_load[mbta_data_clean$direction_id == 0], 
       col = "magenta", pch = 20)
points(mbta_data_clean$stop_sequence[mbta_data_clean$direction_id == 1], 
       mbta_data_clean$average_load[mbta_data_clean$direction_id == 1], 
       col = "green", pch = 20)
lines(lowess(mbta_data_clean$stop_sequence[mbta_data_clean$direction_id == 0], 
             mbta_data_clean$average_load[mbta_data_clean$direction_id == 0]), col = "magenta")
lines(lowess(mbta_data_clean$stop_sequence[mbta_data_clean$direction_id == 1], 
             mbta_data_clean$average_load[mbta_data_clean$direction_id == 1]), col = "black")

# Convert the 'season' column to a factor with levels ordered chronologically
mbta_data_clean$season <- factor(mbta_data_clean$season, levels = unique(mbta_data_clean$season))

# Aggregate 'average_load' by 'season'
seasonal_load <- aggregate(average_load ~ season, data = mbta_data_clean, mean)

# Plot the aggregated load over seasons using a bar plot
barplot(seasonal_load$average_load,
        names.arg = seasonal_load$season,
        main = "Average Load by Season",
        xlab = "Season",
        ylab = "Average Load",
        las = 1, # makes the x axis labels perpendicular to the axis
        col = "blue")

numerical_data <- mbta_data_clean[, c("stop_sequence", "average_ons", "average_offs", "average_load", "num_trips_for_calculation")]
cor_matrix <- cor(numerical_data, use = "complete.obs")
image(1:ncol(cor_matrix), 1:ncol(cor_matrix), cor_matrix,
      main = "Correlation Matrix",
      col = colorRampPalette(c("navy", "white", "firebrick"))(200))

pairs(numerical_data,
      main = "Pair Plot of Numeric Variables",
      pch = 21,  # Point type with border
      bg = "lightblue")  # Background color of points


library(MASS)  # For stepwise regression

# Ensure categorical variables are factors and create polynomial terms
mbta_data_clean$direction_id <- as.factor(mbta_data_clean$direction_id)
mbta_data_clean$time_period_name <- as.factor(mbta_data_clean$time_period_name)
mbta_data_clean$stop_sequence2 <- mbta_data_clean$stop_sequence^2
mbta_data_clean$stop_sequence3 <- mbta_data_clean$stop_sequence^3

# Full model with interactions and polynomial terms
full_model <- lm(average_load ~ direction_id * time_period_name +
                   stop_sequence + stop_sequence2 + stop_sequence3 +
                   average_ons + average_offs, 
                 data = mbta_data_clean)

# Stepwise model selection based on AIC
stepwise_model <- stepAIC(full_model, direction = "both")

# Print the summary of the refined model
summary(stepwise_model)

# Optional: Check for multicollinearity with VIF
library(car)
print(vif(stepwise_model))
