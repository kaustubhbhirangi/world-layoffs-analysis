select * from layoffs_staging_2;


-- 1) Top 5 company with max lay offs
SELECT company, 
		total_laid_off
FROM layoffs_staging
ORDER BY 2 DESC
LIMIT 5;


-- 2) Max & Min % of lay-offs
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoffs_staging_2
WHERE  percentage_laid_off IS NOT NULL;


-- 3) Companies who laid off entire people
SELECT *
FROM layoffs_staging_2
WHERE  percentage_laid_off = 1;
-- these are mostly startups it looks like who all went out of business during this time


-- 4) Top 5 Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off) as total_layoff
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC
LIMIT 5;


-- 5) By location
SELECT location, SUM(total_laid_off) as tot_laid_off
FROM layoffs_staging_2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;


-- 6) Year-wise layoffs
SELECT YEAR(date), SUM(total_laid_off) as tot_laid_off
FROM layoffs_staging_2
GROUP BY YEAR(date)
ORDER BY 1 ASC;


-- 7) Earlier we looked at Companies with the most Layoffs. Now let's look at Top 3 company ranking per year.
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging_2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;


-- Rolling Total of Layoffs Per Month
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging_2
GROUP BY dates
ORDER BY dates ASC;

-- now use it in a CTE so we can query off of it
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging_2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;