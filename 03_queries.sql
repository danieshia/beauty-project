-- =====================================================================
-- 03_queries.sql
-- All analysis for the Makeup Dupes project. Everything past the load
-- step (02_excel_to_mysql.py) is pure SQL, per spec.
-- Run against: makeup_dupes.products
-- =====================================================================

USE makeup_dupes;

-- ---------------------------------------------------------------------
-- Reference: table shape created by the pandas .to_sql() load
-- ---------------------------------------------------------------------
-- CREATE TABLE products (
--     product_id       INT PRIMARY KEY,
--     brand            VARCHAR(50),
--     product_name     VARCHAR(100),
--     category         VARCHAR(50),
--     is_luxury        TINYINT(1),
--     price_usd        DECIMAL(6,2),
--     avg_rating       DECIMAL(3,1),   -- 1.0 - 5.0 stars
--     review_count     INT,
--     sentiment_score  INT,            -- 0-100, % positive sentiment
--     value_score      DECIMAL(6,3)    -- rating earned per dollar
-- );

-- =====================================================================
-- QUERY 1: Most-used / most-reviewed products overall
-- (drives the "which products are used the most" ask)
-- =====================================================================
SELECT
    category,
    brand,
    product_name,
    review_count,
    avg_rating
FROM products
ORDER BY review_count DESC
LIMIT 10;

-- =====================================================================
-- QUERY 2: Most-reviewed product PER CATEGORY (window function)
-- =====================================================================
SELECT category, brand, product_name, review_count, avg_rating
FROM (
    SELECT
        category, brand, product_name, review_count, avg_rating,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY review_count DESC) AS rn
    FROM products
) ranked
WHERE rn = 1
ORDER BY category;

-- =====================================================================
-- QUERY 3: Each drugstore product vs. the Charlotte Tilbury product in
-- its OWN category -- rating gap and sentiment gap.
-- (This is the exact table each Tableau chart is built from -- one
--  category at a time. Filter WHERE category = 'Lipstick' etc. to get
--  the 5-row slice behind each PNG.)
-- =====================================================================
SELECT
    d.category,
    d.brand,
    d.product_name,
    d.price_usd,
    d.avg_rating         AS drugstore_rating,
    d.sentiment_score    AS drugstore_sentiment,
    ct.avg_rating        AS charlotte_tilbury_rating,
    ct.sentiment_score   AS charlotte_tilbury_sentiment,
    ROUND(d.avg_rating - ct.avg_rating, 2)        AS rating_gap_vs_ct,
    d.sentiment_score - ct.sentiment_score        AS sentiment_gap_vs_ct
FROM products d
JOIN products ct
    ON ct.category = d.category
    AND ct.brand = 'Charlotte Tilbury'
WHERE d.brand <> 'Charlotte Tilbury'
ORDER BY d.category, d.avg_rating DESC;

-- =====================================================================
-- QUERY 4: "Best dupes" -- drugstore products that beat or come within
-- 5 sentiment points of Charlotte Tilbury, ranked by value_score
-- (rating earned per dollar spent).
-- =====================================================================
SELECT
    d.category,
    d.brand,
    d.product_name,
    d.price_usd,
    d.avg_rating,
    d.sentiment_score,
    d.value_score,
    ct.sentiment_score AS charlotte_tilbury_sentiment
FROM products d
JOIN products ct
    ON ct.category = d.category AND ct.brand = 'Charlotte Tilbury'
WHERE d.brand <> 'Charlotte Tilbury'
  AND d.sentiment_score >= ct.sentiment_score - 5
ORDER BY d.value_score DESC;

-- =====================================================================
-- QUERY 5: Brand-level summary -- avg rating, avg sentiment, avg price,
-- total reviews, across all categories.
-- =====================================================================
SELECT
    brand,
    COUNT(*)                       AS product_count,
    ROUND(AVG(avg_rating), 2)      AS avg_rating,
    ROUND(AVG(sentiment_score), 1) AS avg_sentiment,
    ROUND(AVG(price_usd), 2)       AS avg_price,
    SUM(review_count)              AS total_reviews
FROM products
GROUP BY brand
ORDER BY avg_sentiment DESC;

-- =====================================================================
-- QUERY 6: Per-category chart source data (parameterize `category`)
-- This is literally the query each Tableau PNG is built from --
-- brand, product, sentiment score, rating, all for one category,
-- Charlotte Tilbury included so it plots on the same chart.
-- =====================================================================
SELECT
    brand,
    product_name,
    avg_rating,
    sentiment_score,
    price_usd,
    is_luxury
FROM products
WHERE category = 'Lipstick'   -- swap for Foundation / Mascara / Concealer / Blush
ORDER BY is_luxury ASC, avg_rating DESC;
