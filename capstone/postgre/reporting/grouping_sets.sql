SELECT country, category, COUNT(*)
FROM "FactSales" AS fs
LEFT JOIN "DimCategory" AS dcat
ON fs.categoryid = dcat.categoryid
LEFT JOIN "DimCountry" AS dc
ON fs.countryid = dc.countryid
GROUP BY
	GROUPING SETS (
		(dc.country, dcat.category),
		(dc.country),
		(dcat.category),
		()
	);