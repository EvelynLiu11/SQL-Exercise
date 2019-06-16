SELECT DISTINCT(C1.SEAT_ID)
FROM CINEMA C1
JOIN CINEMA C2
ON C1.FREE = 1
AND C2.FREE = 1
AND ABS(C1.SEAT_ID - C2.SEAT_ID) = 1
ORDER BY C1.SEAT_ID;
