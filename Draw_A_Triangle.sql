SET @TEMP := 0;
SELECT REPEAT('* ',@TEMP := @TEMP + 1) 
FROM information_schema.tables 
WHERE @TEMP < 5
