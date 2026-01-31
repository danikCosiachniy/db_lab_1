IF DB_ID(N'PharmacyDB') IS NOT NULL
BEGIN
    ALTER DATABASE PharmacyDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE PharmacyDB;
END
GO

CREATE DATABASE PharmacyDB;
GO

USE PharmacyDB;
GO

CREATE TABLE dbo.Pharmacy
(
    pharmacy_id    INT IDENTITY(1,1) NOT NULL,
    name_pharmacy  NVARCHAR(150)     NOT NULL,
    phone          NVARCHAR(30)      NULL,
    address        NVARCHAR(250)     NULL,
    speciality     NVARCHAR(100)     NULL,

    CONSTRAINT PK_Pharmacy PRIMARY KEY CLUSTERED (pharmacy_id)
);
GO


CREATE TABLE dbo.Medicine
(
    medicine_id        INT IDENTITY(1,1) NOT NULL,
    name_medicine      NVARCHAR(200)     NOT NULL,
    manufactured       NVARCHAR(200)     NULL,
    indications        NVARCHAR(1000)    NULL,
    form               NVARCHAR(100)     NULL,
    contraindications  NVARCHAR(1000)    NULL,

    CONSTRAINT PK_Medicine PRIMARY KEY CLUSTERED (medicine_id)
);
GO

CREATE TABLE dbo.MedicineVariant
(
    variant_id   INT IDENTITY(1,1) NOT NULL,
    medicine_id  INT               NOT NULL,
    dosage       NVARCHAR(100)     NOT NULL,

    CONSTRAINT PK_MedicineVariant PRIMARY KEY CLUSTERED (variant_id),
    CONSTRAINT FK_MedicineVariant_Medicine
        FOREIGN KEY (medicine_id) REFERENCES dbo.Medicine(medicine_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
GO

CREATE TABLE dbo.Stock
(
    stock_id      INT IDENTITY(1,1) NOT NULL,
    variant_id    INT               NOT NULL,
    quantity      INT               NOT NULL,
    price         DECIMAL(12,2)     NOT NULL,
    exp_date      DATE              NULL,
    lot_date      DATE              NULL,
    medicine_id   INT               NOT NULL,
    pharmacy_id   INT               NOT NULL,

    CONSTRAINT PK_Stock PRIMARY KEY CLUSTERED (stock_id),

    CONSTRAINT FK_Stock_Variant
        FOREIGN KEY (variant_id) REFERENCES dbo.MedicineVariant(variant_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT FK_Stock_Medicine
        FOREIGN KEY (medicine_id) REFERENCES dbo.Medicine(medicine_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT FK_Stock_Pharmacy
        FOREIGN KEY (pharmacy_id) REFERENCES dbo.Pharmacy(pharmacy_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT CK_Stock_Quantity_NonNegative CHECK (quantity >= 0),
    CONSTRAINT CK_Stock_Price_NonNegative CHECK (price >= 0),
    CONSTRAINT CK_Stock_Dates CHECK (exp_date IS NULL OR lot_date IS NULL OR exp_date >= lot_date)
);
GO

CREATE INDEX IX_Stock_PharmacyId ON dbo.Stock(pharmacy_id);
CREATE INDEX IX_Stock_VariantId  ON dbo.Stock(variant_id);
CREATE INDEX IX_Stock_MedicineId ON dbo.Stock(medicine_id);
GO

