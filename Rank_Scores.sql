SELECT s.Score, r.rank 
FROM SCORES s
JOIN(
    SELECT score, @val := @val + 1 AS rank
    FROM (SELECT DISTINCT(SCORE) FROM scores) s1, (SELECT @val := 0) r1
    ORDER BY score desc) r
ON s.SCORE = r.SCORE
ORDER BY SCORE DESC

