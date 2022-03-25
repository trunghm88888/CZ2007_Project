USE DSS2g3;
-- QUERIES 1

-- Get Find the average price of “iPhone Xs” on Shiokee from 1 August 2021 to 31 August 2021
SELECT AVG(Price) AS Average_Price
FROM Shiokee.Price_history
WHERE PName='iPhone Xs' AND StartDate >= DATEADD(DAY, 0, '2021/08/1') AND StartDate <= DATEADD(DAY, 0, '2021/08/31')