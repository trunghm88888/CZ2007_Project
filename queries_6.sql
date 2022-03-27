USE DSS2g3;
-- QUERIES 6

-- Find shops that made the most revenue in August 2021
WITH subquery1 AS
(
SELECT PO.SName, SUM(OPrice * OQuantity) AS Revenue
FROM Shiokee.Product_in_order AS PO, Shiokee.[Order] AS O
WHERE NOT OStatus = 'returned' AND PO.OrderID = O.OrderID AND 
    O.OrderDateTime >= DATEADD(DAY, 0, '2021/08/1') AND O.OrderDateTime <= DATEADD(DAY, 0, '2021/08/31')
GROUP BY PO.SName
)

SELECT *
FROM subquery1 
WHERE Revenue = 
(SELECT MAX(Revenue)
FROM subquery1 q1)

