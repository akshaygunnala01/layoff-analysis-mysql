Layoff Trends Analysis Using MySQL

This project explores global tech layoffs using SQL-based data cleaning and exploratory analysis. It leverages raw and cleaned datasets to uncover patterns in layoffs across industries, countries, funding stages, and time periods — all powered by MySQL.


Files Description

- Data/layoffs.csv
  - Raw dataset containing global layoff records.
  - Includes company name, location, industry, number of employees laid off, percentage laid off, date, funding stage, country, and funds raised.

- Data/cleaned_data.csv
  - Cleaned version of the raw dataset.
  - Duplicates removed, text fields standardized, date formats corrected, and null values handled.

- SQL/Data Cleaning.sql
  - Full SQL script for cleaning and preprocessing the raw data.
  - Includes:
    - Duplicate detection and removal using `ROW_NUMBER()`
    - Text standardization (`TRIM()`, value corrections)
    - Date conversion using `STR_TO_DATE()`
    - Null handling and record filtering

- SQL/Exploratory Data Analysis Project.sql
  - SQL queries for exploratory data analysis (EDA).
  - Covers:
    - Layoffs by company, industry, country, and year
    - Monthly and rolling layoff totals
    - Top companies by layoffs per year
    - Average layoff percentages and funding stage impact

---

Project Structure

- Data: Contains the layoff dataset (`layoffs.csv`) and optionally the cleaned dataset (`cleaned_data.csv`).
- SQL: Includes SQL scripts for data cleaning and exploratory analysis.
  - `Data Cleaning.sql`: Cleans and preprocesses the raw layoff data.
  - `Exploratory Data Analysis Project.sql`: Performs exploratory data analysis using SQL queries.

---

Insights

The analysis reveals that layoffs were most concentrated in tech-heavy industries and late-stage startups, with the United States leading in total layoffs. Monthly and yearly trends show spikes during economic downturns, and a few companies consistently ranked among the top in workforce reductions.
