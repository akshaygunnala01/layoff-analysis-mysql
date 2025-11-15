-- data cleaning


select *
from layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the data(any spelling mistakes)
-- 3. Null values or blank values
-- 4. Remove any columns

-- at most first never work on raw data 
-- so create another table explicitly and insert all the raw data into it and you start work on it.

CREATE table layoffs_staging -- created a another table similar to raw data
like layoffs;

select *-- now we have all the columns similarr to raw data
From layoffs_staging;

insert layoffs_staging-- here we are inserting values from raw data into new table
select *
from layoffs;

-- 1. Remove duplicates
-- in this query we added the row numbers 
select *,
row_number() over (partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

-- we found out the duplicates
with duplicate_cte as 
(
select *,
row_number() over (partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * 
from duplicate_cte
where row_num>1;

-- cross checking whether it is duplicate or not
select *
from layoffs_staging
where company = 'Casper';

-- now,we created a new table just like for layoff_stagging
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- here we checked the columns are similar 
select *
from layoffs_staging2;

-- here we inserted the vaules into it
insert into layoffs_staging2
select *,
row_number() over (partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

-- deleted the duplicates
Delete
from layoffs_staging2
WHERE row_num >1;

-- cross checking whether they are still in there are not.
select *
from layoffs_staging2
where row_num >1;


-- standardizing data(finding issues in the data and fixing it)

-- here we are triming the white space before and after the text

select company, trim(company)
from layoffs_staging2;

-- updating it to layoff_staging2
update layoffs_staging2
set company=trim(company);

select *
from layoffs_staging2
where industry like 'Crypto%'
;

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct industry
from layoffs_staging2
where industry like 'Crypto%'
;

select distinct location
from layoffs_staging2
order by location
;


select distinct country
from layoffs_staging2
order by country
;

select *
from layoffs_staging2
where country like 'United States_'
;

select distinct country, trim(trailing '.' from country) -- it trims the period . from it
from layoffs_staging2
order by country;


update layoffs_staging2
set country =  trim(trailing '.' from country)
where country like 'United States%';


select distinct country
from layoffs_staging2
where country = 'United States';

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;



update layoffs_staging2
set `date`= str_to_date(`date`, '%m/%d/%Y');

select `date`
from layoffs_staging2;


alter table layoffs_staging2
modify column `date` Date;

select *
from layoffs_staging2;





select *
from layoffs_staging2
where industry is null
or industry='';

select *
from layoffs_staging2
where company like 'Airbnb';

update layoffs_staging2
set industry = NULL
where industry= '';

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company and t1.location = t2.location
where (t1.industry is null or t1.industry = '') and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company and t1.location = t2.location
set t1.industry=t2.industry
where (t1.industry is null) and t2.industry is not null;




select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null
;

delete layoffs_staging2
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null
;


select * 
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;









