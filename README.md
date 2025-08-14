# SQL Project – Data Cleaning

**Repository:** [SQL-Project_Data-Cleaning](https://github.com/MJuneja29/SQL-Project_Data-Cleaning)

## Overview
Performed comprehensive data cleaning on a raw `layoffs.csv` dataset using SQL. Focused on improving data quality by eliminating inconsistencies, duplicates, and irrelevant entries.

## Contributions
- **Imported** `layoffs.csv` into SQL environment for transformation.
- **Removed** duplicate entries using `ROW_NUMBER()` partition logic.
- **Standardized** inconsistent values in industry and country columns.
- **Converted** date strings to `DATE` format and handled NULL/empty values.
- **Deleted** rows missing critical layoff data and fixed formatting issues.

## Repository Structure
```plaintext
├── layoffs.csv
├── Standardizing Data_world layoffs.sql
├── Removing Duplicates_world layoffs.sql
├── Handling Null and Blank values_world layoffs.sql
└── Removing any rows or columns_world layoffs.sql
```
## Usage
1. **Clone the repository**
   ```bash
   git clone https://github.com/MJuneja29/SQL-Project_Data-Cleaning.git

2. **Open** your SQL environment (e.g., MySQL Workbench).  

3. **Run the scripts** in this order:  
   1. `Standardizing Data_world layoffs.sql`  
   2. `Removing Duplicates_world layoffs.sql`  
   3. `Handling Null and Blank values_world layoffs.sql`  
   4. `Removing any rows or columns_world layoffs.sql`  

4. **Use** the cleaned dataset for analysis or visualization.  

## Technologies Used
- **SQL** (MySQL)  
- Window functions: `ROW_NUMBER()`  
- String functions: `TRIM`, `REPLACE`  
- Data type conversions: `CAST`, `CONVERT`  

## Summary
This project demonstrates a methodical SQL-based approach to cleaning real-world datasets by removing noise, normalizing values, and preparing data for accurate analysis.
