# Customer Purchase Behaviour Analysis for 2Market

This project analyses customer purchase behaviour for **2Market**, a global supermarket that operates both online and in-store. Using **Excel, SQL and Tableau**, I explored customer demographics, product preferences and advertising channel performance to support data-driven marketing and strategic decisions.

The work was completed as a final assignment for a data analytics course and includes:
- A **Tableau dashboard**
- A **written report**
- A **stakeholder-style presentation**

---

## Project Objectives

2Market wanted to understand:

1. **Who their customers are**  
   - Demographic characteristics (age, income, marital status, household composition, country)

2. **Which products sell best**  
   - Most popular product categories overall  
   - Differences by demographics (income group, household type, marital status)

3. **Which advertising channels are most effective**  
   - Relative performance of Facebook, Instagram and Twitter  
   - Differences in performance by country and marital status

---

## Data

The analysis uses two main CSV files and a metadata file:

- `marketing_data.csv` – customer-level demographics and purchase behaviour  
- `ad_data.csv` – advertising engagement and response data  
- `metadata_2Market.txt` – descriptions of all variables

**Number of customers:** 2,216  
**Example variables:**
- `Age`, `Income`, `Marital_Status`, `Country`, `Kidhome`, `Teenhome`
- Expenditure by product category (`MntMeat`, `MntFish`, `MntLiquor`, etc.)
- Response to different advertising channels

> Note: Income is recorded in USD. The currency of expenditure fields is not explicitly documented and is assumed to be USD for this analysis.

---

## Tools & Technologies

- **Excel** – initial exploration, descriptive statistics, pivot tables
- **SQL** – data cleaning, joins, aggregations, deeper analysis
- **Tableau** – interactive dashboard and data storytelling
- (Optional) **PowerPoint / Keynote** – presentation slides

---

## Analytical Approach

1. **Exploratory data analysis in Excel**
   - Reviewed metadata to understand available variables
   - Calculated summary statistics (e.g. average age ≈ 55 years)
   - Created pivot tables to explore relationships (e.g. age vs income)
   - Identified data quality issues (e.g. unexpected marital status values: `YOLO`, `Absurd`)

2. **Initial Tableau dashboard**
   - Mapped customer distribution across 8 countries
   - Grouped customers into income segments per country
   - Visualised purchase behaviour by income group and household composition
   - Built early views of advertising channel performance

3. **Deeper analysis with SQL**
   - Joined `marketing_data` and `ad_data`
   - Aggregated expenditures by:
     - Country
     - Product category
     - Marital status
     - Child/teen presence in household
   - Analysed advertising response rates by:
     - Country
     - Marital status
   - Exported key summary tables (see `/sql` folder and report appendix)

4. **Refined Tableau dashboard**
   - Updated visuals based on SQL findings
   - Focused on:
     - Demographic and geographic overview
     - Product category performance
     - Advertising channel effectiveness
   - Designed dashboard to support stakeholder storytelling rather than raw exploration

---

## Key Findings

### Customer base

- 2Market serves customers in **8 countries**, indicating a broad international footprint.
- The **upper-middle income group** is the largest segment.
- The **average customer age is around 55**, with a **positive correlation between age and income**. Older customers tend to have higher purchasing power.

### Product preferences

- **Liquor and meat** are the top product categories by total spend.
- These categories remain strong across **household types** and **income groups**, suggesting consistently high demand.
- Some patterns (e.g. high liquor spend in countries with alcohol restrictions) may be partly driven by data quirks or sampling.

### Advertising channel performance

- **Twitter** is the most effective channel overall in terms of response, followed by **Bulkmail** (email campaigns).
- Channel performance varies by **country** and **marital status**:
  - In some markets, **Instagram** is the leading platform.
  - In others, **Facebook** or **Twitter** performs better.
- This supports a **segmented channel strategy** rather than a single global approach.

---

## Limitations

- **Currency ambiguity:** Income is clearly in USD, but product expenditure fields lack explicit currency information. Assuming USD may bias cross-country comparisons.
- **No timestamps:** The datasets do not include dates, making it difficult to know how current the behaviour is.
- **Data quality issues:** Unusual marital status values (e.g. `YOLO`, `Absurd`) and some unexpected product patterns suggest possible survey or data entry issues.

These limitations are documented so stakeholders interpret the results with appropriate caution.

---

## Repository Structure

```text
.
├─ sql/
├─ tableau/
├─ report/
└─ README.md
