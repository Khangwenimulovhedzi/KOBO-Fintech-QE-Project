--  This query identify invalid mobile numbers MSISDN

SELECT * FROM Users
WHERE 
    LEN(MSISDN) != 11
    OR MSISDN LIKE '%[^0-9]%';