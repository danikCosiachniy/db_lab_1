CREATE OR ALTER TRIGGER dbo.TR_Stock_AfterInsert
ON dbo.Stock
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Stock_Audit
    (
        action_type, stock_id, pharmacy_id, variant_id, medicine_id,
        new_quantity, new_price, new_exp_date, info
    )
    SELECT
        N'INSERT',
        i.stock_id, i.pharmacy_id, i.variant_id, i.medicine_id,
        i.quantity, i.price, i.exp_date,
        N'New batch added'
    FROM inserted i;
END;
GO