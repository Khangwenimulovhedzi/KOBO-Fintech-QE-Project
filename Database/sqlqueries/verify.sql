-- Verify User count
SELECT COUNT(*) AS UserCount FROM Users;

-- Verify the tables exist
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('ServiceProviders', 'Users', 'Wallets', 'Products', 'TransactionLedger', 'DigitalVouchers');

-- Verify wallet balances

SELECT TOP 5 u.FullName, w.Balance, w.CurrencyCode
FROM KoboFintech.dbo.Users u
JOIN KoboFintech.dbo.Wallets w ON u.UserID = w.UserID
ORDER BY u.UserID;

-- Verify disabled users
SELECT UserID, FullName, ServiceStatus
FROM KoboFintech.dbo.Users
WHERE ServiceStatus = 'Disabled';

-- Verify the low balance wallet
SELECT w.WalletID, w.Balance, u.FullName
FROM KoboFintech.dbo.Wallets w
JOIN KoboFintech.dbo.Users u ON w.UserID = u.UserID
WHERE w.WalletID = 10;


-- Select Walletid, balance 
-- from Wallets 
-- where walletid = 10;

SELECT * from digitalvouchers
where EntryID = '0d0c1b7f-5cbf-40c2-a502-54a33db1ce29';
