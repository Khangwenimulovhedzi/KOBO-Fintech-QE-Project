-- This query checks whether transaction recorded in the TransactionLedger table have a corresponding entry in the DigitalVouchers table.

SELECT 
    tl.EntryID,
    tl.WalletID,
    tl.ProductID,
    tl.Amount,
    tl.ProcessingStatus,
    tl.CreatedTimestamp
FROM TransactionLedger tl
LEFT JOIN DigitalVouchers dv
    ON tl.EntryID = dv.EntryID
WHERE dv.EntryID IS NULL;
