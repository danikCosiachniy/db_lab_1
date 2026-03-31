CREATE OR ALTER TRIGGER dbo.TR_Stock_AfterUpdate
ON dbo.Stock
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Блокировка некорректных значений
    IF EXISTS (
        SELECT 1
        FROM inserted i
        WHERE i.quantity < 0 OR i.price < 0
    )
    BEGIN
        RAISERROR(N'Quantity and price must be non-negative.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO dbo.Stock_Audit
    (
        action_type, stock_id, pharmacy_id, variant_id, medicine_id,
        old_quantity, new_quantity, old_price, new_price,
        old_exp_date, new_exp_date, info
    )
    SELECT
        N'UPDATE',
        i.stock_id, i.pharmacy_id, i.variant_id, i.medicine_id,
        d.quantity, i.quantity,
        d.price, i.price,
        d.exp_date, i.exp_date,
        N'Batch updated'
    FROM inserted i
    JOIN deleted  d ON d.stock_id = i.stock_id;
END;
GO