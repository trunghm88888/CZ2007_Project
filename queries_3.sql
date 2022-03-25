USE DSS2g3;
-- QUERIES 3

-- For all products purchased in June 2021 that have been delivered, find the average time from the ordering date to the delivery date. 
SELECT PO.PName, AVG(DATEDIFF(DAY, O.OrderDateTime, DeliveryDate)) AS AverageDays
FROM Shiokee.Product_in_order AS PO, Shiokee.[Order] AS O
WHERE OStatus='delivered' AND DeliveryDate >= DATEADD(DAY, 0, '2021/06/1') AND DeliveryDate <= DATEADD(DAY, 0, '2021/06/30')
GROUP BY PO.PName
