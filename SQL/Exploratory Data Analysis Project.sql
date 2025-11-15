-- Exploratory Data Analysis



-- 1. Preview the cleaned data
SELECT *
From layoffs_staging2;

-- 2. Max layoffs and layoff percentage
SELECT Max(total_laid_off), Max(percentage_laid_off)
From layoffs_staging2;

-- 3. Companies with 100% layoffs
SELECT *
From layoffs_staging2
where percentage_laid_off=1
Order by funds_raised_millions desc;

-- 4. Total layoffs by compan
SELECT company, sum(total_laid_off)
From layoffs_staging2
group by company
order by sum(total_laid_off) desc;



-- 5. Date range of layoffs
select min(`date`), max(`date`)
from layoffs_staging2;


-- 6. Total layoffs by industry
SELECT industry, sum(total_laid_off)
From layoffs_staging2
group by industry
order by sum(total_laid_off) desc;

-- 7. Total layoffs by country
SELECT country, sum(total_laid_off)
From layoffs_staging2
group by country
order by sum(total_laid_off) desc;


-- 8. Daily layoff trends
SELECT `date`, sum(total_laid_off)
From layoffs_staging2
group by `date`
order by sum(total_laid_off) desc;



-- 9. Yearly layoff totals
SELECT Year(`date`), sum(total_laid_off)
From layoffs_staging2
group by Year(`date`)
order by sum(total_laid_off) desc;


-- 10. Layoffs by funding stage
SELECT stage, sum(total_laid_off)
From layoffs_staging2
group by stage
order by sum(total_laid_off) desc;


-- 11. Average layoff percentage by year
SELECT Year(`date`), avg(percentage_laid_off)
From layoffs_staging2
group by Year(`date`)
order by avg(percentage_laid_off) desc;


-- 12. Monthly layoff totals
select substring(`date`,1,7) as Month, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by `Month`
order by `Month`;

-- 13. Rolling monthly totals
with Rolling_total as(
select substring(`date`,1,7) as Month, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) IS NOT NULL
group by `Month`
order by `Month`)
select `Month`,total_off, SUM(total_off) OVER(ORDER BY `Month`) AS rolling_total
from Rolling_total;


-- 14. Yearly layoffs by company
SELECT Year(`date`), company, sum(total_laid_off)
From layoffs_staging2
group by Year(`date`), company
order by sum(total_laid_off) desc;



-- 15. Top 5 companies by layoffs per year
with Company_year As(
SELECT Year(`date`) as years, company, sum(total_laid_off) as total_laid_off
From layoffs_staging2
group by Year(`date`), company
), Company_Year_Rank AS(
select *, dense_rank() over (Partition by years order by total_laid_off desc) as Rank_Num
from Company_year
where years is not null 
order by Rank_num)
select *
from Company_Year_Rank
where Rank_num <=5
order by years
;





