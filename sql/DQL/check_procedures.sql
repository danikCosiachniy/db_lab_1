USE PharmacyDB;
GO

/* 1) Процедуры без параметров */
EXEC dbo.sp_pharmacies_summary;
GO

EXEC dbo.sp_expiring_30d;
GO


/* 2) Процедуры только с входными параметрами */
EXEC dbo.sp_find_medicine_in_stock @medicine_name = N'Парац';
GO

-- Добавим партию, чтобы точно была “истекающая” (через 20 дней)
DECLARE @lot_date date = CAST(GETDATE() AS date);
DECLARE @exp_date date = DATEADD(DAY, 20, @lot_date);

EXEC dbo.sp_add_stock_batch
     @pharmacy_id = 1,
     @variant_id  = 1,
     @quantity    = 10,
     @price       = 4.30,
     @lot_date    = @lot_date,
     @exp_date    = @exp_date;
GO


/* 3) Процедуры с входными и выходными параметрами */
DECLARE @avg DECIMAL(18,2), @wavg DECIMAL(18,2);

EXEC dbo.sp_get_medicine_avg_price
     @medicine_id = 1,
     @avg_price = @avg OUTPUT,
     @avg_price_weighted = @wavg OUTPUT;

SELECT @avg AS avg_price, @wavg AS avg_price_weighted;
GO


DECLARE @ok BIT, @rem INT;

-- Списание 1 штуки из stock_id = 1 (если там есть остаток)
EXEC dbo.sp_decrease_stock
     @stock_id = 53,
     @take_qty = 1,
     @success = @ok OUTPUT,
     @remaining_qty = @rem OUTPUT;

SELECT @ok AS success, @rem AS remaining_qty;
GO

SELECT stock_id, quantity
FROM dbo.Stock
WHERE stock_id = 1;