CREATE VIEW stock_expired
AS
SELECT
    stock_id,
    pharmacy_id,
    name_pharmacy,
    medicine_id,
    name_medicine,
    variant_id,
    dosage,
    quantity,
    price,
    exp_date
FROM stock_full
WHERE exp_date IS NOT NULL
  AND exp_date < CAST(GETDATE() AS date);
GO