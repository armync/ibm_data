SELECT COUNT(*) from public."DimMonth";

SELECT COUNT(*) FROM public."FactBilling";

CREATE MATERIALIZED VIEW avg_customer_bill(customerid, averagebillammount)
AS (select customerid, avg(billedamount)
from public."FactBilling"
GROUP BY customerid
);

REFRESH MATERIALIZED VIEW avg_customer_bill;

SELECT * from avg_customer_bill WHERE averagebillammount > 11000;