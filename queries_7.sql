USE DSS2g3;
-- QUERIES 7

-- For users that made the most amount of complaints, find the most expensive products he/she has ever purchased.
WITH subquery1 AS 
(
SELECT UserID, Count(CID) AS TotalComplaints
FROM Shiokee.Complaint
GROUP BY UserID
HAVING Count(CID) = (Select Max(X.TotalComplaints) 
					FROM(	SELECT UserID, Count(CID) AS TotalComplaints
							FROM Shiokee.Complaint
							GROUP BY UserID) As X)
)

Select PName
From Shiokee.Product_in_order PIO, Shiokee.[Order] O, subquery1 q1
WHERE PIO.OrderID = O.OrderID AND O.UserID = q1.UserID 
	  AND PIO.OPrice = (Select Max(Y.OPrice)
					   From ( Select PName,OPrice
							  From Shiokee.Product_in_order PIO, Shiokee.[Order] O, subquery1 q1
							  WHERE PIO.OrderID = O.OrderID AND O.UserID = q1.UserID ) As Y )
							  