CREATE OR ALTER TRIGGER dbo.TR_Stock_AfterDelete
ON dbo.Stock
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Stock_Audit
    (
        action_type, stock_id, pharmacy_id, variant_id, medicine_id,
        old_quantity, old_price, old_exp_date, info
    )
    SELECT
        N'DELETE',
        d.stock_id, d.pharmacy_id, d.variant_id, d.medicine_id,
        d.quantity, d.price, d.exp_date,
        N'Batch deleted'
    FROM deleted d;
END;
GO