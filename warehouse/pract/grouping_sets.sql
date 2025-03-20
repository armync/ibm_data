SELECT
    p.Productid,
    p.Producttype,
    SUM(f.Price_PerUnit * f.QuantitySold) AS TotalSales
FROM
    FactSales f
INNER JOIN
    DimProduct p ON f.Productid = p.Productid
GROUP BY GROUPING SETS (
    (p.Productid, p.Producttype), -- together
    p.Productid,
    p.Producttype, -- alone
    () -- grand total
)
ORDER BY
    p.Productid,
    p.Producttype;