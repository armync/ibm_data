CREATE MATERIALIZED VIEW total_sales_per_country AS
SELECT country, COUNT(*)
FROM "FactSales" AS fs
LEFT JOIN "DimCountry" AS dc
ON fs.countryid = dc.countryid
GROUP BY country;

SELECT * FROM total_sales_per_country;