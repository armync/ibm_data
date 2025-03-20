SELECT year, quartername, sum(billedamount) as total
FROM "FactBilling" f
LEFT JOIN "DimMonth" dm
ON f.monthid = dm.monthid
GROUP BY GROUPING SETS(year,quartername);

SELECT country, category, sum(billedamount) as total
FROM "FactBilling" f
LEFT JOIN "DimCustomer" d
ON f.customerid = d.customerid
GROUP BY ROLLUP(country,category)
ORDER BY country,category

SELECT year, country, sum(billedamount) as total
FROM "FactBilling" f
LEFT JOIN "DimCustomer" d
ON f.customerid = d.customerid
LEFT JOIN "DimMonth" dm
ON f.monthid = dm.monthid
GROUP BY CUBE(year,country,category);

CREATE MATERIALIZED VIEW
average_billamount(
	years,
	quarter,
	category,
	country,
	average_bill_amount)
AS	(
	SELECT year, quarter, category, country, avg(billedamount) as total
	FROM "FactBilling" f
	LEFT JOIN "DimCustomer" dc
	ON f.customerid = dc.customerid
	LEFT JOIN "DimMonth" dm
	ON f.monthid = dm.monthid
	GROUP BY year, quarter, category, country
	);

