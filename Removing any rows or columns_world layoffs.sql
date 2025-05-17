-- STEP 4: Removing Unnecessary Rows and Columns for Final Data Cleanup

-- Identify rows where both 'total_laid_off' and 'percentage_laid_off' are NULL
-- These rows likely contain no useful layoff data and can be considered invalid
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Delete the identified rows with missing layoff data
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Verify that the table no longer contains the invalid rows
SELECT *
FROM layoffs_staging2;

-- Drop the 'row_num' column as it was only used for temporary purposes (like sorting or deduplication)
-- This gives us the finalized and clean version of the dataset
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
