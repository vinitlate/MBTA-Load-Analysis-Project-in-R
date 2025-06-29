# MBTA-Load-Analysis-Project-in-R

This project performs exploratory data analysis and regression modeling on MBTA ridership data.

## 📂 Repository Structure

```
retail-datalake-databricks/
├──data/
│ └── mbta_data_clean.RData
├──scripts/
│ └── Load_Analysis.R
├──output/
│ ├── Gold_Layer_Products.py
│ └── Gold_Layer_Orders.py
├── README.md
```

## 📊 Analysis Overview

- Dummy encoding for categorical variables
- Histograms, boxplots, barplots
- Scatter plots with LOWESS smoothing by direction
- Seasonal trends
- Correlation matrix and pair plots
- Polynomial regression with stepwise feature selection
- Multicollinearity analysis using VIF

## 📦 Libraries Used

- `MASS` (for stepwise regression)
- `car` (for VIF analysis)

## ▶️ How to Run

1. Clone the repository.
2. Place `mbta_data_clean.RData` inside the `data/` folder.
3. Open `scripts/mbta_data_analysis.R` in R or RStudio.
4. Run the script to perform all analysis and modeling.

## 🙋 Author

Maintained by Vinit Late.  
Open to suggestions, improvements, and collaborations!
