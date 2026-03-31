--INSERT (должен попасть в Audit)
DECLARE @lot_date date = CAST(GETDATE() AS date);
DECLARE @exp_date date = DATEADD(DAY, 15, @lot_date);

INSERT INTO dbo.Stock (variant_id, quantity, price, exp_date, lot_date, medicine_id, pharmacy_id)
VALUES (1, 5, 4.99, @exp_date, @lot_date, 1, 1);

SELECT TOP (20) * FROM dbo.Stock_Audit ORDER BY audit_id DESC;

--UPDATE (должен попасть в Audit)
UPDATE dbo.Stock
SET price = price + 0.50
WHERE stock_id = (SELECT TOP (1) stock_id FROM dbo.Stock ORDER BY stock_id DESC);

SELECT TOP (20) * FROM dbo.Stock_Audit ORDER BY audit_id DESC;

--DELETE (перехватится INSTEAD OF, попадёт в Archive + Audit)
DELETE FROM dbo.Stock
WHERE stock_id = (SELECT TOP (1) stock_id FROM dbo.Stock ORDER BY stock_id DESC);

SELECT TOP (20) * FROM dbo.Stock_Audit ORDER BY audit_id DESC;
SELECT TOP (20) * FROM dbo.Stock_Archive ORDER BY archive_id DESC;