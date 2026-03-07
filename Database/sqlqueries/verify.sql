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