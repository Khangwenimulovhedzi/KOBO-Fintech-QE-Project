-- SELECT
--     tl.EntryID,
--     tl.ProductID,
--     p.FaceValue AS ProductPrice,
--     tl.Amount AS LedgerAmount,
--     tl.ProcessingStatus
-- FROM TransactionLedger tl
-- JOIN Products p
--     ON tl.ProductID = p.ProductID
-- WHERE tl.Amount <> p.FaceValue;

SELECT TransactionLedger.EntryID, TransactionLedger.Amount, Products.FaceValue
 FROM TransactionLedger
Left JOIN Products
    ON TransactionLedger.ProductID = Products.ProductID
WHERE TransactionLedger.Amount <> Products.FaceValue;