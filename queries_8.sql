USE DSS2g3;
-- QUERIES 8

-- Find products that have never been purchased by some users, but are the top 5 most purchased
-- products by other users in August 2021.

-- Step 1: Find products that have never been purchased by some users
WITH subquery1 AS (
    SELECT PName FROM
        (SELECT PName,
        COUNT(DISTINCT UserID) noOfUser
        FROM (
            Shiokee.Product_in_order p INNER JOIN Shiokee.[Order] o
            ON p.OrderID = o.OrderID
            AND o.OrderDateTime >= '2021-08-01'
            AND o.OrderDateTime <= '2021-08-31'
        )
        GROUP BY PName
    ) Table1
    WHERE noOfUser < (SELECT COUNT(*) FROM Shiokee.[User])
),

-- Step 2: Find products that are the top 5 most purchased products in August 2021
subquery2 AS (
    SELECT TOP 5 PName FROM (
        SELECT PName, SUM(OQuantity) as PurchasedQuantity FROM (
            Shiokee.Product_in_order p INNER JOIN Shiokee.[Order] o
            ON p.OrderID = o.OrderID
        )
        WHERE (OrderDateTime >= '2021-08-01' AND OrderDateTime <= '2021-08-31')
        GROUP BY PName
    ) Table1
        ORDER BY PurchasedQuantity DESC
)

-- Step 3: Answer

SELECT subquery1.PName FROM (
    subquery1 INNER JOIN subquery2
    ON subquery1.PName = subquery2.PName
)
