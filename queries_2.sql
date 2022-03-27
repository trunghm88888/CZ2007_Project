USE DSS2g3;
-- QUERIES 2

-- Find products that received at least 100 ratings of “5” in August 2021, and order them by their average ratings. 
WITH subquery1 AS
(
SELECT PName, Rating
FROM Shiokee.Feedback
WHERE Rating=5 AND FDateTime >= DATEADD(DAY, 0, '2021/08/1') AND FDateTime <= DATEADD(DAY, 0, '2021/08/31')
GROUP BY PName, Rating
HAVING COUNT(Rating) >= 100
)

SELECT F.PName, AVG(CAST(F.Rating AS DECIMAL(10,2))) AS Average_Ratings
FROM subquery1 q1, Shiokee.Feedback AS F
WHERE F.PName = q1.PName
GROUP BY F.PName
ORDER BY Average_Ratings

