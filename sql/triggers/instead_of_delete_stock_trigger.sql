CREATE OR ALTER TRIGGER dbo.TR_Stock_InsteadOfDelete
ON dbo.Stock
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- 1) Сохраняем удаляемые строки в архив
    INSERT INTO dbo.Stock_Archive
    (stock_id, variant_id, quantity, price, exp_date, lot_date, medicine_id, pharmacy_id)
    SELECT
        d.stock_id, d.variant_id, d.quantity, d.price, d.exp_date, d.lot_date, d.medicine_id, d.pharmacy_id
    FROM deleted d;

    -- 2) Логируем факт удаления в аудит
    INSERT INTO dbo.Stock_Audit
    (action_type, stock_id, pharmacy_id, variant_id, medicine_id, old_quantity, old_price, old_exp_date, info)
    SELECT
        N'DELETE',
        d.stock_id, d.pharmacy_id, d.variant_id, d.medicine_id,
        d.quantity, d.price, d.exp_date,
        N'Deleted -> moved to archive (INSTEAD OF DELETE)'
    FROM deleted d;

    -- 3) Реально удаляем из Stock
    DELETE s
    FROM dbo.Stock s
    JOIN deleted d ON d.stock_id = s.stock_id;
END;
GO