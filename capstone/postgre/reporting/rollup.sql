SELECT country, year, COUNT(*)
FROM "FactSales" AS fs
LEFT JOIN "DimDate" as da
ON fs.dateid = da.dateid
LEFT JOIN "DimCountry" dc
ON fs.countryid = dc.countryid
GROUP BY
ROLLUP (da.year, dc.country)
ORDER BY da.year, dc.country;