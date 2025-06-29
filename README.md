# MBTA-Load-Analysis-Project-in-R

This project explores and models passenger load patterns on MBTA Route 1 (Harvard Square ↔ Nubian Station), using cleaned transit data and multiple statistical techniques in R.

---

## 📂 Repository Structure

```
retail-datalake-databricks/
├──data/
│ └── mbta_data_clean.RData
├──scripts/
│ └── Load_Analysis.R
├──output/
│ └── Output Presentation.pdf
├── README.md

```
---

## 📊 Analysis Overview

- Dummy encoding for categorical variables (`day_type_name`, `time_period_name`)
- Visualizations:
  - Histogram of passenger load
  - Boxplots by day type
  - Barplots by time period and stop
  - Scatter plots by stop sequence and direction
  - Seasonal trends
  - Correlation matrix and pair plots
- Regression:
  - Polynomial and interaction terms
  - Stepwise selection using AIC
  - Multicollinearity check with VIF

---

## 📈 Project Output Summary

### 🔍 Key Visual Insights
- **Load by Day Type:** Weekdays show higher variability—commuters drive demand.
- **Ons/Offs by Stop:** Specific stops are boarding/alighting hubs, indicating high-impact zones.
- **Load by Time Period:** Surprisingly, **midday** shows the highest load—beyond rush hours.
- **Stop Sequence by Direction:** Load rises mid-route then declines, with strong directional trends.

### 📉 Regression Results

#### First-Order Model
- Formula:  
  `average_load ~ time_period_name + day_type_id + average_ons + average_offs + stop_id`
- Adjusted R²: **0.797**
- Residual Std. Error: **1.44**

#### Recommended Model
- Formula:  
  `average_load ~ stop_id * (average_ons + average_offs) + time_period_name + day_type_id`
- Adjusted R²: **0.894**
- Residual Std. Error: **1.043**

---

## 🚀 Final Takeaways

- MBTA usage is **time-sensitive** and varies by stop importance.
- Only a subset of stops contribute significantly to passenger load.
- **Mid-route** segments are high-traffic zones and need targeted scheduling.
- High **model accuracy** (Adjusted R² ~ 0.89) shows strong predictive potential for operational decisions.

---

## 🛠️ Libraries Used

- `MASS` – stepwise regression
- `car` – multicollinearity (VIF)

---

## ▶️ How to Run

1. Clone this repository.
2. Open `scripts/mbta_data_analysis.R` in R or RStudio.
3. Ensure the dataset `mbta_data_clean.RData` is present in `/data`.
4. Run the script to generate plots, models, and diagnostics.

---

## 🙋 Author

Maintained by **Vinit Late**  
📫 Open to feedback, ideas, and collaboration opportunities.
