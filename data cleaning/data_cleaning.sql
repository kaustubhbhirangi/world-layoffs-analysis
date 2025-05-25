SELECT * FROM data_cleaning.layoffs;
SELECT * FROM data_cleaning.layoffs_staging;
SELECT * FROM data_cleaning.layoffs_staging_2;


# Creating dummy table
CREATE TABLE layoffs_staging
like layoffs;


# Inserting same values
INSERT layoffs_staging 
select * from layoffs;

-- Tasks: 
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null values or blank values
-- 4. Remove unnecessory Columns


# row_number() + partition by all columns for adding numbers for each row, and then checking row_num > 1 (for duplicates)
with duplicate_cte as (select *,
			row_number() over (partition by company, location, industry, total_laid_off, 
            percentage_laid_off, `date`,stage,country,funds_raised_millions) as row_num
			from layoffs_staging)
select * from duplicate_cte
where row_num > 1;


# Creating 3rd dummy and assigning correct datatypes
CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


# Inserting that whole cte for that row_num column to add in 3rd table i.e layoffs_staging_2
INSERT INTO layoffs_staging_2
select *, row_number() over (partition by company, location, industry, total_laid_off, 
            percentage_laid_off, `date`,stage,country,funds_raised_millions) as row_num
			from layoffs_staging;

select * from layoffs_staging_2
where row_num > 1;


-- 1) ----------------------------Removing Duplicates after adding row_number (column with cte)----------------
delete from layoffs_staging_2
where row_num > 1;


-- 2) ----------------------------Standardize the Data | Removing white-spaces---------------------------------
update layoffs_staging_2
set company = trim(company);


-- a) Updating column values - 'Crypto Currnecy' to 'Crpyto'
update layoffs_staging_2 
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country 
from layoffs_staging_2
order by country;


-- b) Checking . in values 
select * from layoffs_staging_2
where country like 'United States.';


-- Fixing . values to related common values
update layoffs_staging_2
set country = 'United States'
where country like 'United States.';


-- 3) ----------------------------Changing date-format---------------------------------
select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging_2;


-- Now updating
update layoffs_staging_2
set `date` = str_to_date(`date`, '%m/%d/%Y');


-- Modifying column
alter table layoffs_staging_2
modify column `date` date;


-- Fixing null/blank values
update layoffs_staging_2
set industry = NULL
where industry = '';


-- Adding missing values from other rows (Airbnb's other entry has `industry` in it)
select * from layoffs_staging_2
where company = 'Airbnb';

select t1.industry, t2.industry
from layoffs_staging_2 t1
join layoffs_staging_2 t2
on t1.company = t2. company 
where (t1.industry is null or t1.industry = '') and t2.industry is not null;

# Setting values from right table
update layoffs_staging_2 t1
join layoffs_staging_2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null and t2.industry is not null;

-- Deleting useless values
delete from layoffs_staging_2
where total_laid_off is null and percentage_laid_off  is null;

-- Dropping column row_number
alter table layoffs_staging_2
drop column row_num;

select * from layoffs_staging_2; # This is the cleaned dataset, ready to import.