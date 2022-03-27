USE DSS2g3;
-- QUERIES 4

-- Let us define the “latency” of an employee by the average that he/she takes to process a complaint. 
-- Find the employee with the smallest latency. 

SELECT EID, AVG(CAST(DATEDIFF(DAY, FiledDateTime, HandledDateTime) AS DECIMAL(10,2))) AS Latency
FROM Shiokee.Complaint
WHERE EID IS NOT NULL
GROUP BY EID
HAVING AVG(CAST(DATEDIFF(DAY, FiledDateTime, HandledDateTime) AS DECIMAL(10,2))) = (Select Min(S1.Latency) From
	(Select EID, AVG(CAST(DATEDIFF(DAY, FiledDateTime, HandledDateTime) AS DECIMAL(10,2))) AS Latency
	FROM Shiokee.Complaint
	WHERE EID IS NOT NULL
	GROUP BY EID) as S1)
