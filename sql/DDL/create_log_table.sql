USE PharmacyDB;
GO

IF OBJECT_ID('dbo.Stock_Audit', 'U') IS NOT NULL
    DROP TABLE dbo.Stock_Audit;
GO

CREATE TABLE dbo.Stock_Audit
(
    audit_id     INT IDENTITY(1,1) PRIMARY KEY,
    action_type  NVARCHAR(10) NOT NULL,   -- INSERT/UPDATE/DELETE
    action_time  DATETIME2(3) NOT NULL DEFAULT SYSUTCDATETIME(),
    stock_id     INT NULL,
    pharmacy_id  INT NULL,
    variant_id   INT NULL,
    medicine_id  INT NULL,
    old_quantity INT NULL,
    new_quantity INT NULL,
    old_price    DECIMAL(12,2) NULL,
    new_price    DECIMAL(12,2) NULL,
    old_exp_date DATE NULL,
    new_exp_date DATE NULL,
    info         NVARCHAR(400) NULL
);
GO