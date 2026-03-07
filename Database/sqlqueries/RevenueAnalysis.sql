SELECT 
    Users.AccountTier,
    SUM(TransactionLedger.Amount) AS TotalRevenue,
    COUNT(TransactionLedger.EntryID) AS TotalTransactions
FROM TransactionLedger
LEFT JOIN Wallets
    ON TransactionLedger.WalletID = Wallets.WalletID
LEFT JOIN Users
    ON Wallets.UserID = Users.UserID
WHERE TransactionLedger.ProcessingStatus = 'COMPLETED'
GROUP BY Users.AccountTier;

