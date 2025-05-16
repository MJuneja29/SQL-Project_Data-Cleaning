-- SQL Data Cleaning Project | Step 2: Standardizing Data

-- 1. Remove leading and trailing spaces from the 'company' column
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

-- 2. Check distinct values in the 'industry' column
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

-- Note: Multiple representations found for the same industry, e.g., 
-- 'Crypto Currency', 'CryptoCurrency', and 'Crypto'

-- 3. Identify records where industry starts with 'Crypto'
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- 4. Standardize all 'Crypto'-related industry values to 'Crypto'
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- 5. Recheck distinct industry values after standardization
SELECT DISTINCT industry
FROM layoffs_staging2;

-- 6. Check distinct location values
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

-- 7. Identify inconsistent entries in the 'country' column (e.g., 'United States.')
SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%';

-- 8. Preview cleaned-up version of 'country' values
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

-- 9. Remove trailing periods from 'country' names
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- 10. Check 'date' column values (currently stored as text in non-standard format)
SELECT `date`
FROM layoffs_staging2;

-- 11. Preview how 'date' values will look after conversion to proper DATE format
SELECT `date`,
       STR_TO_DATE(`date`, '%m/%d/%Y') AS converted_date
FROM layoffs_staging2;

-- 12. Update 'date' values to a standardized format using STR_TO_DATE
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- Note: Though still stored as text, the format is now standardized.

-- 13. Alter the 'date' column to convert its datatype from TEXT to DATE
-- Important: Perform such operations only on staging tables, not on raw data
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;
