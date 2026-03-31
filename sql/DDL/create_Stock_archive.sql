IF OBJECT_ID('dbo.Stock_Archive', 'U') IS NOT NULL
    DROP TABLE dbo.Stock_Archive;
GO

CREATE TABLE dbo.Stock_Archive
(
    archive_id   INT IDENTITY(1,1) PRIMARY KEY,
    archived_at  DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
    stock_id     INT NOT NULL,
    variant_id   INT NOT NULL,
    quantity     INT NOT NULL,
    price        DECIMAL(12,2) NOT NULL,
    exp_date     DATE NULL,
    lot_date     DATE NULL,
    medicine_id  INT NOT NULL,
    pharmacy_id  INT NOT NULL
);
GO