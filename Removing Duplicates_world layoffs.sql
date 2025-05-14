-- SQL Data Cleaning Project | Step 1: Remove Duplicates


-- Step 1: View original data
SELECT * 
FROM layoffs;

-- Step 2: Create a staging table to perform data cleaning without affecting the original table
CREATE TABLE layoffs_staging LIKE layoffs;

-- Step 3: Verify that the staging table is created
SELECT * 
FROM layoffs_staging;

-- Step 4: Copy all data from original table into the staging table
INSERT INTO layoffs_staging
SELECT * 
FROM layoffs;

-- Step 5: Check for duplicate rows using ROW_NUMBER()
-- If a row has row_num > 1, it's a duplicate
SELECT *, 
       ROW_NUMBER() OVER (
           PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`
       ) AS row_num
FROM layoffs_staging;

-- Step 6: A more complete duplicate check including more columns
-- Creating a CTE to identify duplicates
WITH duplicate_cte AS (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
                            stage, country, funds_raised_millions
           ) AS row_num
    FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

-- Step 7: Optional manual check - Verify if duplicates are real
SELECT * 
FROM layoffs_staging
WHERE company = 'Casper';

-- Step 8: Attempt to delete duplicates (this will fail because you can't delete directly from CTE)
-- So we use an alternate approach

-- Step 9: Create a new staging table with an extra column (row_num)
CREATE TABLE layoffs_staging2 (
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off INT DEFAULT NULL,
    percentage_laid_off TEXT,
    `date` TEXT,
    stage TEXT,
    country TEXT,
    funds_raised_millions INT DEFAULT NULL,
    row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Step 10: Confirm the new table is empty
SELECT * 
FROM layoffs_staging2;

-- Step 11: Insert data from layoffs_staging and add row numbers for duplicate identification
INSERT INTO layoffs_staging2
SELECT *, 
       ROW_NUMBER() OVER (
           PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
                        stage, country, funds_raised_millions
       ) AS row_num
FROM layoffs_staging;

-- Step 12: View duplicate rows (those with row_num > 1)
SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;

-- Step 13: Delete duplicate rows, keeping only row_num = 1
DELETE 
FROM layoffs_staging2
WHERE row_num > 1;
