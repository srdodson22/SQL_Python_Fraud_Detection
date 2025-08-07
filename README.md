# Customer Due Diligence & Suspicious Activity Monitoring System

## Project Type  
Individual Portfolio Project

## Problem  
Financial institutions are under constant pressure to detect and prevent fraudulent behavior while maintaining compliance with Know Your Customer (KYC) and Anti-Money Laundering (AML) regulations. However, this can be difficult when data is messy and fraudsters mimic normal customer behavior. This project simulates a suspicious activity monitoring system in a financial services context.

## Objectives  
- Clean and combine multiple datasets  
- Explore trends and detect irregularities through EDA  
- Engineer features to highlight risky behavior  
- Use unsupervised machine learning to detect behavioral anomalies  

---

## Tools Used  
- **SQL (via DB Browser)**: Data cleaning, standardization, and joins  
- **Python (Jupyter Notebooks)**: EDA, feature engineering, anomaly detection  
  - Libraries: `pandas`, `matplotlib`, `seaborn`, `scikit-learn`

---

## Dataset Overview  
This project uses three synthetic datasets:
- **Customers**: KYC information (e.g., name, country, account open date, KYC status)
- **Transactions**: Financial transaction records (e.g., amount, country, merchant, channel)
- **Sanctions**: Individuals with assigned risk levels (Low, Medium, High)

The datasets were intentionally dirtied to simulate real-world messiness and cleaned using SQL before being merged on `customer_id` for analysis.

---

## 🔍 Methodology

### Data Cleaning (SQL)
- Trimmed whitespace from text fields  
- Standardized country and occupation names  
- Replaced null `kyc_status` values with `"Pending"`  
- Converted dates to ISO format (YYYY-MM-DD)  
- Joined customer and transaction tables with sanctions data  

### Exploratory Data Analysis (Python)
- Analyzed spending patterns by customer type, channel, and country  
- Explored transaction volume per channel/country  
- Visualized risk level distribution from sanctions data  
- Detected outliers and seasonal patterns  
- Tools: Bar charts, box plots, line graphs  

### Feature Engineering
Created behavioral features to support fraud detection:
- `total_spent`: Lifetime transaction amount per customer  
- `avg_spent`: Mean transaction value  
- `std_spent`: Transaction variability  
- `num_txns`: Total transactions per customer  
- `unique_channels`: Distinct channels used  
- `unique_merchants`: Number of unique merchants  
- `unique_countries`: Number of transaction countries  

Missing values were filled with `0` to avoid model issues.

### Anomaly Detection
- Used **Isolation Forest** to identify behavioral anomalies  
- Trained model on engineered features  
- Flagged anomalous customers with a binary label  

---

## Key Insights
- **25 customers** were flagged as anomalous, often showing high spend with low transaction counts or limited variety in merchants/countries  
- The **UK** had the most high-risk individuals (11); risky transactions were concentrated in **online** and **wire** channels  
- Top 10 customers contributed a significant portion of the volume, with **Amber Rios** alone transacting over **$843K**  
- **Retail customers** spent more per transaction ($6,108) than **corporate customers** ($2,570), suggesting different risk profiles  

---

## Outcome  
This project demonstrates how SQL and Python can be combined to clean, analyze, and model financial data for fraud detection. It also shows the power of unsupervised learning for identifying suspicious behaviors when fraud labels are not available.

---

## Future Improvements  
- Use real-world data (if available)  
- Explore clustering or supervised models (when fraud labels are introduced)  
- Develop a dashboard for risk monitoring teams  

---

## Project Link  
GitHub Repository: [SQL/Python Fraud Detection](https://github.com/srdodson22)
