-- Step 3: Handling NULL and Blank Values in the 'industry' column

-- Replace blank ('') industry values with actual NULL values for consistency
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Verify which rows still have NULL in the industry column
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL;

-- Focus on one example: Check all entries for the company 'Airbnb'
-- This helps us determine if we can infer the missing industry from another row
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- Observation: At least one row for 'Airbnb' has a valid industry ('Travel')
-- We can use this to fill in the missing industry for other 'Airbnb' rows

-- Identify rows where the industry is missing (t1.industry IS NULL)
-- and another row exists for the same company with a non-null industry (t2.industry IS NOT NULL)
SELECT t1.company, t1.industry AS missing_industry, t2.industry AS valid_industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Update the missing industry values using the valid industry from another row of the same company
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Check entries for a company starting with 'Bally'
-- This helps verify if there's at least one non-null industry value to reference
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

-- Observation: Only one row for 'Bally' exists and its industry is NULL
-- Therefore, we cannot infer or update the missing industry for this company
