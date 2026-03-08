-- This query identifies transactions in the transactionledger table where amount does not match the faceValue in the product table.

SELECT TransactionLedger.EntryID,
TransactionLedger.Amount, 
Products.FaceValue
 FROM TransactionLedger
Left JOIN Products
    ON TransactionLedger.ProductID = Products.ProductID
WHERE TransactionLedger.Amount <> Products.FaceValue;