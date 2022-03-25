USE DSS2g3;
-- QUERIES 9

-- Get total purchased quantity for each product in most recent 3 months
DECLARE @today DATETIME;
SET @today = GETDATE();
WITH subquery1 AS
(
SELECT PName,
SUM(case when OrderDateTime > DATEADD(month, -1, @today) AND OrderDateTime <= @today then OQuantity else 0 end) as LastMonth,
SUM(case when OrderDateTime > DATEADD(month, -2, @today) AND OrderDateTime <= DATEADD(month, -1, @today) then OQuantity else 0 end) as FirstToLastMonth,
SUM(case when OrderDateTime > DATEADD(month, -3, @today) AND OrderDateTime <= DATEADD(month, -2, @today) then OQuantity else 0 end) as SecondToLastMonth
FROM
    (SELECT Shiokee.Product_in_order.PName,
    Shiokee.[Order].OrderDateTime,
    Shiokee.Product_in_order.OQuantity
    FROM
        (Shiokee.Product_in_order INNER JOIN Shiokee.[Order]
        ON Shiokee.Product_in_order.OrderID = Shiokee.[Order].OrderID
        AND Shiokee.[Order].OrderDateTime > DATEADD(month, -3, @today)
        )
    ) Table1
GROUP BY PName
)

-- Get products that are increasingly being purchased in at least 3 months
-- ANSWER
SELECT PName,
LastMonth,
FirstToLastMonth,
SecondToLastMonth
FROM subquery1 q1
WHERE LastMonth > FirstToLastMonth
AND FirstToLastMonth > SecondToLastMonth