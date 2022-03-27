USE DSS2g3;
-- QUERIES 8

-- Find products that have never been purchased by some users, 
-- but are the top 5 most purchased products by other users in August 2021.

WITH subquery1 AS
(SELECT Y.PName,TotalQuantity,DistinctUsers FROM( 
	(SELECT PName, SUM(OQuantity) As TotalQuantity
	FROM Shiokee.Product_in_order AS PIO, Shiokee.[Order] AS O
	WHERE O.OrderDateTime >= DATEADD(DAY, 0, '2021/08/1') AND O.OrderDateTime <= DATEADD(DAY, 0, '2021/08/31')
	GROUP BY PIO.PName) AS Y
	INNER JOIN
	(Select X.PName, Count(Distinct X.UserID) AS DistinctUsers
		FROM(SELECT PName, UserID
			FROM Shiokee.Product_in_order AS PIO, Shiokee.[Order] AS O
			WHERE O.OrderDateTime >= DATEADD(DAY, 0, '2021/08/1') AND O.OrderDateTime <= DATEADD(DAY, 0, '2021/08/31') AND PIO.OrderID = O.OrderID
			GROUP BY PIO.PName, O.UserID) AS X
		GROUP BY X.PName) AS X2
	ON Y.PName = X2.PName)
)

SELECT TOP(5) *
FROM subquery1 
WHERE subquery1.DistinctUsers != (Select Count(*) FROM Shiokee.[User])
Order by TotalQuantity DESC
