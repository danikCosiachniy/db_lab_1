CREATE UNIQUE NONCLUSTERED INDEX UX_Stock_Batch_Key
ON dbo.Stock (pharmacy_id, variant_id, lot_date, exp_date);
GO