-- -----------------------------------------------
-- Nettoyage des valeurs 'N/A' en NULL
-- -----------------------------------------------
UPDATE [dbo].[apple_global_sales_dataset]
SET storage = NULL
WHERE storage = 'N/A';

UPDATE [dbo].[apple_global_sales_dataset]
SET previous_device_os = NULL
WHERE previous_device_os = 'N/A';

UPDATE [dbo].[apple_global_sales_dataset]
SET customer_rating = NULL
WHERE customer_rating = 'N/A';

-- -----------------------------------------------
-- Correction des caractères spéciaux dans customer_age_group
-- -----------------------------------------------
UPDATE [dbo].[apple_global_sales_dataset]
SET customer_age_group = REPLACE(customer_age_group,'â€“','-');

-- -----------------------------------------------
-- Modification du type de données des colonnes
-- -----------------------------------------------
ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN sale_date DATE;  -- Conversion en date

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN year INT;        -- Conversion en entier

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN unit_price_usd DECIMAL(10,2);  -- Montant avec 2 décimales

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN discount_pct INT;  -- Pourcentage en entier

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN units_sold INT;  -- Quantité vendue en entier

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN discounted_price_usd DECIMAL(10,2);  -- Prix après remise

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN revenue_usd DECIMAL(12,2);  -- Revenus en USD

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN fx_rate_to_usd FLOAT;  -- Taux de change

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN revenue_local_currency DECIMAL(18,2);  -- Revenus dans la monnaie locale

ALTER TABLE [dbo].[apple_global_sales_dataset]
ALTER COLUMN customer_rating FLOAT;  -- Note client en décimal

-- -----------------------------------------------
-- Suppression des espaces en début/fin de chaîne
-- -----------------------------------------------
UPDATE [dbo].[apple_global_sales_dataset]
SET country = LTRIM(RTRIM(country)),
    region = LTRIM(RTRIM(region)),
    city = LTRIM(RTRIM(city)),
    product_name = LTRIM(RTRIM(product_name));

-- -----------------------------------------------
-- Vérification des doublons sur sale_id
-- -----------------------------------------------
SELECT sale_id, COUNT(*)
FROM [dbo].[apple_global_sales_dataset]
GROUP BY sale_id
HAVING COUNT(*) > 1;

-- -----------------------------------------------
-- Remplissage des customer_rating manquants avec la moyenne par produit et année
-- -----------------------------------------------
UPDATE a
SET a.customer_rating = b.avg_rating
FROM [dbo].[apple_global_sales_dataset] a
JOIN (
    SELECT product_name, year, AVG(customer_rating) AS avg_rating
    FROM [dbo].[apple_global_sales_dataset]
    WHERE customer_rating IS NOT NULL
    GROUP BY product_name, year
) b
ON a.product_name = b.product_name
AND a.year = b.year
WHERE a.customer_rating IS NULL;

-- -----------------------------------------------
-- Remplissage des valeurs NULL restantes par des valeurs par défaut
-- -----------------------------------------------
UPDATE [dbo].[apple_global_sales_dataset]
SET storage = 'No Storage'
WHERE storage IS NULL;

UPDATE [dbo].[apple_global_sales_dataset]
SET previous_device_os = 'Unknown'
WHERE previous_device_os IS NULL;

-- -----------------------------------------------
-- Vérification des lignes encore avec des valeurs manquantes
-- -----------------------------------------------
SELECT *
FROM [dbo].[apple_global_sales_dataset]
WHERE 
customer_rating IS NULL
OR storage IS NULL
OR previous_device_os IS NULL;

-- -----------------------------------------------
-- Comptage des valeurs non NULL pour toutes les colonnes
-- -----------------------------------------------
SELECT
COUNT(*) AS total_rows,
COUNT(sale_id) AS sale_id_not_null,
COUNT(sale_date) AS sale_date_not_null,
COUNT(year) AS year_not_null,
COUNT(quarter) AS quarter_not_null,
COUNT(month) AS month_not_null,
COUNT(country) AS country_not_null,
COUNT(region) AS region_not_null,
COUNT(city) AS city_not_null,
COUNT(product_name) AS product_name_not_null,
COUNT(category) AS category_not_null,
COUNT(storage) AS storage_not_null,
COUNT(color) AS color_not_null,
COUNT(unit_price_usd) AS unit_price_usd_not_null,
COUNT(discount_pct) AS discount_pct_not_null,
COUNT(units_sold) AS units_sold_not_null,
COUNT(discounted_price_usd) AS discounted_price_usd_not_null,
COUNT(revenue_usd) AS revenue_usd_not_null,
COUNT(currency) AS currency_not_null,
COUNT(fx_rate_to_usd) AS fx_rate_to_usd_not_null,
COUNT(revenue_local_currency) AS revenue_local_currency_not_null,
COUNT(sales_channel) AS sales_channel_not_null,
COUNT(payment_method) AS payment_method_not_null,
COUNT(customer_segment) AS customer_segment_not_null,
COUNT(customer_age_group) AS customer_age_group_not_null,
COUNT(previous_device_os) AS previous_device_os_not_null,
COUNT(customer_rating) AS customer_rating_not_null,
COUNT(return_status) AS return_status_not_null
FROM [dbo].[apple_global_sales_dataset];

