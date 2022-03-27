USE DSS2g3;
-- QUERIES 5

-- Produce a list that contains (i) all products made by Samsung, and (ii) for each of them, the number
-- of shops on Shiokee that sell the product. 
SELECT P.PName, COUNT(DISTINCT SName) AS No_of_Selling_Shops
FROM Shiokee.Product AS P, Shiokee.Product_in_shop AS PS
WHERE Maker='Samsung' AND P.PName = PS.PName
GROUP BY P.PName