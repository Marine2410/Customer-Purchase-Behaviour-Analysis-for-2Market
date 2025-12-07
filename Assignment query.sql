CREATE TABLE marketing_data (
    ID INTEGER PRIMARY KEY,
    Year_Birth INTEGER,
    Education VARCHAR(100),
    Marital_Status VARCHAR(100),
    Income2 NUMERIC,  -- Rename or remove if duplicate
    Kidhome INTEGER,
    Teenhome INTEGER,
    Dt_Customer DATE,
    Recency INTEGER,
    AmtLiq NUMERIC,
    AmtVege NUMERIC,
    AmtNonVeg NUMERIC,
    AmtPes NUMERIC,
    AmtChocolates NUMERIC,
    AmtComm NUMERIC,
    NumDeals INTEGER,
    NumWebBuy INTEGER,
    NumWalkinPur INTEGER,
    NumVisits INTEGER,
    Response INTEGER,
    Complain INTEGER,
    Country VARCHAR(100),
    Count_success INTEGER
);

SELECT * FROM "marketing_data";

CREATE TABLE ad_data (
	ID Integer PRIMARY KEY,
	Bulkmail_ad NUMERIC,
	Twitter_ad NUMERIC,
	Instagram_ad NUMERIC,
	Facebook_ad NUMERIC,
	Brochure_ad NUMERIC
);

SELECT * FROM ad_data;

--total spend per country

SELECT 
	"country",
	SUM(amtliq + amtvege + amtnonveg + amtpes + amtchocolates + amtcomm) AS "total"
FROM public.marketing_data
GROUP BY "country";

--total spend per country per product

SELECT 
	"country",
	SUM(amtliq) AS "total_liquor",
	SUM(amtvege) AS "total_vegetables", 
	SUM(amtnonveg) AS "total_meat",
	SUM(amtpes) AS "total_fish",
	SUM(amtchocolates) AS "tota_chocolates", 
	SUM(amtcomm) AS "total_commodities"
FROM public.marketing_data
GROUP BY "country";

--most popular item 
--Liquor

--most popular based on marital status

SELECT 
	"marital_status",
	SUM(amtliq) AS "total_liquor",
	SUM(amtvege) AS "total_vegetables", 
	SUM(amtnonveg) AS "total_meat",
	SUM(amtpes) AS "total_fish",
	SUM(amtchocolates) AS "tota_chocolates", 
	SUM(amtcomm) AS "total_commodities"
FROM public.marketing_data
GROUP BY "marital_status";

--most popular item
--Liquor

--most popular based on teens and children at home 

SELECT 
	CASE WHEN kidhome > 0 THEN 'Has children' ELSE 'No children' END AS child_status,
	CASE When teenhome > 0 THEN 'Has teens' ELSE 'No teens' END AS teen_status,
	SUM(amtliq) AS "total_liquor",
	SUM(amtvege) AS "total_vegetables", 
	SUM(amtnonveg) AS "total_meat",
	SUM(amtpes) AS "total_fish",
	SUM(amtchocolates) AS "tota_chocolates", 
	SUM(amtcomm) AS "total_commodities"
FROM marketing_data
GROUP BY "child_status", "teen_status";

--Table Join and create new table

CREATE TABLE "marketing_ad_data" AS
	SELECT
	m."id",
	m."marital_status",
	m."country",
	m."count_success",
	m."numdeals",
	a."bulkmail_ad",
	a."twitter_ad",
	a."instagram_ad",
	a."facebook_ad",
	a."brochure_ad"
FROM "marketing_data" m
INNER JOIN "ad_data" a ON m."id" = a."id";

--Most effective social media platform

SELECT
  country,
  SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END) AS facebook_leads,
  SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END) AS instagram_leads,
  SUM(CASE WHEN twitter_ad = 1 THEN count_success ELSE 0 END) AS twitter_leads,
  CASE
    WHEN SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END) = GREATEST(
           SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END),
           SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END),
           SUM(CASE WHEN twitter_ad = 1 THEN count_success ELSE 0 END)
         ) THEN 'Facebook'
    WHEN SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END) = GREATEST(
           SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END),
           SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END),
           SUM(CASE WHEN twitter_ad = 1 THEN count_success ELSE 0 END)
         ) THEN 'Instagram'
    ELSE 'Twitter'
  END AS most_effective_platform
FROM marketing_ad_data
GROUP BY country;

--Most succesful social media platform based on marital status

SELECT
  marital_status,
  SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END) AS facebook_leads,
  SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END) AS instagram_leads,
  SUM(CASE WHEN twitter_ad = 1 THEN count_success ELSE 0 END) AS twitter_leads,
  CASE
    WHEN SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END) = GREATEST(
           SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END),
           SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END),
           SUM(CASE WHEN twitter_ad = 1 THEN count_success ELSE 0 END)
         ) THEN 'Facebook'
    WHEN SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END) = GREATEST(
           SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END),
           SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END),
           SUM(CASE WHEN twitter_ad = 1 THEN count_success ELSE 0 END)
         ) THEN 'Instagram'
    ELSE 'Twitter'
  END AS most_effective_platform
FROM marketing_ad_data
GROUP BY marital_status;


--Add the product columns to the table

ALTER TABLE marketing_ad_data
ADD COLUMN amtliq NUMERIC,
ADD COLUMN amtvege NUMERIC,
ADD COLUMN amtnonveg NUMERIC,
ADD COLUMN amtpes NUMERIC,
ADD COLUMN amtchocolates NUMERIC,
ADD COLUMN amtcomm NUMERIC;

UPDATE marketing_ad_data ma
SET 
	amtliq=m.amtliq,
	amtvege=m.amtvege,
	amtnonveg=m.amtnonveg,
	amtpes=m.amtpes,
	amtchocolates=m.amtchocolates,
	amtcomm=m.amtcomm
FROM marketing_data m
WHERE m.id = ma.id;

--third question

SELECT
  country,

  -- Spending influenced by each platform
  SUM(CASE WHEN facebook_ad = 1 THEN amtliq + amtvege + amtnonveg + amtpes + amtchocolates + amtcomm ELSE 0 END) AS facebook_spending,
  SUM(CASE WHEN instagram_ad = 1 THEN amtliq + amtvege + amtnonveg + amtpes + amtchocolates + amtcomm ELSE 0 END) AS instagram_spending,
  SUM(CASE WHEN twitter_ad = 1 THEN amtliq + amtvege + amtnonveg + amtpes + amtchocolates + amtcomm ELSE 0 END) AS twitter_spending,

  -- Successful conversions
  SUM(CASE WHEN facebook_ad = 1 THEN count_success ELSE 0 END) AS facebook_conversions,
  SUM(CASE WHEN instagram_ad = 1 THEN count_success ELSE 0 END) AS instagram_conversions,
  SUM(CASE WHEN twitter_ad = 1 THEN count_success ELSE 0 END) AS twitter_conversions
FROM marketing_ad_data
GROUP BY country;


--For each country:
--Compare spending associated with each ad platform.
--See whether higher conversions correlate with higher spending.--> high correlation (not for Germany and India)
--The most influential platform is the one tied to the highest spending and/or conversion efficiency.





