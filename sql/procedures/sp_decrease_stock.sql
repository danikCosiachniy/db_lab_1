-- Списание товара со склада (транзакция) + OUT-флаг успеха + остаток
CREATE OR ALTER PROCEDURE dbo.sp_decrease_stock
    @stock_id INT,
    @take_qty INT,
    @success BIT OUTPUT,
    @remaining_qty INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    SET @success = 0;
    SET @remaining_qty = NULL;

    BEGIN TRAN;

    UPDATE dbo.Stock
    SET quantity = quantity - @take_qty
    WHERE stock_id = @stock_id
      AND quantity >= @take_qty;

    IF @@ROWCOUNT = 0
    BEGIN
        ROLLBACK;
        RETURN;
    END

    SELECT @remaining_qty = quantity
    FROM dbo.Stock
    WHERE stock_id = @stock_id;

    COMMIT;

    SET @success = 1;
END;
GO